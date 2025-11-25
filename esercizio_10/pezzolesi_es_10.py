import requests
import json
from typing import List, Dict, Optional

def get_todos_by_user(user_id: int):
    """dshsretnh"""
    try:
        response = requests.get(
            f"https://jsonplaceholder.typicode.com/todos?userId={user_id}"
        )
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Errore nel recupero dei todo: {e}")
        return None
    
