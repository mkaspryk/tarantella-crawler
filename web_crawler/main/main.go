//============================================
// Name          :   main.go
// Author        :   Marcin Grzegorz Kaspryk
// Version       :   1.0.1
// Copyright     :   ASL
// Description   :   main - web_crawler
//============================================

package main

import (
	"log"
	"os"
	"strconv"

	"github.com/tarantella-crawler/web_crawler/scraping"
)

func main() {

	if len(os.Args) < 5 {
		os.Exit(-1)
	}

	// reading input parameters
	pageLang := os.Args[1]
	searchLength := os.Args[2]
	startPage := os.Args[3]
	path := os.Args[4]

	sl, err := strconv.Atoi(searchLength)
	if err != nil {
		log.Fatal(err)
	}

	flag := scraping.Crawl(pageLang, sl, startPage, path)

	os.Exit(flag)
}
