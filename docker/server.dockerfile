FROM golang:latest as builder

LABEL maintainer="Hector Morales <hector.morales.carnice@gmail.com>"

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /build/main main.go

######## Start a new stage from scratch #######
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /build/main .

# Command to run the executable
CMD ["./main"] 