package server

import (
	"log"
	"net"

	pb "github.com/HectorMRC/gRPC-App/proto"
	"google.golang.org/grpc"
)

func Listener() {
	// Set listener to port :8080
	lis, err := net.Listen(SERVER_PROTO, SERVER_PORT)

	if err != nil {
		// If listener cannot be set:
		log.Fatalf("Failed to listen: %v", err)
	}

	s := grpc.NewServer() // new grpc-server instance
	server := Server{}    // new EchoServiceServer instance

	// Registering server
	pb.RegisterEchoServiceServer(s, &server)

	// Execute service
	if err := s.Serve(lis); err != nil {
		// If service fails:
		log.Fatalf("Failed to serve: %v", err)
	}
}
