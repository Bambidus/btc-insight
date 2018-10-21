#!/bin/bash

mkdir -p  blockchain_data
./bitcoin-cli -conf="${PWD}/blockchain_data/bitcoin.conf" -datadir="${PWD}/blockchain_data"  ${*}

