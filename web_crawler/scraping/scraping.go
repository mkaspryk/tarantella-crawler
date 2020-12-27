package scraping

import (
	"fmt"
	"log"
	"net/http"

	"github.com/PuerkitoBio/goquery"
)

type webPages struct {
	crawled      map[string]bool
	urls         []string
	clearContent []string
	pageNumber   int
	searchLength int
	pageLang     string
}

// webPages constructor
func new(searchLength int, pageLang string) *webPages {

	return &webPages{
		crawled:      make(map[string]bool),
		searchLength: searchLength,
		pageNumber:   0,
		pageLang:     pageLang,
	}
}

// Crawl performs url and text content search
func Crawl(pageLang string, searchLength int, startPage string) {

	wb := new(searchLength, pageLang)
	wb.urls = append(wb.urls, startPage)

	for i := 0; i < wb.searchLength; i++ {
		doc := getPageContent(wb.urls[i])
		checkLang(doc, wb.pageLang)
		getLinksFromPage(doc, *wb)
	}
}

// Scraping the data from page
func scraping(pageContent string) (err error) {

	fmt.Println("here")
	return err
}

// GetPageContent gets the page content (urls, text)
func getPageContent(url string) goquery.Document {

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", resp.StatusCode, resp.Status)
	}

	// Load the HTML document
	doc, err := goquery.NewDocumentFromReader(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	return *doc
}

func checkLang(doc goquery.Document, pageLang string) bool {
	return false
}

func getLinksFromPage(doc goquery.Document, wb webPages) {

	doc.Find("body a").EachWithBreak(func(index int, item *goquery.Selection) bool {
		if index == 0 {
			return true
		}
		wb.pageNumber = index
		if wb.pageNumber <= wb.searchLength {
			linkTag := item
			link, _ := linkTag.Attr("href")
			wb.urls = append(wb.urls, link)
			return true
		}
		return false
	})
}
