GET {{host}}/

HTTP 200
Content-Type: text/html; charset=utf-8
[Asserts]
body contains "Hello, World! Woodpecker!"
duration < 2000
