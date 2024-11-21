from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def home():
    data = requests.get('http://backend:5000/api/data').json()
    return render_template('index.html', data=data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
