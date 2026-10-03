"""Basic testing utility for the main app. https://fastapi.tiangolo.com/tutorial/testing/"""
import asyncio
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_read_main():
    """Testing the root endpoint /"""
    response = client.get("/")
    assert response.status_code == 200
    assert "A simple tempersture converter API" in response.json()["msg"]


def test_convert_celsius():
    """Testing /celsius/{degree} endpoint"""
    response = client.get("/celsius/0")
    assert response.status_code == 200
    assert response.json() == {"degree_in_celsius": 0, "degree_in_fahrenheit": 32.0}


def test_convert_fahrenheit():
    """Testing /fahrenheit/{degree} endpoint"""
    response = client.get("/fahrenheit/32")
    assert response.status_code == 200
    assert response.json() == {"degree_in_fahrenheit": 32, "degree_in_c": 0.0}


def test_about():
    """Testing /about endpoint"""
    response = client.get("/about")
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "measurement unit converter"
    assert data["version"] == 0.1


def test_health():
    """Testing /health endpoint"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_form_page():
    """Testing /ui/form endpoint renders cloud providers"""
    response = client.get("/ui/form")
    assert response.status_code == 200
    for provider in ["AWS", "GCP", "Azure", "Hetzner"]:
        assert provider in response.text


def test_submit_form():
    """Testing /ui/submit endpoint"""
    payload = {
        "name": "Alice",
        "email": "alice@example.com",
        "cloud": "AWS",
        "otherCloud": ""
    }
    response = client.post("/ui/submit", data=payload)
    assert response.status_code == 200
    data = response.json()
    assert "Hello, Alice!" in data["message"]
    assert data["email"] == "alice@example.com"
    assert data["cloud"] == "AWS"


def test_get_form_data():
    """Testing /form/data endpoint"""
    response = client.get("/form/data")
    assert response.status_code == 200
    assert "data" in response.json()


def test_get_cloud_table():
    """Testing /ui/table endpoint"""
    response = client.get("/ui/table")
    assert response.status_code == 200
    assert "<table" in response.text or "<html" in response.text.lower()


def test_metrics():
    """Testing /metrics endpoint"""
    response = client.get("/metrics")
    assert response.status_code == 200
    assert "uptime" in response.json()


def test_get_a_orbits(monkeypatch):
    """Testing /a_orbits endpoint with mocked sleep"""
    async def mock_sleep(seconds):
        return None

    monkeypatch.setattr(asyncio, "sleep", mock_sleep)
    response = client.get("/a_orbits")
    assert response.status_code == 200
    data = response.json()
    assert "orbits" in data
    assert data["orbits"] == [5, 10, 3, 2, 11]


def test_get_s_orbits(monkeypatch):
    """Testing /s_orbits endpoint with mocked sleep"""
    async def mock_sleep(seconds):
        return None

    monkeypatch.setattr(asyncio, "sleep", mock_sleep)
    response = client.get("/s_orbits")
    assert response.status_code == 200
    data = response.json()
    assert "orbits" in data
    assert data["orbits"] == [5, 10, 3, 2, 11]
