# create docker container

docker run -ti --name forkedBtcInsight -p 30001-30020:30001-30020 ubuntu bash

#setup container

apt-get update
apt-get install -y libzmq3-dev build-essential libssl-dev git nano wget curl python python3 tmux 

#install nvm and node 8.12

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.bashrc
nvm install v8.12.0
node -v

#create project folder 
mkdir -p /home/forkedBitcoreInsight
cd /home/forkedBitcoreInsight

#copy  forkedbitcoin binaries into docker
#In host computer Jump to folder where forkedBTC place 
docker cp forkedBTC <containID>:/home/forkedBitcoreInsight

#check if it run
#inside docker container. Run bitcoind script onetime to test and also create
cd /home/forkedBitcoreInsight/forkedBTC
chmod +x bitcoind bitcoin-cli minerd

#Install bitcore from source
# The project will use 
# bitcore tag v4.1.1 
# bitcore-node tag v3.1.0
# insight-api tag v0.4.3
# insight-ui tag v0.4.0 ---> alias with ( insight prj) to implement block-explorer
cd /home/forkedBitcoreInsight
git clone https://github.com/bitpay/bitcore.git
cd bitcore
git checkout tags/v4.1.1
npm install

#create application node 
cd /home/forkedBitcoreInsight
./bitcore/bin/bitcore create mynode
cd /home/forkedBitcoreInsight/mynode
../bitcore/bin/bitcore install insight-api insight-ui


#create the node named mynode
cd /home/bitcoreService
./bitcore/bin/bitcore create mynode

#insight-api and insight-ui(insight)
cd mynode
../bitcore/bin/bitcore install insight-api insight-ui
#edit bitcore-node.json --> the same with example bitcore-node-example.json 
#docker cp bitcore-node-example.json 64059e2e1343:/home/forkedBitcoreInsight/mynode/bitcore-node.json

#Run this cmd to start  service ( forked-bitcoind , insight-api , and insight(insight-ui))
../bitcore/bin/bitcore start

#When bitcoind start OK. Wait for a moment then starting miner
cd /home/forkedBitcoreInsight/forkedBTC
#this step my be failed some times by error (internal error 500).Try some time to get succeed
./start_forked_miner.sh

#visit this link to view block-explorer
http://127.0.0.1:30001/insight


# to commit this docker container.Go to docker hub and create new repos
docker commit <container id> <username-dockerhub>/<repos-name>
docker push <username-dockerhub>/<repos-name>

#link
https://hub.docker.com/r/duonghuynhbaocr/forkedbtcandinsight/

#################################End Guide###################################################
#############################################################################################

# In the future maybe the version of insight-api and insight-ui change, or if you want to modify by your sefl
#try to clone the correct version of dependencies below, then overide them to the current
# equivalent src in folder node-modules of mynode (/home/forkedBitcoreInsight/mynode/node-modules)
#/home/forkedBitcoreInsight/mynode/node-modules/insight-api
#/home/forkedBitcoreInsight/mynode/node-modules/insight
#/home/forkedBitcoreInsight/mynode/node-modules/bitcore-node

#The project will use this api and here are the src version of bitcore-node
#------bitcore-node v3.1.0
cd /home/bitcoreService
https://github.com/bitpay/bitcore-node
cd bitcore-node
git checkout tags/v3.1.0
npm install

#The project will use this api and here are the src version of insight-api
#------insight-api v0.4.3
cd /home/bitcoreService
git clone https://github.com/bitpay/insight-api.git
cd insight-api
git checkout tags/v0.4.3
npm install
#The project will use this api and here are the src version of insight-ui
#-----insight-ui v0.4.0
cd /home/bitcoreService
git clone https://github.com/bitpay/insight.git
cd insight
git checkout tags/v0.4.0
npm install

#=====Some command to test if rpc ready or not=================

curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockcount","params":[]}' -H 'content-type:text/plain;' http://admin1:123@127.0.0.1:19001/
curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockchaininfo","params":[]}' -H 'content-type:text/plain;' http://admin1:123@127.0.0.1:19001/
