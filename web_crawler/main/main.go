package main

import (
	"fmt"
	"os"

	"github.com/tarantella-crawler/web_crawler/ipaddress"
	"github.com/tarantella-crawler/web_crawler/pagecontent"
	"github.com/tarantella-crawler/web_crawler/scraping"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	ipaddress := ipaddress.GetIPAddress("www.jabole.pl")

	fmt.Println("IP address: ", ipaddress)
	pageContent := pagecontent.GetPageContent("https://en.wikipedia.org/wiki/Bobby_Fischer")

	var urls string

	scraping.Scraping(pageContent, urls)

	f, err := os.Create("test.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	l, err := f.WriteString(page)
	if err != nil {
		fmt.Println(err)
		f.Close()
		return
	}
	fmt.Println(l, "bytes written successfully")
	err = f.Close()
	if err != nil {
		fmt.Println(err)
		return
	}
}
