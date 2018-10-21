#!/bin/bash

mkdir -p  blockchain_data
cp -rf bitcoin.conf ./blockchain_data
./bitcoind -conf="${PWD}/blockchain_data/bitcoin.conf" -datadir="${PWD}/blockchain_data" -debug=1 -printtoconsole

