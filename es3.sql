-- database: pezzolesi_3.db
CREATE TABLE APICOLTORE (
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

CREATE TABLE TIPOLOGIA (
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descrizione VARCHAR(50) NOT NULL
);

CREATE TABLE MIELE (
    id INT PRIMARY KEY,
    denominazione VARCHAR(50) NOT NULL,
    id_tipologia INT,
    FOREIGN KEY (id_tipologia) REFERENCES TIPOLOGIA(id)
);

CREATE TABLE APIARIO (
    codice_apiario INT PRIMARY KEY,
    numero_arnie INT NOT NULL,
    localita VARCHAR(50) NOT NULL,
    comune VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    regione VARCHAR(50) NOT NULL,
    id_apicoltore INT,
    FOREIGN KEY (id_apicoltore) REFERENCES APICOLTORE(id)
);

CREATE TABLE PRODUZIONE (
    id INT PRIMARY KEY,
    anno INT NOT NULL,
    quantita_prodotta FLOAT NOT NULL,
    id_miele INT,
    codice_apiario INT,
    totale_produzione INT,
    FOREIGN KEY (id_miele) REFERENCES MIELE(id),
    FOREIGN KEY (codice_apiario) REFERENCES APIARIO(codice_apiario)
);

-- Tipologia
INSERT INTO TIPOLOGIA (id, Descrizione, Nome) VALUES
(1, 'Monofloral', 'Miele prodotto prevalentemente da un unico fiore');
INSERT INTO TIPOLOGIA (id, Descrizione, Nome) VALUES
(2, 'Polyfloral', 'Miele di millefiori, raccolto da più specie floreali');
INSERT INTO TIPOLOGIA (id, Descrizione, Nome) VALUES
(3, 'Honeydew', 'Miele prodotto a partire dal melato (secrezioni di insetti)');

-- Apicoltore
INSERT INTO APICOLTORE (id, Nome) VALUES
(1, 'Marco Rossi');
INSERT INTO APICOLTORE (id, Nome) VALUES
(2, 'Lucia Bianchi');
INSERT INTO APICOLTORE (id, Nome) VALUES
(3, 'Alessandro Verdi');

-- Miele ------------------------------------------------
INSERT INTO MIELE (id, denominazione, id_tipologia) VALUES
(1, 'Acacia', 1);
INSERT INTO MIELE (id, denominazione, id_tipologia) VALUES
(2, 'Castagno', 1);
INSERT INTO MIELE (id, denominazione, id_tipologia) VALUES
(3, 'Millefiori', 2);
INSERT INTO MIELE (id, denominazione, id_tipologia) VALUES
(4, 'Eucalipto', 2);
INSERT INTO MIELE (id, denominazione, id_tipologia) VALUES
(5, 'Melata di Bosco', 3);

-- Apiario
INSERT INTO APIARIO (codice_apiario, numero_arnie, localita, comune, provincia, regione, id_apicoltore) VALUES
(100, 12, 'Fattoria Le Rose', 'San Pietro', 'Pisa', 'Toscana', 1);
INSERT INTO APIARIO (codice_apiario, numero_arnie, localita, comune, provincia, regione, id_apicoltore) VALUES
(101, 8, 'Colle Verde', 'Montevarchi', 'Arezzo', 'Toscana', 2);
INSERT INTO APIARIO (codice_apiario, numero_arnie, localita, comune, provincia, regione, id_apicoltore) VALUES
(102, 20, 'Bosco Alto', 'Vercelli', 'Vercelli', 'Piemonte', 3);
INSERT INTO APIARIO (codice_apiario, numero_arnie, localita, comune, provincia, regione, id_apicoltore) VALUES
(103, 5, 'Terrazza Sud', 'Verona', 'Verona', 'Veneto', 1);

-- Produzione
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(1, 2022, 120.5, 1, 100);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(2, 2022, 95.2, 2, 101);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(3, 2023, 210.0, 5, 102);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(4, 2023, 34.7, 3, 103);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(5, 2024, 150.0, 1, 102);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(6, 2024, 78.3, 2, 103);

-- Seleziona la quantità totale prodotta per anno. 
SELECT anno, SUM(quantita_prodotta) AS totale_produzione
FROM PRODUZIONE
GROUP BY anno;

-- Seleziona la produzione media per apiario.
SELECT codice_apiario, AVG(quantita_prodotta) AS produzione_media
FROM PRODUZIONE
GROUP BY codice_apiario;

-- Seleziona il numero di produzioni e la produzione totale per miele.
SELECT id_miele, COUNT(*) AS numero_produzioni, SUM(quantita_prodotta) AS produzione_totale
FROM PRODUZIONE 
GROUP BY id_miele;

-- Seleziona la produzione totale per miele nell'anno 2024.
SELECT id_miele, SUM(quantita_prodotta) AS produzione_totale_2024
FROM PRODUZIONE
WHERE anno = 2024
GROUP BY id_miele;

-- Seleziona il valore massimo e minimo di produzione per anno.
SELECT anno, MAX(quantita_prodotta) AS produzione_massima, MIN(quantita_prodotta) AS produzione_minima
FROM PRODUZIONE
GROUP BY anno;

-- Seleziona gli apiari la cui produzione totale supera 200.
SELECT codice_apiario, SUM(quantita_prodotta) AS produzione_totale
FROM PRODUZIONE
GROUP BY codice_apiario
HAVING SUM(quantita_prodotta) > 200;

-- Seleziona la produzione totale per tipologia di miele (typology_id).
SELECT T.id AS tipologia_id, T.Nome AS tipologia_nome, SUM(P.quantita_prodotta) AS produzione_totale
FROM PRODUZIONE P
JOIN MIELE M ON P.id_miele = M.id
JOIN TIPOLOGIA T ON M.id_tipologia = T.id
GROUP BY T.id, T.Nome;

-- Seleziona il numero di mieli per ciascuna tipologia.
SELECT T.id AS tipologia_id, T.Nome AS tipologia_nome, COUNT(M.id) AS numero_mieli
FROM TIPOLOGIA T
LEFT JOIN MIELE M ON T.id = M.id_tipologia
GROUP BY T.id, T.Nome;

-- Seleziona la produzione totale per apicoltore (beekeeper_id).
SELECT A.id AS apicoltore_id, A.Nome AS apicoltore_nome, SUM(P.quantita_prodotta) AS produzione_totale
FROM PRODUZIONE P
JOIN APIARIO AP ON P.codice_apiario = AP.codice_apiario
JOIN APICOLTORE A ON AP.id_apicoltore = A.id
GROUP BY A.id, A.Nome;

-- Seleziona la produzione media per arnia (produzione totale divisa per num_hives) per apiario.
SELECT AP.codice_apiario, AP.numero_arnie, 
        SUM(P.quantita_prodotta) / AP.numero_arnie AS produzione_media_per_arnia
FROM PRODUZIONE P
JOIN APIARIO AP ON P.codice_apiario = AP.codice_apiario
GROUP BY AP.codice_apiario, AP.numero_arnie;

-- Seleziona per ogni anno il conteggio delle produzioni con quantità maggiore di 100.
SELECT anno, COUNT(*) AS conteggio_produzioni
FROM PRODUZIONE
WHERE quantita_prodotta > 100
GROUP BY anno;

-- Seleziona per ogni miele e anno la somma delle quantità.
SELECT id_miele, anno, SUM(quantita_prodotta) AS somma_quantita
FROM PRODUZIONE
GROUP BY id_miele, anno;