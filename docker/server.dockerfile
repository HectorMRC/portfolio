FROM golang:latest

EXPOSE 9090

WORKDIR /app
COPY ./main .

CMD ./main