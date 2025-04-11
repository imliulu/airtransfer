package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
	_ "github.com/imliulu/airtransfer/router"
)

func main() {

	gin.SetMode(gin.ReleaseMode)
	fmt.Println("服务启动....")
}
