CREATE TABLE APICOLTORE (
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
);

CREATE TABLE TIPOLOGIA (
    id INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descrizione VARCHAR(50) NOT NULL,
);

CREATE TABLE MIELE (
    id INT PRIMARY KEY,
    denominazione VARCHAR(50) NOT NULL,
    id_tipologia INT,
    FOREIGN KEY (id_tipologia) REFERENCES TIPOLOGIA(id_tipologia)
);

CREATE TABLE APIARIO (
    codice_apiario INT PRIMARY KEY,
    numero_arnie INT NOT NULL,
    localita VARCHAR(50) NOT NULL,
    comune VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    regione VARCHAR(50) NOT NULL,
    id_apicoltore INT,
    FOREIGN KEY (id_apicoltore) REFERENCES BEEKEEPER(id_apicoltore)
);

CREATE TABLE PRODUZIONE (
    id INT PRIMARY KEY,
    anno INT NOT NULL,
    quantita_prodotta INT NOT NULL,
    id_miele INT,
    codice_apiario INT,
    FOREIGN KEY (id_miele) REFERENCES MIELE(id_miele),
    FOREIGN KEY (codice_apiario) REFERENCES APIARIO(codice_apiario)
);