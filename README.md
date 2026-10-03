# tinkertoy

This is a [FastAPI](https://fastapi.tiangolo.com/) based mini application.

## The Application

The application is a Python application running a FastAPI server. View the interactive Swagger API documentation when running locally at [http://localhost:8000/docs](http://localhost:8000/docs).

## Running Locally

Use [`uv`](https://docs.astral.sh/uv/) to run the development server locally:

```sh
uv run fastapi dev main.py
```

Alternatively, you can run using `uvicorn`:

```sh
uv run uvicorn main:app --reload
```

## Running Tests

Before deploying, run all tests using `uv`:

```sh
uv run pytest
```
