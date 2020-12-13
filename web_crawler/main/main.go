package main

import (
	"fmt"
	"os"
	"strings"

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

	pageContent := pagecontent.GetPageContent("https://www.sport.pl/skoki/7,65074,26555623,polscy-skoczkowie-chca-przelamac-fatum-najgorsze-miejsce-dla.html")

	// Find a substr
	titleStartIndex := strings.Index(pageContent, "<title>")
	if titleStartIndex == -1 {
		fmt.Println("No title element found")
		os.Exit(0)
	}
	// The start index of the title is the index of the first
	// character, the < symbol. We don't want to include
	// <title> as part of the final value, so let's offset
	// the index by the number of characers in <title>
	titleStartIndex += 7

	// Find the index of the closing tag
	titleEndIndex := strings.Index(pageContent, "</title>")
	if titleEndIndex == -1 {
		fmt.Println("No closing tag for title found.")
		os.Exit(0)
	}

	// (Optional)
	// Copy the substring in to a separate variable so the
	// variables with the full document data can be garbage collected
	pageTitle := []byte(pageContent[titleStartIndex:titleEndIndex])

	// Print out the result
	fmt.Printf("Page title: %s\n", pageTitle)

	fmt.Println(titleStartIndex)

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
