package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

// Puzzle tow of day two

func main() {
	fdata := readFile("input.txt")
	data := bytes.NewReader(fdata)
	// an array of integers to cache the input
	var arrayIntegers []int
	// cache results for second recalculation
	var arrayTotals []int
	total := 0
	scanner := bufio.NewScanner(data)
	for scanner.Scan() {
		arrayIntegers = append(arrayIntegers, parseInt(scanner.Text()))
		total += parseInt(scanner.Text())
		for _, n := range arrayTotals {
			if total == n {
				fmt.Println(total)
				os.Exit(0)
			}
		}
		arrayTotals = append(arrayTotals, total)
	}

	for {
		for _, val := range arrayIntegers {
			total += val
			for _, tot := range arrayTotals {
				if total == tot {
					fmt.Println(tot)
					os.Exit(0)
				}
			}
		}
	}

}

func readFile(filename string) []byte {
	f, err := os.Open(filename)
	if err != nil {
		log.Println("Failed to Open file")
		return []byte("")
	}
	data, err := ioutil.ReadAll(f)
	if err != nil {
		log.Println("Failed to read file")
		return []byte("")
	}
	f.Close()
	return data
}

func parseInt(x string) int {
	p, _ := strconv.Atoi(x)
	return p
}
