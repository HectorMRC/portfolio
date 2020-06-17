package server

import (
	"context"
	"fmt"
	"log"
	"strconv"

	pb "github.com/HectorMRC/gRPC-App/proto"
	set "golang.org/x/tools/container/intsets"
)

type status [3]bool

type Server struct {
	// Empty instance
	pb.UnimplementedEchoServiceServer
}

func (s *Server) Echo(ctx context.Context, in *pb.EchoRequest) (*pb.EchoResponse, error) {
	if in == nil {
		return nil, fmt.Errorf("Cannot handle null request")
	}

	selected := int(in.GetChanged())
	v := status{in.GetCheap(), in.GetQuality(), in.GetSpeed()}

	out := s.compute(v, selected)
	return out, nil
}
