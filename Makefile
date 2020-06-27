proxy:
	docker build -t portfolio/envoy -f ./docker/envoy.dockerfile .
	docker run -it -p 8080:8080 -p 9901:9901 --network=host portfolio/envoy

server:
	docker-compose build -f ./docker/docker-compose.yaml -p portfolio/server