package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("Started...")
	http.HandleFunc("/", handleHello)

	http.ListenAndServe(":8080", nil)
}

func handleHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello world")
}
