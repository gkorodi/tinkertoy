from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/celsius/{degree}")
def convert_celsius(degree: int):
    degree_in_f = (degree * (9/5)) + 32
    return {"degree_in_celsius": degree, "degree_in_fahrenheit": degree_in_f}

@app.get("/fahrenheit/{degree}")
def convert_fahrenheit(degree: int):
    degree_in_c = (degree - 32) * (5/9)
    return {"degree_in_fahrenheit": degree, "degree_in_c": degree_in_c}

