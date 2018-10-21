#!/bin/bash

#./bitcoind -conf="${PWD}/bitcoin.conf" -datadir="${PWD}/blockchain_data" -debug=1 -printtoconsole
./minerd -t 1 -o http://127.0.0.1:19001 -O admin1:123 --no-longpoll --no-getwork --no-stratum --coinbase-addr=15WJKDPuarqkNcvMrVAy8S442pLi5WYhmw
