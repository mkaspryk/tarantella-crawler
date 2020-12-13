package pagecontent

import (
	"io/ioutil"
	"log"
	"net/http"
)

// GetPageContent gets the page content and returns as string
func GetPageContent(url string) string {

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	bytesData, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}

	return string(bytesData)
}
