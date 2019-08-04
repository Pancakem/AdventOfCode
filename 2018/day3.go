package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
)

func makeBig() [][]int {
	big := make([][]int, 1000)

	for i := 0; i < 1000; i++ {
		big[i] = make([]int, 1000)
	}
	return big
}
func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	// fabric
	big := makeBig()
	overlaps := 0
	cache := make([]string, 0)
	// bigAgain := makeBig()
	for scanner.Scan() {
		text := scanner.Text()
		m := splitClaim(text)

		left, _ := strconv.Atoi(m[2])
		top, _ := strconv.Atoi(m[3])
		width, _ := strconv.Atoi(m[4])
		height, _ := strconv.Atoi(m[5])
		var i, j int

		for i = top; i < top+height; i++ {
			for j = left; j < left+width; j++ {
				big[i][j]++
			}
		}
		
		cache = append(cache, text)

	}

	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++ {
			if big[i][j] > 1 {
				overlaps++
			}
		}
	}
	fmt.Println(overlaps)
	
d:	for _, text := range cache {
		m := splitClaim(text)

		id, _ := strconv.Atoi(m[1])
		left, _ := strconv.Atoi(m[2])
		top, _ := strconv.Atoi(m[3])
		width, _ := strconv.Atoi(m[4])
		height, _ := strconv.Atoi(m[5])

		for i := top; i < top+height; i++ {
			for j := left; j < left+width; j++ {
				if big[i][j] > 1 {
					continue d
				}
				big[i][j]++
			}
		}
		fmt.Println(id)
		return
	}
}

//split claim
func splitClaim(claim string) []string {
	re := regexp.MustCompile(`^#(\d+)\s*@\s(\d+),(\d+):\s*(\d+)x(\d+)$`)
	return re.FindStringSubmatch(claim)
}
