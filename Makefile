proxy:
	docker build -t portfolio/envoy -f ./docker/envoy.dockerfile .
	docker run -it -p 8080:8080 -p 9901:9901 --network=host portfolio/envoy

proto:
	# Server site - protobuf
	protoc --go_out=plugins=grpc:server --go_opt=paths=source_relative proto/echo.proto
	# Client site - protobuf
	protoc -I=proto/ echo.proto --js_out=import_style=commonjs,binary:client --grpc-web_out=import_style=commonjs,mode=grpcwebtext:client
	
#client:
#	npm install
#	npx webpack client.js