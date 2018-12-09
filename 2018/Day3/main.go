package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
)

func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	// fabric
	big := make([][]int, 1000)
	overlaps := 0

	for i := 0; i < 1000; i++ {
		big[i] = make([]int, 1000)
	}

	for scanner.Scan() {
		t := scanner.Text()
		m := getID(t)

		// fmt.Println(&m)
		// println(m[2])
		// println(m[3])
		// println(m[4])

		left, _ := strconv.Atoi(m[2])
		// println(left)
		top, _ := strconv.Atoi(m[3])
		// println(top)
		width, _ := strconv.Atoi(m[4])
		// println(width)
		height, _ := strconv.Atoi(m[5])
		// println(height)
		var i, j int

		for i = left; i < left+width; i++ {
			for j = top; j < top+height; j++ {
				big[i][j]++
				//if big[i][j] == 2 {
					if big[i][j] == 2 {
					overlaps++
				}
			}
		}

	}
	fmt.Println(overlaps)
}

//split claim id
func getID(id string) []string {
	re := regexp.MustCompile(`^#(\d+)\s*@\s(\d+),(\d+):\s*(\d+)x(\d+)$`)
	return re.FindStringSubmatch(id)
}
