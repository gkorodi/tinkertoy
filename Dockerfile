
FROM python:3.14

WORKDIR /code

COPY ./ /code

RUN apt update && apt upgrade -y
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && ln -s /root/.local/bin/uv /usr/local/bin/uv
RUN uv sync

CMD ["uv", "run","fastapi", "run", "main.py", "--port", "8001"]
