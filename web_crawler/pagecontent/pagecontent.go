package pagecontent

import (
	"errors"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
)

// GetPageContent gets the page content and returns as string
func GetPageContent(url string) (pageContent string, err error) {

	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()
	if resp.StatusCode == 200 {
		bytesData, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			return "", err
		}
		return string(bytesData), err
	}
	err = errors.New("Can't get the page content: " + url + " , HTTP code: " + strconv.Itoa(resp.StatusCode))
	return "", err
}
