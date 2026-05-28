-- Active: 1779979463001@@localhost@5432@azienda_ospedaliera@public
DROP DATABASE IF EXISTS Azienda_Ospedaliera;

DROP TABLE IF EXISTS Pazienti, Medici, Farmaci, Prescrizioni, Farmaci;

-- Creazione Database
CREATE DATABASE  Azienda_Ospedaliera;

-- Creazione Tabella Pazienti
CREATE TABLE Pazienti (
    ID_Paziente VARCHAR(50) PRIMARY KEY,
    Codice_Fiscale CHAR(16) UNIQUE,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL
);

-- Creazione Tabella Medici
CREATE TABLE Personale_Medico (
    ID_Medico VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Organizzazione VARCHAR(255) NOT NULL,
    Tipo VARCHAR(50) NOT NULL
);

-- Creazione Tabella Farmaci (Catalogo)
CREATE TABLE Farmaci (
    Codice_AIC VARCHAR(20) PRIMARY KEY,
    Nome_Farmaco VARCHAR(255) NOT NULL
);

-- Creazione Tabella Prescrizioni (La tabella che unisce tutto)
CREATE TABLE Prescrizioni (
    ID_Prescrizione VARCHAR(50) PRIMARY KEY,
    ID_Paziente VARCHAR(50) NOT NULL,
    ID_Medico VARCHAR(50) NOT NULL,
    Codice_AIC VARCHAR(20) NOT NULL,
    Data_Emissione DATE NOT NULL,
    Quantita INT NOT NULL,
    Dettaglio TEXT NOT NULL,
    -- Definizione dei vincoli di chiave esterna (Foreign Keys)
    FOREIGN KEY (ID_Paziente) REFERENCES Pazienti(ID_Paziente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Medico) REFERENCES Medici(ID_Medico) ON DELETE CASCADE,
    FOREIGN KEY (Codice_AIC) REFERENCES Farmaci(Codice_AIC) ON DELETE CASCADE
);

-- Inserimento del paziente
INSERT INTO Pazienti (ID_Paziente, Codice_Fiscale, Nome, Cognome) 
VALUES ('PT-001', 'VRDLGU80M15H501Z', 'Luigi', 'Verdi');

-- Inserimento medico
INSERT INTO Medici (ID_Medico, Nome, Cognome, Organizzazione) 
VALUES ('MED-120101', 'Mario', 'Bianchi', 'Sistema TS');

-- Inserimento farmaco
INSERT INTO Farmaci (Codice_AIC, Nome_Farmaco) 
VALUES ('012745098', 'TACHIPIRINA*10CPR RIV 1000MG');

-- Inserimento Prescrizione
INSERT INTO Prescrizioni (ID_Prescrizione, ID_Paziente, ID_Medico, Codice_AIC, Data_Emissione, Quantita, Dettaglio) 
VALUES ('PRF-2026-9999', 'PT-001', 'MED-120101', '012745098', '2026-05-11 11:30:00', 1, 'Paracetamolo 1000mg, 1 conf');

SELECT pr.Data_Emissione, pr.ID_Prescrizione, fa.Nome_Farmaco, pr.Dettaglio,
    me.Cognome AS medico
FROM Prescrizioni pr
JOIN Pazienti pa ON pr.ID_Paziente = pa.ID_Paziente
JOIN Farmaci fa ON pr.Codice_AIC = fa.Codice_AIC
JOIN Medici me ON pr.ID_Medico = me.ID_Medico
WHERE pa.Nome = 'Luigi' AND pa.Cognome = 'Verdi'
ORDER BY pr.Data_Emissione DESC;

-- Esportazione per anonimizzazione
SELECT pa.Nome, pa.Cognome, fa.Nome_Farmaco
FROM Prescrizioni pr 
JOIN Pazienti pa ON pr.ID_Paziente = pa.ID_Paziente
JOIN Farmaci fa ON pr.Codice_AIC = fa.Codice_AIC;