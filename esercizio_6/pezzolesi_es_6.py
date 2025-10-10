import sqlite3
from typing import List, Tuple

# Connessione al database SQLite 'libreria.db'
conn: sqlite3.Connection = sqlite3.connect("libreria.db")
cursor: sqlite3.Cursor = conn.cursor()
