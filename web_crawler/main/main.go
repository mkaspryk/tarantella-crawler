package main

import (
	"os"

	"github.com/tarantella-crawler/web_crawler/scraping"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	if len(os.Args) < 4 {
		os.Exit(-1)
	}

	pageLang := os.Args[1]
	searchLength := os.Args[2]
	startPage := os.Args[3]

	scraping.Crawler(pageLang, searchLength, startPage)

	// ipaddress := ipaddress.GetIPAddress("www.jabole.pl")
	// fmt.Println("IP address: ", ipaddress)
	// f, err := os.Create("test.txt")
	// if err != nil {
	// 	fmt.Println(err)
	// 	return
	// }
	// l, err := f.WriteString(pageContent)
	// if err != nil {
	// 	fmt.Println(err)
	// 	f.Close()
	// 	return
	// }
	// fmt.Println(l, "bytes written successfully")
	// err = f.Close()
	// if err != nil {
	// 	fmt.Println(err)
	// 	return
	// }
}
