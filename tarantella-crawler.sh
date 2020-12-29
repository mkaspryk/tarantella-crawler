#!/usr/bin/bash

#============================================
# Name          :   tarantella-crawler.sh
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
# Copyright     :   ASL
# Description   :   Main program
#============================================

echo "==============================================================="
echo "                      tarantella-crawler                       "
echo "==============================================================="

path=$(pwd)

dictionary=$path/data/dictionaries/en.txt
formatted_web_content=$path/data/formatted_web_content
formatted_web_content_pages=$path/data/formatted_web_content/pages/*
results=$path/data/results

lang="en"
searchLength=10
startPage="https://en.wikipedia.org/wiki/Ski_jumping"

echo "Setted lang: $lang"
echo "Setted search length: $searchLength"
echo "Setted start page: $startPage"

CUDA_DEVICE=$path/bin/./cuda_device_finder
WORD_FINDER=$path/bin/./word_finder
WEB_CRAWLER=$path/bin/./web_crawler
CREATE=$path/database/./create_table.py
INSERT=$path/database/./insert_data.py

echo "Running web_crawler"
echo "..."

$WEB_CRAWLER $lang $searchLength $startPage $formatted_web_content 

FLAG=$?

if [[ $FLAG -ne 0 ]]
then
echo "Error - check lang !"
exit 
fi

echo "done"

echo ""
$CUDA_DEVICE
set_cuda_device=$?
echo ""

echo "Running word_finder"
echo "..."

dic_size=1383
table_name="data"

x=0
while IFS= read -r size
do
    for f in $formatted_web_content_pages
    do
        echo $formatted_web_content/pages/$x.txt
        $WORD_FINDER $set_cuda_device $dic_size $size $dictionary $formatted_web_content/pages/$x.txt $results/$x.txt
        FLAG=$?
        if [[ $FLAG -eq 0 ]] 
        then
        echo "done"
        else
        echo "Error! Error flag: $FLAG"
        fi
        rm -r $formatted_web_content/pages/$x.txt
        x=$((x+1))
        break
    done
done < $formatted_web_content/count.txt

#$CREATE $table_name $dictionary
echo ""
#$INSERT $TABLE_NAME $results
