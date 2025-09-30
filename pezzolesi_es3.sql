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
    quantita_prodotta INT NOT NULL,
    id_miele INT,
    codice_apiario INT,
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
(1, 2022, 120.5, 100, 1);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(2, 2022, 95.2, 101, 3);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(3, 2023, 210.0, 102, 5);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(4, 2023, 34.7, 103, 2);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(5, 2024, 150.0, 100, 3);
INSERT INTO PRODUZIONE (id, anno, quantita_prodotta, id_miele, codice_apiario) VALUES
(6, 2024, 78.3, 101, 4);

-- Seleziona la quantità totale prodotta per anno.

-- Seleziona la produzione media per apiario.
-- Seleziona il numero di produzioni e la produzione totale per miele.
-- Seleziona la produzione totale per miele nell'anno 2024.
-- Seleziona il valore massimo e minimo di produzione per anno.
-- Seleziona gli apiari la cui produzione totale supera 200.
-- Seleziona la produzione totale per tipologia di miele (typology_id).
-- Seleziona il numero di mieli per ciascuna tipologia.
-- Seleziona la produzione totale per apicoltore (beekeeper_id).
-- Seleziona la produzione media per arnia (produzione totale divisa per num_hives) per apiario.
-- Seleziona per ogni anno il conteggio delle produzioni con quantità maggiore di 100.
-- Seleziona per ogni miele e anno la somma delle quantità.