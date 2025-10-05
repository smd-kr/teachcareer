Bu proje kapsamında, Trendyol/Hepsiburada/Amazon benzeri bir e-ticaret platformu için veritabanı modeli tasarlandı. Öncelikle müşteri, ürün, sipariş, satıcı, kategori gibi temel tablolar belirlendi. Daha sonra bu tablolar arasındaki ilişkiler (1-N, N-1) kuruldu.

Karşılaşılan Sorunlar:

Sipariş ve sipariş detay tablosu arasındaki ilişkiyi kurarken, ürünün fiyat bilgisini hem ürün tablosunda hem de sipariş detayında saklama ihtiyacı doğdu. Bunun sebebi, sipariş anındaki fiyatın ileride değişse bile kayıtta sabit kalması gerektiğidir.

Stok güncellemesi için tetikleyici (trigger) yazılabilir, ancak bu örnekte sadece UPDATE ile manuel yapıldı.


Sonuç:

Çeşitli SQL komutları (CREATE, INSERT, UPDATE, DELETE, TRUNCATE) kullanıldı.

GROUP BY, HAVING ve JOIN’lerle karmaşık raporlamalar yapıldı.

Gerçek dünyadaki e-ticaret mantığına uygun kapsamlı bir veritabanı tasarlandı.
Musteri (id, ad, soyad, email, sehir, kayit_tarihi)

Urun (id, ad, fiyat, stok, kategori_id, satici_id)

Kategori (id, ad)

Satici (id, ad, adres)

Siparis (id, musteri_id, tarih, toplam_tutar, odeme_turu)

Siparis_Detay (id, siparis_id, urun_id, adet, fiyat)


İlişkiler:

Bir müşteri birden fazla sipariş verebilir. (Musteri 1—N Siparis)

Bir sipariş birden fazla ürün içerebilir. (Siparis 1—N Siparis_Detay, Siparis_Detay N—1 Urun)

Bir ürün bir kategoride bulunur. (Urun N—1 Kategori)

Bir ürün bir satıcıya aittir. (Urun N—1 Satici
