package main

import "fmt"

var numb int

func main() {
	x := []int{48,2,96,86,3,68,57,82,63,70,37,34,83,27,19,97,9,17,1,-1,5,-100,200}
	fmt.Println ("Searching minimum from ", x)

	for i := range x {
		i = x[i]
//		fmt.Println("i", i, "numb", numb)
		if (i < numb){
			numb = i
		}
	}

	fmt.Println("Minimum numb is ", numb)
} 
