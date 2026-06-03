-- Active: 1779979463001@@localhost@5432@azienda_ospedaliera@public
-- DROP DATABASE IF EXISTS Azienda_Ospedaliera;
-- Creazione Database
-- CREATE DATABASE Azienda_Ospedaliera;

DROP TABLE IF EXISTS Pazienti, Medici, Farmaci, Prescrizioni CASCADE;

-- Creazione Tabella Pazienti
CREATE TABLE Pazienti (
    Codice_Fiscale CHAR(16) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL
);

-- Creazione Tabella Medici
CREATE TABLE Medici (
    ID_Medico VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL
);

-- Creazione Tabella Farmaci
CREATE TABLE Farmaci (
    Codice_AIC VARCHAR(20) PRIMARY KEY,
    Nome_Farmaco VARCHAR(255) NOT NULL
);

-- Creazione Tabella Prescrizioni
CREATE TABLE Prescrizioni (
    ID_Prescrizione VARCHAR(50) PRIMARY KEY,
    Codice_Fiscale CHAR(16) NOT NULL,
    ID_Medico VARCHAR(50) NOT NULL,
    Codice_AIC VARCHAR(20) NOT NULL,
    Data_Emissione DATE NOT NULL,
    Quantita INT NOT NULL,
    Dettaglio TEXT NOT NULL,
    Organizzazione VARCHAR(255) NOT NULL,
    -- Definizione dei vincoli di chiave esterna (Foreign Keys)
    FOREIGN KEY (Codice_Fiscale) REFERENCES Pazienti(Codice_Fiscale) ON DELETE CASCADE,
    FOREIGN KEY (ID_Medico) REFERENCES Medici(ID_Medico) ON DELETE CASCADE,
    FOREIGN KEY (Codice_AIC) REFERENCES Farmaci(Codice_AIC) ON DELETE CASCADE
);

-- Inserimento dei pazienti
INSERT INTO Pazienti (Codice_Fiscale, Nome, Cognome) 
VALUES ('VRDLGU80M15H501Z', 'Luigi', 'Verdi'),
('RSSMRA80A01H501U', 'Mario', 'Rossi'),
('BNCGNN75T10F205A', 'Giovanni', 'Bianchi'),
('FRRLRA92A01H501F', 'Laura', 'Ferrari');

-- Inserimento medico
INSERT INTO Medici (ID_Medico, Nome, Cognome) 
VALUES ('MED-120101', 'Mario', 'Bianchi'),
('MED-120102', 'Elena', 'Russo');

-- Inserimento farmaco
INSERT INTO Farmaci (Codice_AIC, Nome_Farmaco) 
VALUES ('012745098', 'TACHIPIRINA*10CPR RIV 1000MG'),
('035154035', 'AUGMENTIN*12CPR RIV 875MG+125MG'),
('025218041', 'OKI*30BUST 80MG'),
('031835012', 'BRUFEN*30CPR RIV 600MG');

-- Inserimento Prescrizione
INSERT INTO Prescrizioni (ID_Prescrizione, Codice_Fiscale, ID_Medico, Codice_AIC, Data_Emissione, Quantita, Dettaglio, Organizzazione) 
VALUES ('PRF-2026-9999', 'RSSMRA80A01H501U', 'MED-120101', '012745098', '2026-05-11', 1, 'Paracetamolo 1000mg, 1 conf', 'Sistema TS'),
('PRF-2026-0001', 'RSSMRA80A01H501U', 'MED-120101', '012745098', '2026-05-12', 2, 'Tachipirina 1000mg, 2 confezioni - Trattamento iperpiressia', 'Sistema TS'),
('PRF-2026-0002', 'VRDLGU80M15H501Z', 'MED-120101', '035154035', '2026-05-13', 1, 'Augmentin compresse, 1 confezione - Terapia antibiotica', 'Sistema TS'),
('PRF-2026-0003', 'BNCGNN75T10F205A', 'MED-120101', '025218041', '2026-05-14', 1, 'Oki bustine, 1 confezione per cefalea tensiva', 'Sistema TS'),
('PRF-2026-0004', 'FRRLRA92A01H501F', 'MED-120101', '031835012', '2026-05-15', 1, 'Brufen 600mg, 1 confezione per algie articolari', 'Sistema TS'),
('PRF-2026-0005', 'RSSMRA80A01H501U', 'MED-120101', '035154035', '2026-05-16', 1, 'Augmentin compresse, 1 confezione - Terapia di follow-up', 'Sistema TS'),
('PRF-2026-0006', 'VRDLGU80M15H501Z', 'MED-120102', '012745098', '2026-05-17', 1, 'Tachipirina 1000mg, 1 confezione al bisogno', 'Sistema TS'),
('PRF-2026-0007', 'BNCGNN75T10F205A', 'MED-120102', '025218041', '2026-05-18', 2, 'Oki 80mg bustine, 2 confezioni - Trattamento antinfiammatorio', 'Sistema TS'),
('PRF-2026-0008', 'FRRLRA92A01H501F', 'MED-120102', '031835012', '2026-05-19', 1, 'Brufen 600mg, 1 confezione post-estrattiva', 'Sistema TS'),
('PRF-2026-0009', 'RSSMRA80A01H501U', 'MED-120102', '012745098', '2026-05-20', 1, 'Paracetamolo 1000mg, 1 conf per stato influenzale', 'Sistema TS');

-- Query di esempio
SELECT pr.Data_Emissione, pr.ID_Prescrizione, fa.Nome_Farmaco, pr.Dettaglio, pr.Organizzazione, me.Cognome AS medico
FROM Prescrizioni pr
JOIN Pazienti pa ON pr.ID_Paziente = pa.ID_Paziente
JOIN Farmaci fa ON pr.Codice_AIC = fa.Codice_AIC
JOIN Medici me ON pr.ID_Medico = me.ID_Medico
WHERE pa.Nome = 'Luigi' AND pa.Cognome = 'Verdi'
ORDER BY pr.Data_Emissione DESC;