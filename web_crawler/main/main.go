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

	if len(os.Args) < 2 {
		os.Exit(-1)
	}

	lang := os.Args[1]

	var flag int8
	var urls []string

	ipaddress := ipaddress.GetIPAddress("www.jabole.pl")

	fmt.Println("IP address: ", ipaddress)
	pageContent := pagecontent.GetPageContent("https://stackoverflow.com/questions/4278293/how-do-i-return-from-func-main-in-go")

	scraping.Scraping(flag, pageContent, urls, lang)

	f, err := os.Create("test.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	l, err := f.WriteString(pageContent)
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
