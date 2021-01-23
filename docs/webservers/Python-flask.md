# Python Flask Web App

## Project setup

Project structure may look as follows:

```bash
my-application 
├── LICENSE
├── README.MD
├── requirements.txt # Similar to package.json NodeJS
├── main.py # Similar to app.js for NodeJS
├── utils
├── tests
├── config
├── routes
├── services
├── db
└── core
```

The main.py contains a sample web application:

```python
# main.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World!'

if __name__ == '__main__':
    app.run()
```

Run requirements first `pip install -r requirements.txt`

Afterwards run `python main.py`

When it is run, the webserver is listening on localhost `http://127.0.0.1:5000/`. This is not production ready.

## Tools for running in production

Tools used for running Flask in production are:

+ Gunicorn (default port 8000)
+ uWSGI
+ Gevent
+ Twisted Web

These are production grade webservers used to host multiple types of applications.

To run our app in Gunicorn, we can run specific Gunicorn commands.

```python
# main  == file name 
# app   == app variable in application file 
gunicorn main:app

# Spawning more workers (processes)
gunicorn main:app -w 2
```

## Lab exercise

1. "Change description in app.py."

    ```bash
    # my solution
    # edit the file in vi
    sudo vi app.py

    # their solution
    sudo sed -i 's/8080/5000/g' app.py
    ```

2. "Stop previously running app and run app.py with Gunicorn"

    ```bash
    # Run with single worker
    sudo pip install gunicorn; gunicorn app:app
    ```

3. "Run Gunicorn with 3 workers in background and confirm with url"

    ```bash
    # my solution
    gunicorn app:app -w 3

    # their solution
    nohup gunicorn app:app -w 3 & and curl localhost:8000

    # notes on nohup  

    # Nohup is short for “No Hangups.” It's not a command # that you run by itself. Nohup is a supplemental 
    # command that tells the Linux system not to stop 
    # another command once it has started.
    ```
