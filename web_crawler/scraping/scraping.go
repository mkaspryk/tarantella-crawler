//============================================
// Name          :   scraping.go
// Author        :   Marcin Grzegorz Kaspryk
// Version       :   1.0.1
// Copyright     :   ASL
// Description   :   scraping - web_crawler main package
//============================================

package scraping

import (
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"

	"github.com/PuerkitoBio/goquery"
)

// webPages structure
type webPages struct {
	wordsCount   []int
	urls         []string
	clearContent [][]string
	pageNumber   int
	searchLength int
	pageLang     string
	pageName     []string
}

// webPages constructor
func new(searchLength int, pageLang string) *webPages {

	return &webPages{
		searchLength: searchLength,
		pageNumber:   0,
		pageLang:     pageLang,
		clearContent: make([][]string, (searchLength + 1)),
	}
}

// Crawl performs url and text content search
func Crawl(pageLang string, searchLength int, startPage string, path string) (flag int) {

	wb := new(searchLength, pageLang)
	wb.urls = append(wb.urls, startPage)
	flag = 0
	for i := 0; i <= wb.searchLength; i++ {
		//time.Sleep(100 * time.Millisecond)
		if wb.pageNumber < i {
			break
		}
		doc := getPageContent(wb.urls[i])
		if !checkLang(doc, wb.pageLang) {
			flag = -2
			if wb.pageNumber == 0 {
				break
			}
			continue
		}
		pageName := pageURL(wb.urls[i], &*wb)
		getLinksFromPage(doc, &*wb, pageName)
		pageText := strings.ToLower(doc.Text())
		scrap(&*wb, pageText, i)
	}
	saveToFile(&*wb, path)
	return flag
}

// getPageContent gets the page content (urls, text)
func getPageContent(url string) goquery.Document {

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", resp.StatusCode, resp.Status)
	}

	// Load the HTML document with goquery
	doc, err := goquery.NewDocumentFromReader(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	return *doc
}

// checkLang checks the lang of page
func checkLang(doc goquery.Document, pageLang string) bool {

	found := false
	doc.Find("html").Each(func(index int, item *goquery.Selection) {
		if item.AttrOr("lang", "") == pageLang {
			found = true
		}
	})
	return found
}

// pageURL returns website name
func pageURL(url string, wb *webPages) string {

	found := 0
	tmp := ""
	for i := 0; i < len(url); i++ {
		if url[i] == 47 {
			found++
		}
		if found == 3 {
			for j := 0; j < i; j++ {
				tmp += string(url[j])
			}
			break
		}
	}
	wb.pageName = append(wb.pageName, tmp)
	return tmp
}

// getLinksFromPage gets the links from page
func getLinksFromPage(doc goquery.Document, wb *webPages, pageURL string) {

	doc.Find("body a").EachWithBreak(func(index int, item *goquery.Selection) bool {
		if index == 0 {
			return true
		}
		if wb.pageNumber <= wb.searchLength {
			wb.pageNumber++
			linkTag := item
			link, _ := linkTag.Attr("href")
			if link[0] != 104 && link[0] != 47 {
				wb.pageNumber--
			} else {
				found := false
				for j := 0; j < wb.pageNumber; j++ {
					if wb.urls[j] == link {
						found = true
						wb.pageNumber--
						break
					}
				}
				if !found {
					if link[0] == 47 {
						link = pageURL + link
					}
					wb.urls = append(wb.urls, link)
				}
			}
			return true
		}
		return false
	})
}

// scrap clears the text content and splits the words
func scrap(wb *webPages, pageText string, index int) {

	wordsIndex := 0
	save := false
	wordLong := 0
	var tmp string
	for i := 0; i < len(pageText); i++ {

		if pageText[i] > 96 && pageText[i] < 123 || pageText[i] == 45 || pageText[i] == 39 && wordLong < 46 {
			tmp += string(pageText[i])
			wordLong++
			save = true
		} else if save {
			save = false
			wb.clearContent[index] = append(wb.clearContent[index], tmp)
			tmp = ""
			wordLong = 0
			wordsIndex++
		}
	}
	wb.wordsCount = append(wb.wordsCount, wordsIndex)
}

// saveToFile saves formatted content to files
func saveToFile(wb *webPages, path string) {

	count := ""
	pageNames := ""
	pageFiles := ""

	for i := 0; i < wb.pageNumber; i++ {

		count += strconv.Itoa(wb.wordsCount[i])
		count += "\n"
		pageNames += wb.pageName[i]
		pageNames += "\n"
		pageFiles += wb.urls[i]
		pageFiles += "\n"
		pageWords := ""
		for j := 0; j < wb.wordsCount[i]; j++ {
			pageWords += wb.clearContent[i][j]
			pageWords += "\n"
		}

		f, err := os.Create(path + "/pages/" + strconv.Itoa(i) + ".txt")
		if err != nil {
			log.Fatal(err)
			return
		}
		f.WriteString(pageWords)
		f.Close()
	}

	f1, err1 := os.Create(path + "/count.txt")
	if err1 != nil {
		log.Fatal(err1)
		return
	}
	f1.WriteString(count)
	f1.Close()

	f2, err2 := os.Create(path + "/pageNames.txt")
	if err2 != nil {
		log.Fatal(err2)
		return
	}
	f2.WriteString(pageNames)
	f2.Close()

	f3, err3 := os.Create(path + "/pageFiles.txt")
	if err3 != nil {
		log.Fatal(err3)
		return
	}
	f3.WriteString(pageFiles)
	f3.Close()
}
