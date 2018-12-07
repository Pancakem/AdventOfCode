package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"os"
	"strings"
)

func checkSum(data io.Reader) {
	scanner := bufio.NewScanner(data)
	twice := 0
	thrice := 0
	for scanner.Scan() {
		x := scanner.Text()
		var count int
		twie := 0
		trie := 0
		for _, char := range x {
			count = strings.Count(x, string(char))
			if count == 2 {
				twie++
				if twie < 2 {
					twice++
				}

			} else if count == 3 {
				trie++
				if trie < 2 {
					thrice++
				}
			}
			count = 0
		}

		fmt.Println(thrice * twice)

	}
}
func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	scanner := bufio.NewScanner(f)
	arrayID := make([]string, 0)

	for scanner.Scan() {
		x := scanner.Text()

		for _, val := range arrayID {
			r, num := diff(x, val)
			if num == 1 {
				fmt.Println(string(r))
			}
		}

		arrayID = append(arrayID, x)
	}
	f.Close()
}

func removeDifferentChars(a string, b string) ([]rune, int) {
	count := 0
	same := make([]rune, 0)
	for in := range a {
		if a[in] != b[in] {
			count++
		} else {
			same = append(same, rune(a[in]))
		}
	}

	return same, count
}
