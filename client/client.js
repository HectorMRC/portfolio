const { EchoRequest, EchoResponse } = require("./echo_pb")
const { EchoClient } = require("./echo_grpc_web_pb")
var client = new EchoClient('http://localhost:8080');

var request = new EchoRequest()

request.setMessage("Testing Echo Client")
client.echo(request, {}, (err, response) => {
    console.log("Result of Echo : ",response.getMessage())
})