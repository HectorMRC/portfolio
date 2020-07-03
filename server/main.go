package main

import (
	"log"
	"net"

	echo "github.com/HectorMRC/portfolio/server"
	pb "github.com/HectorMRC/portfolio/server/proto"
	"google.golang.org/grpc"
)

func main() {
	srv_port := echo.ServicePort
	lis, err := net.Listen("tcp", srv_port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpc_server := grpc.NewServer()
	echo_server := echo.ImplementedEchoServer()

	pb.RegisterEchoServer(grpc_server, echo_server)
	log.Fatalf("server listening to: %s", srv_port)
	if err := grpc_server.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
