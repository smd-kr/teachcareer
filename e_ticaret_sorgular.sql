-- En çok sipariş veren 5 müşteri
SELECT m.ad, m.soyad, COUNT(s.id) AS siparis_sayisi
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id
ORDER BY siparis_sayisi DESC
LIMIT 5;

-- En çok satılan ürünler
SELECT u.ad, SUM(sd.adet) AS toplam_adet
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY u.id
ORDER BY toplam_adet DESC;

-- En yüksek cirosu olan satıcılar
SELECT sa.ad, SUM(sd.fiyat * sd.adet) AS toplam_ciro
FROM Satici sa
JOIN Urun u ON sa.id = u.satici_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY sa.id
ORDER BY toplam_ciro DESC;

-- Şehirlere göre müşteri sayısı
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;

-- Kategori bazlı toplam satışlar
SELECT k.ad AS kategori, SUM(sd.fiyat * sd.adet) AS toplam_satis
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.id;

-- Aylara göre sipariş sayısı
SELECT DATE_TRUNC('month', tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY ay
ORDER BY ay;

-- Siparişlerde müşteri + ürün + satıcı bilgisi
SELECT s.id AS siparis_id, m.ad AS musteri_adi, u.ad AS urun_adi, sa.ad AS satici_adi
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Satici sa ON u.satici_id = sa.id;

-- Hiç satılmamış ürünler
SELECT u.ad
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL;

-- Hiç sipariş vermemiş müşteriler
SELECT m.ad, m.soyad
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;

-- İleri Seviye: En çok kazanç sağlayan ilk 3 kategori
SELECT k.ad, SUM(sd.fiyat * sd.adet) AS toplam_kazanc
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.id
ORDER BY toplam_kazanc DESC
LIMIT 3;

-- Ortalama sipariş tutarını geçen siparişler
SELECT * FROM Siparis
WHERE toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis);

-- En az bir kez elektronik ürün satın alan müşteriler
SELECT DISTINCT m.ad, m.soyad
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Kategori k ON u.kategori_id = k.id
WHERE k.ad = 'Elektronik';