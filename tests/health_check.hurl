GET {{host}}/health

HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.status" == "healthy"
jsonpath "$.service" == "woodpecker-ci-demo"
duration < 1000
