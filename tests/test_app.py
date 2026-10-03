"""Basic testing utility for the main app. https://fastapi.tiangolo.com/tutorial/testing/"""
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_read_main():
    """Testing the root"""
    response = client.get("/")
    assert response.status_code == 200
    assert "A simple tempersture converter API" in response.json()["msg"]


def test_form_page():
    """Testing the form page renders cloud providers"""
    response = client.get("/ui/form")
    assert response.status_code == 200
    for provider in ["AWS", "GCP", "Azure", "Hetzner"]:
        assert provider in response.text


