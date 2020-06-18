package echo

import (
	"context"
	"log"

	pb "github.com/HectorMRC/portfolio/proto"
)

type EchoServer struct {
	pb.UnimplementedEchoServer
}

func (server *EchoServer) Echo(ctx context.Context, in *pb.EchoRequest) (out *pb.EchoResponse, err error) {
	log.Printf("Received: %v", in.GetMessage())
	out = &pb.EchoResponse{Message: in.GetMessage()}
	return
}
