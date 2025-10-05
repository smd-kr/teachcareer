-- TABLOLARIN OLUŞTURULMAS
CREATE TABLE Musteri (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    sehir VARCHAR(50),
    kayit_tarihi DATE
);

CREATE TABLE Kategori (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(50)
);

CREATE TABLE Satici (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100),
    adres VARCHAR(150)
);

CREATE TABLE Urun (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100),
    fiyat DECIMAL(10,2),
    stok INT,
    kategori_id INT REFERENCES Kategori(id),
    satici_id INT REFERENCES Satici(id)
);

CREATE TABLE Siparis (
    id SERIAL PRIMARY KEY,
    musteri_id INT REFERENCES Musteri(id),
    tarih DATE,
    toplam_tutar DECIMAL(10,2),
    odeme_turu VARCHAR(50)
);

CREATE TABLE Siparis_Detay (
    id SERIAL PRIMARY KEY,
    siparis_id INT REFERENCES Siparis(id),
    urun_id INT REFERENCES Urun(id),
    adet INT,
    fiyat DECIMAL(10,2)
);

-- VERİ EKLEME
INSERT INTO Musteri (ad, soyad, email, sehir, kayit_tarihi)
VALUES
('Ali', 'Yılmaz', 'ali@example.com', 'İstanbul', '2024-01-10'),
('Ayşe', 'Demir', 'ayse@example.com', 'Ankara', '2024-02-15'),
('Mehmet', 'Kara', 'mehmet@example.com', 'İzmir', '2024-03-20');

INSERT INTO Kategori (ad) VALUES ('Elektronik'), ('Giyim'), ('Ev & Yaşam');

INSERT INTO Satici (ad, adres) VALUES
('TeknoMarket', 'İstanbul'),
('Moda Dünyası', 'Ankara'),
('Evİçi', 'İzmir');

INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id)
VALUES
('Telefon', 15000, 20, 1, 1),
('Laptop', 25000, 10, 1, 1),
('T-Shirt', 250, 50, 2, 2),
('Koltuk', 5000, 5, 3, 3);

INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu)
VALUES
(1, '2024-04-10', 15250, 'Kredi Kartı'),
(2, '2024-05-12', 25000, 'Havale');

INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat)
VALUES
(1, 1, 1, 15000),
(1, 3, 1, 250),
(2, 2, 1, 25000);

-- UPDATE ÖRNEĞİ
UPDATE Urun SET stok = stok - 1 WHERE id = 1; -- Telefon satıldı

-- DELETE ÖRNEĞİ
DELETE FROM Urun WHERE id = 4; -- Koltuk ürünü silindi

-- TRUNCATE ÖRNEĞİ
-- TRUNCATE TABLE Siparis_Detay;
