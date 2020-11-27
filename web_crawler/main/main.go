package main

import (
	"fmt"
	"os"

	"github.com/tarantella-crawler/web_crawler/pagecontent"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	page := pagecontent.GetPageContent("https://en.wikipedia.org/wiki/Bobby_Fischer")
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
