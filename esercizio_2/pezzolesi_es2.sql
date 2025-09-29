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
    FOREIGN KEY (id_apicoltore) REFERENCES APICOLTORE(id_apicoltore)
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

SELECT * FROM APICOLTORE
;
SELECT Nome FROM APICOLTORE WHERE id = 1
;
SELECT * FROM APIARIO WHERE regione = 'Lombardia'
;
SELECT codice_apiario, numero_arnie FROM APIARIO WHERE numero_arnie > 10
;
SELECT codice_apiario, localita FROM APIARIO WHERE id_apicoltore = 2
;
SELECT * FROM MIELE WHERE id_tipologia = 3
;
SELECT denominazione FROM MIELE WHERE id = 5
;
SELECT * FROM PRODUZIONE WHERE anno = 2024
;
SELECT * FROM PRODUZIONE WHERE codice_apiario = 102
;
SELECT * FROM PRODUZIONE WHERE id_miele = 3 AND anno = 2023
;

--Seleziona tutti gli apicoltori.
--Seleziona il nome dell'apicoltore con id = 1.
--Seleziona tutti gli apiari nella regione 'Lombardia'.
--Seleziona codice e numero_arnie degli apiari con più di 10 arnie.
--Seleziona codice e località degli apiari posseduti dall'apicoltore con id = 2.
--Seleziona tutti i mieli appartenenti alla tipologia con id = 3.
--Seleziona la denominazione del miele con id = 5.
--Seleziona tutte le produzioni dell'anno 2024.
--Seleziona tutte le produzioni per l'apiario con codice = '102'.
--Seleziona le produzioni per il miele con id = 3 nell'anno 2023.