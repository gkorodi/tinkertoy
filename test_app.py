"""Basic testing utility for the main app. https://fastapi.tiangolo.com/tutorial/testing/"""
from fastapi.testclient import TestClient
from app import app

client = TestClient(app)


def test_read_main():
    """Testing the root"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"msg": "Hello World"}

