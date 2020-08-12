from flask import Flask
from datetime import datetime
from flask import render_template

import re


app = Flask(__name__)

# https://code.visualstudio.com/docs/python/tutorial-flask


@app.route("/")
def home():
    return "Hello, Flask"


@app.route("/hello/<name>")
def hello_there(name = None):
    return render_template(
        "hello_there.html",
        name=name,
        date=datetime.now()
    )
