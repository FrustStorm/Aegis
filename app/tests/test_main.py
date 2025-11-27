import os
import sys



sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


from app.main import app

def test_home_route():
    response = app.test_client().get("/")
    assert response.status_code == 200
    assert b"Welcome" in response.data


def test_health_route():
    response = app.test_client().get("/health")
    assert response.status_code == 200
    assert b"healthy" in response.data
