-- Tabella Prodotto
CREATE TABLE Prodotto (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    prezzo REAL NOT NULL
);

-- Tabella Ordine
CREATE TABLE Ordine (
    id INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    cliente_nome TEXT NOT NULL
);

-- Tabella OrdineProdotto (associativa)
CREATE TABLE OrdineProdotto (
    id INTEGER PRIMARY KEY,
    ordine_id INTEGER NOT NULL,
    prodotto_id INTEGER NOT NULL,
    quantita INTEGER NOT NULL,
    FOREIGN KEY (ordine_id) REFERENCES Ordine(id),
    FOREIGN KEY (prodotto_id) REFERENCES Prodotto(id)
);

-- ========================================
-- INSERIMENTO DATI
-- ========================================

-- Inserimento Prodotti
INSERT INTO Prodotto (id, nome, prezzo) VALUES (1, 'Notebook', 12.5);
INSERT INTO Prodotto (id, nome, prezzo) VALUES (2, 'Penna a sfera', 1.2);
INSERT INTO Prodotto (id, nome, prezzo) VALUES (3, 'Zaino', 28.0);
INSERT INTO Prodotto (id, nome, prezzo) VALUES (4, 'Agenda', 7.5);
INSERT INTO Prodotto (id, nome, prezzo) VALUES (5, 'Quaderno', 5.0);

-- Inserimento Ordini
INSERT INTO Ordine (id, data, cliente_nome) VALUES (1, '2025-10-01', 'Anna Verdi');
INSERT INTO Ordine (id, data, cliente_nome) VALUES (2, '2025-10-02', 'Marco Neri');
INSERT INTO Ordine (id, data, cliente_nome) VALUES (3, '2025-10-03', 'Anna Verdi');

-- Inserimento OrdineProdotto
INSERT INTO OrdineProdotto (id, ordine_id, prodotto_id, quantita) VALUES (1, 1, 1, 2);
INSERT INTO OrdineProdotto (id, ordine_id, prodotto_id, quantita) VALUES (2, 1, 2, 5);
INSERT INTO OrdineProdotto (id, ordine_id, prodotto_id, quantita) VALUES (3, 2, 3, 1);
INSERT INTO OrdineProdotto (id, ordine_id, prodotto_id, quantita) VALUES (4, 3, 4, 2);
INSERT INTO OrdineProdotto (id, ordine_id, prodotto_id, quantita) VALUES (5, 3, 2, 3);

-- ========================================
-- QUERY DI ESEMPIO
-- ========================================

-- 1. Elenco dei prodotti che costano meno di 10
SELECT * 
FROM Prodotto 
WHERE prezzo < 10;

-- 2. Elenco dei prodotti ordinati in un determinato ordine (esempio: ordine id = 1)
SELECT p.id, p.nome, p.prezzo, op.quantita
FROM Prodotto p
JOIN OrdineProdotto op ON p.id = op.prodotto_id
WHERE op.ordine_id = 1;

-- 3. Numero di ordini per ogni cliente
SELECT cliente_nome, COUNT(*) AS numero_ordini
FROM Ordine
GROUP BY cliente_nome;

-- 4. Media dei prezzi dei prodotti
SELECT AVG(prezzo) AS prezzo_medio
FROM Prodotto;

-- 5. Quantità totale venduta per ogni prodotto
SELECT p.id, p.nome, SUM(op.quantita) AS quantita_totale
FROM Prodotto p
JOIN OrdineProdotto op ON p.id = op.prodotto_id
GROUP BY p.id, p.nome;

-- 6. Elenco di tutti i prodotti con la quantità totale venduta (NULL per quelli mai venduti)
SELECT p.id, p.nome, SUM(op.quantita) AS quantita_totale
FROM Prodotto p
LEFT JOIN OrdineProdotto op ON p.id = op.prodotto_id
GROUP BY p.id, p.nome;

-- 7. Prodotti con quantità totale venduta maggiore di 5
SELECT p.id, p.nome, SUM(op.quantita) AS quantita_totale
FROM Prodotto p
JOIN OrdineProdotto op ON p.id = op.prodotto_id
GROUP BY p.id, p.nome
HAVING SUM(op.quantita) > 5;

-- 8. Totale speso per ogni cliente
SELECT o.cliente_nome, SUM(p.prezzo * op.quantita) AS totale_speso
FROM Ordine o
JOIN OrdineProdotto op ON o.id = op.ordine_id
JOIN Prodotto p ON op.prodotto_id = p.id
GROUP BY o.cliente_nome;

-- ========================================
-- VERIFICA DATI (query opzionali)
-- ========================================

-- Visualizza tutti i prodotti
-- SELECT * FROM Prodotto;

-- Visualizza tutti gli ordini
-- SELECT * FROM Ordine;

-- Visualizza tutte le associazioni ordine-prodotto
-- SELECT * FROM OrdineProdotto;
