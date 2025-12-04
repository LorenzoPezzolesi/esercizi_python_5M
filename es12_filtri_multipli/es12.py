import requests

def cerca_libri_autore(author_id):
	try:
		response = requests.get(f'http://localhost:3001/books?author_id={author_id}')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None
	
def cerca_libri_genere(genre_id):
	try:
		response = requests.get(f'http://localhost:3001/books?genre_id={genre_id}')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None
	
def cerca_libri_autore_disponibili(author_id):
	try:
		response = requests.get(f'http://localhost:3001/books?author_id={author_id}&available=True')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None

def get_autore(author_id):
	try:
		response = requests.get(f'http://localhost:3001/authors?id={author_id}')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None
	
def get_genere(genre_id):
	try:
		response = requests.get(f'http://localhost:3001/genres?id={genre_id}')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None
	
# 1. Cerca Libri di un Autore
autore = get_autore(1)
libri_autore = cerca_libri_autore(1)

print(f'Libri di {autore[0]['name']}:')
for libro in libri_autore:
	print(f'  - {libro['title']}')

# 2. Filtra per Disponibilità
libri_disp = cerca_libri_autore_disponibili(1)
print('Libri disponibili:')
for libro in libri_disp:
	print(f'  - {libro['title']}')

# 3. Conta Pagine Totali
totale_pagine = 0
for libro in libri_disp:
	totale_pagine += libro['pages']
print(f'Pagine totali disponibili: {totale_pagine}')

# 4. Libri per Genere
genere = get_genere(101)
libri_genere = cerca_libri_genere(101)

print(f'Genere: {genere[0]['name']}:')
print(f'Numero di libri: {len(libri_genere)}')

