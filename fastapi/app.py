from pydantic import BaseModel
import time
from fastapi import FastAPI

app = FastAPI()

# Sample solution to measure uptime, but a more robust
# solution would be to use a library like psutil
start_time = time.time()


def c2f(c: int):
    """Convert Celsius to Fahrenheit"""
    return (c * 9 / 5) + 32


def f2c(f: int):
    """Convert Fahrenheit to Celsius"""
    return (f - 32) * 5 / 9


@app.get("/")
async def home():
    """The index route should always be available, but not always functional"""
    return {"msg": "A simple tempersture converter API. See /docs page, autogenerated by FastAPI for more details."}


@app.get("/celsius/{degree}")
def convert_celsius(degree: int):
    """Convert from Celsius to Fahrenheit"""
    return {"degree_in_celsius": degree, "degree_in_fahrenheit": c2f(degree)}


@app.get("/fahrenheit/{degree}")
def convert_fahrenheit(degree: int):
    """Convert from Fahrenhei to Celsius to t"""
    return {"degree_in_fahrenheit": degree, "degree_in_c": f2c(degree)}


@app.get('/exception')
async def thrown_an_exception():
    """
    Generate an exception, by opening a non-existing file, and handle it.
     Return success all the time.
     This is just to test backend functionality
    """
    my_file = open("my_file.txt", "r", encoding="UTF-8")
    return "OK"  # This will never be reached, as the file does not exist

    # try:
    #     my_file = open("my_file.txt", "r", encoding="UTF-8")
    #     # do some file operations
    # except FileNotFoundError:
    #     print("File not found.")
    # except PermissionError:
    #     print("Permission denied.")
    # finally:
    #     #  the file will be closed no matter what
    #     my_file.close()
    #     # Always a good idea to close resources that may or maynot have been left open
    # return "completed"


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


class AboutResponse(BaseModel):
    name: str
    description: str | None = None
    version: float


@app.get('/about')
async def info_about() -> AboutResponse:
    """Provide basic (hardcoded) application information."""
    return AboutResponse(name="measurement unit converter",
                         description="API to convert between various measurement units, and back.",
                         version=0.1)


@app.get('/health')
async def health_check():
    """Return a 200, indicating that everything is healthy."""
    return {'status': 'healthy'}


@app.get('/metrics')
async def metrics():
    """
    Return local statistics. 
    Usually this endpoint supplies information to 
    an observability platform, like Prometheus.
    """
    return {'uptime': int(time.time() - start_time)}
