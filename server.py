from flask import Flask, request

app = Flask(__name__)

@app.route("/hello")
def flip():
	print(request.remote_addr)
	return "", 200
