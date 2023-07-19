title: Golang Read File Line by Line
date: 2020-02-04 20:51:49 +0800
update: ""
author: linx
tags:
- go
categories:
- go
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


Golang Read File Line by Line
<!--more-->

```go
func handle(textfile string) error {
    // 1. open file
    file, err := os.Open(textfile)
	if err != nil {
		log.Printf("Cannot open text file: %s, err: [%v]", textfile, err)
		return err
	}
    defer file.Close()
    //2. new a scanner to scan file
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
		line := scanner.Text() // or
		//line := scanner.Bytes()
		
        // do somthing
		fmt.Printf("%s\n", line)
	}

	if err := scanner.Err(); err != nil {
		log.Printf("Cannot scanner text file: %s, err: [%v]", textfile, err)
		return err
	}

	return nil
}

```
