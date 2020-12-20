package scraping

import (
	"fmt"
	"log"
	"strconv"

	"github.com/tarantella-crawler/web_crawler/pagecontent"
)

type WebPages struct {
	urls         []string
	clearContent []string
	pageNumber   int
	searchLength int
	pageLang     string
}

// Crawler program main func
func Crawler(pageLang string, searchLength string, startPage string) {

	var wb WebPages
	wb.pageLang = pageLang
	sl, err := strconv.Atoi(searchLength)
	if err != nil {
		log.Fatal(err)
	}
	wb.searchLength = sl
	wb.urls = append(wb.urls, startPage)
	for i := 0; i < wb.searchLength; i++ {
		pageContent, err := pagecontent.GetPageContent(wb.urls[i])
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(pageContent)
		err = scraping(pageContent)
	}
}

// Scraping the data from page
func scraping(pageContent string) (err error) {

	//checkLang(&flag, pageContent, lang)

	fmt.Println("here")
	return err
}

func checkLang(flag *int8, pageContent string, lang string) {

	i := 0
	//search for doctype
	for {
		if pageContent[i] == 60 && pageContent[i+2] == 68 {
			break
		}
		i++
	}
	//search for html
	for {
		if pageContent[i] == 60 && pageContent[i+1] == 104 && pageContent[i+2] == 116 {
			break
		}
		i++
	}
	//search for lang
	for {
		// not defined lang
		if pageContent[i] == 62 {
			*flag = -3
			return
		}
		if pageContent[i] == 108 && pageContent[i+1] == 97 && pageContent[i+2] == 110 && pageContent[i+3] == 103 && pageContent[i+4] == 61 {
			i = i + 5
			for {
				if pageContent[i] == 34 {
					i++
					break
				}
				i++
			}
			j := 0
			for {
				if pageContent[i] == 34 || j == 2 {
					*flag = 0
					return
				}
				if lang[j] != pageContent[i] {
					*flag = -2
					return
				}
				j++
				i++
			}
		}
		i++
	}
}
