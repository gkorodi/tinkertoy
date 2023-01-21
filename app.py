"""Simple FastAPI server, for temperaturue conversion."""
from typing import Union
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def read_root():
    """The index route should always be available, but not always functional"""
    return {"msg": "Hello World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, query_string: Union[str, None] = None):
    """Demonstrate URL and Query String based parameter handling."""
    return {"item_id": item_id, "query_string": query_string}


@app.get("/celsius/{degree}")
def convert_celsius(degree: int):
    """Convert from Fahrenheit to Celsius"""
    degree_in_f = (degree * (9 / 5)) + 32
    return {"degree_in_celsius": degree, "degree_in_fahrenheit": degree_in_f}


@app.get("/fahrenheit/{degree}")
def convert_fahrenheit(degree: int):
    """Convert from Celsius to Fahrenheit"""
    degree_in_c = (degree - 32) * (5 / 9)
    return {"degree_in_fahrenheit": degree, "degree_in_c": degree_in_c}


@app.get('/exception')
async def thrown_an_exception():
    """
    Generate an exception, by opening a non-existing file, and handle it.
     Return success all the time.
     This is just to test backend functionality
    """

    try:
        my_file = open("my_file.txt", "r", encoding="UTF-8")
        # do some file operations
    except FileNotFoundError:
        print("File not found.")
    except PermissionError:
        print("Permission denied.")
    finally:
        #  the file will be closed no matter what
        my_file.close()
        # Always a good idea to close resources that may or maynot have been left open
    return "completed"


def divide(a, b):
    """Demonstrate throwing our own exception """
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero.")
    return a / b


@app.get('/myownexception')
async def throw_myown_exception():
    try:
        # To generate our own thrown exception
        result = divide(5, 0)
        print(result)
    except ZeroDivisionError as e:
        print(e)

    return "completed"

@app.get('/about')
async def info_about():
    """Provide latest build/version information and some environment variables."""
    # TODO: Create info datastructure
    pass

@app.get('/health')
async def info_about():
    """Return a 200, indicating that everything is healthy."""
    # TODO: Should be more intelligent, for AWS and Prometheus monitoring
    pass