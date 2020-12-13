#!/usr/bin/bash

#============================================
# Name          :   tarantella-crawler.sh
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
# Copyright     :   ASL
# Description   :   Main program
#============================================

echo "=================================="
echo "Hello there, here your tarantella"
echo "=================================="

PATH="/home/mgk/repo/go/src/github.com/tarantella-crawler"

DICTIONARY=$PATH/data/dictionaries/en.txt
DIC_SIZE=1383
FORMATTED_WEB_CONTENT=$PATH/data/formatted_web_content/test.txt
TEST_SIZE=8
RESULTS=$PATH/data/results/page_count.txt
TABLE_NAME="data2"

CUDA_DEVICE=$PATH/bin/./cuda_device_finder
WORD_FINDER=$PATH/bin/./word_finder

CREATE=$PATH/database/./create_table.py
INSERT=$PATH/database/./insert_data.py

echo ""
$CUDA_DEVICE
SET_CUDA_DEVICE=$?
echo ""

$CREATE $TABLE_NAME $DICTIONARY

echo "Running word_finder"
echo "..."

$WORD_FINDER $SET_CUDA_DEVICE $DIC_SIZE $TEST_SIZE $DICTIONARY $FORMATTED_WEB_CONTENT $RESULTS
FLAG=$?
echo "Flag: $FLAG"

echo ""
$INSERT $TABLE_NAME $RESULTS
