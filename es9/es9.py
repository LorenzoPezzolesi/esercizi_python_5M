import requests

def prendi_posts_utente(id_utente):
	try:
		response = requests.get(f'https://jsonplaceholder.typicode.com/posts?userId={id_utente}')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None

def prendi_commenti_post(id_post):
	try:
		response = requests.get(f'https://jsonplaceholder.typicode.com/posts/{id_post}/comments')
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None

def aggiungi_commento_post(commento):
	try:
		response = requests.post('https://jsonplaceholder.typicode.com/comments', json=commento)
		response.raise_for_status()  # Solleva un'eccezione per codici di stato HTTP 4xx/5xx
		return response.json()
	except requests.RequestException as e:
		print(f"Si è verificato un errore: {e}")
		return None

# 1. Recupera tutti i post pubblicati dall'utente con ID = 1 e stampali.
post_utente = prendi_posts_utente(1)
if post_utente is not None:
	for post in post_utente:
		print(f"ID Post: {post['id']}, Titolo: {post['title']}")

# 2. Recupera i commenti per il primo post e stampali.
if post_utente is not None and len(post_utente) > 0:
	id_post = post_utente[0]['id']
	commenti_post = prendi_commenti_post(id_post)
	if commenti_post is not None:
		for commento in commenti_post:
			print(f"- {commento['name']}: {commento['body']}")

# 3. Aggiungi un nuovo commento al primo post.
nuovo_commento = {
	"postId": 1,
	"name": "Nuovo Commentatore",
	"email": "nuovo@example.com",
	"body": "Questo è un commento aggiunto tramite API!"
}
risposta = aggiungi_commento_post(nuovo_commento)
if risposta is not None:
	print(f"Commento aggiunto con successo: {risposta}")