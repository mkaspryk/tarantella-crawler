#!/usr/bin/bash

#============================================
# Name          :   tarantella-crawler.sh
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.1.1
# Copyright     :   ASL
# Description   :   Main program
#============================================

echo "==============================================================="
echo "                      tarantella-crawler                       "
echo "==============================================================="

package="tarantella crawler"

path=$(pwd)

dictionary=$path/data/dictionaries/en.txt
formatted_web_content=$path/data/formatted_web_content
formatted_web_content_pages=$path/data/formatted_web_content/pages/*
results=$path/data/results

lang="en"
searchLength=10
startPage="https://en.wikipedia.org/wiki/Ski_jumping"
tableName="data"

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - detects offensive language at the web pages"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-l, --lang                specifies a language of searched words"
      echo "-p, --page                specifies a start page (URL only starting with https:// or http://)"
      echo "-s, --search              specifies a search length (numbers of pages to visit)"
      echo "-t, --table               specifies an output table in pages_data database"
      exit 0
      ;;
    -l|--lang)
      shift
      if test $# -gt 0; then
        export lang=$1
      else
        echo "No language specified"
        exit 1
      fi
      shift
      ;;
    -p|--page)
      shift
      if test $# -gt 0; then
        export startPage=$1
      else
        echo "No page specified"
        exit 1
      fi
      shift
      ;;
    -s|--searchLength)
      shift
      if test $# -gt 0; then
        export searchLength=$1
      else
        echo "No search length specified"
        exit 1
      fi
      shift
      ;;
    -t|--table)
      shift
      if test $# -gt 0; then
        export tableName=$1
      else
        echo "No table specified"
        exit 1
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done

echo "Setted lang: $lang"
echo "Setted search length: $searchLength"
echo "Setted start page: $startPage"
echo "Setted table: $tableName"

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

echo ""

# creates table in database
echo "Creating table"
echo "..."
$CREATE $tableName $dictionary

echo "Inserting data to table"
echo "..."
#inserts data to table in database
$INSERT $tableName $results $formatted_web_content

rm -r $results/*
