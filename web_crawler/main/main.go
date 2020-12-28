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

	pageLang := os.Args[1]
	searchLength := os.Args[2]
	startPage := os.Args[3]
	path := os.Args[4]

	sl, err := strconv.Atoi(searchLength)
	if err != nil {
		log.Fatal(err)
	}

	scraping.Crawl(pageLang, sl, startPage, path)
}
