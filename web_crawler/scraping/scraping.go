package scraping

import "fmt"

// Scraping the data from page
func Scraping(flag int8, pageContent string, urls []string, lang string) []string {

	checkLang(&flag, pageContent, lang)

	var cleanContent []string

	fmt.Println(flag)

	return cleanContent
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
					fmt.Println("here")
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
