package main

import (
	"log"
	"net"

	echo "github.com/HectorMRC/portfolio/echo"
	pb "github.com/HectorMRC/portfolio/proto"
	"google.golang.org/grpc"
)

func main() {
	lis, err := net.Listen("tcp", echo.ServicePort)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpc_server := grpc.NewServer()
	echo_server := echo.ImplementedEchoServer()

	pb.RegisterGreeterServer(grpc_server, echo_server)
	if err := grpc_server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
