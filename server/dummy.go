package server

import (
	"context"
	"log"
	"strconv"
	"time"

	pb "github.com/HectorMRC/gRPC-App/proto"
	"google.golang.org/grpc"
)

func Dummy(args []string) {
	// Set up a connection to the server.
	conn, err := grpc.Dial(DUMMY_URL_ACCESS, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("Did not connect: %v", err)
	} else {
		log.Printf("Did connect to: %s", DUMMY_URL_ACCESS)
	}

	defer conn.Close()
	c := pb.NewEchoServiceClient(conn)

	// Contact the server and print out its response.
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var request pb.EchoRequest
	for index, value := range args {
		switch index {
		case 0:
			request.Cheap = value != BASE_CASE
		case 1:
			request.Quality = value != BASE_CASE
		case 2:
			request.Speed = value != BASE_CASE
		case 3:
			if i, err := strconv.Atoi(value); err == nil {
				request.Changed = int32(i) % 3
			}
		}
	}

	// log.Printf("Echo request %+v\n", request)

	var response *pb.EchoResponse
	response, err = c.Echo(ctx, &request)
	if err != nil {
		log.Fatalf("Could not sent request: %v", err)
	}

	log.Printf("Got response as %v,%v,%v", response.GetCheap(), response.GetQuality(), response.GetSpeed())
}
