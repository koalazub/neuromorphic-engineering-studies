package main

import (
	"fmt"
	"log/slog"
)

func main() {
	// var max int = 12
	// multTable(max)

	var items []int = []int{1, 45, 7, 456, 33, 6, 5}
	sortMinMax(items)

}

func sortMinMax(items []int) {
	n := len(items)
	for i := range n {
		for j := range n - i - 1 {
			if items[j] > items[j+1] {
				items[j], items[j+1] = items[j+1], items[j]
			}
		}
	}
	slog.Info("items sorted", "INFO", items)
}

func multTable(max int) {
	fmt.Print("   |")
	for i := 0; i <= max; i++ {
		fmt.Printf("%3d", i)
	}

	fmt.Println()
	fmt.Println("---|-------------------")

	for v := 0; v <= max; v++ {
		fmt.Printf("%3d | ", v)
		for i := 0; i <= max; i++ {
			fmt.Printf("%3d ", i*v)
		}
		fmt.Println()
	}

}
