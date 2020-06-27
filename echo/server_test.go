package echo

import (
	"context"
	"testing"
	"time"

	pb "github.com/HectorMRC/portfolio/proto"
	"google.golang.org/grpc"
)

func TestService(t *testing.T) {
	conn, err := grpc.Dial(testAddress, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		t.Errorf("Cannot connect: %v", err)
	}

	defer conn.Close()
	client := pb.NewEchoClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	want := "Testing Echo Service"
	request := &pb.EchoRequest{Message: want}

	if got, err := client.Echo(ctx, request); err != nil {
		t.Errorf("Got an error from server: %v", err)
	} else if got.GetMessage() != want {
		t.Errorf("Got message %s, want %s", got.GetMessage(), want)
	}
}
