package main

import (
	"fmt"
	//"math"
)

func main() {
	fmt.Print("Enter a number, ft: ")
	var input float64
	fmt.Scanf("%f", &input)
	output := input * float64(0.3048)
//	routput := math.Round(output)
	foutput := fmt.Sprintf("%.2f", output)
	fmt.Println("Meters:", foutput)
}
