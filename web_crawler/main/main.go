package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/tarantella-crawler/web_crawler/scraping"
)

func main() {

	fmt.Println("Hello")
	if len(os.Args) < 4 {
		os.Exit(-1)
	}

	pageLang := os.Args[1]
	searchLength := os.Args[2]
	startPage := os.Args[3]

	sl, err := strconv.Atoi(searchLength)
	if err != nil {
		log.Fatal(err)
	}

	scraping.Crawl(pageLang, sl, startPage)

}
