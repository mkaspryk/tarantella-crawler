#!/usr/bin/bash

#============================================
# Name          :   build.sh
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
# Copyright     :   ASL
# Description   :   Build script
#============================================

path="/home/mgk/repo/go/src/github.com/tarantella-crawler"

word_finder=$path/word_finder/

local_device_finder=$path/local_device_finder/cuda_device_finder/

web_crawler=$path/web_crawler/main/

echo "Building tarantella-crawler..."

cd $word_finder 

make clean

make -j4

cd $local_device_finder 

make clean

make -j4

cd $web_crawler

make clean

make build -j4
