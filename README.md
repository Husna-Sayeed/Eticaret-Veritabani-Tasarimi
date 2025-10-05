# 🛒 E-Ticaret Veritabani Tasarimi ve Uygulamasi

## 🎯 Projenin Amacı

Bu proje, çevrim içi alışveriş sistemlerinde müşteri, satıcı, ürün, sipariş, ödeme ve teslimat süreçlerini tek bir ilişkisel veri modeli altında toplamayı amaçlamaktadır.  
Amaç, **veri bütünlüğü**, **tutarlılık** ve **raporlanabilirlik** ilkelerine uygun, optimize edilmiş bir e-ticaret veritabanı yapısı oluşturmaktır.

---

## Tablolar Ve İçerikleri

### 🗂️ 1. `Categories`
Ürünlerin sınıflandırıldığı temel kategorileri içerir.  
Her ürün bir kategoriye aittir.  

| Alan | Açıklama |
|------|-----------|
| `CategoryID` | Her kategori için benzersiz kimlik. |
| `CategoryName` | Kategori adı (ör. Elektronik, Giyim, Kozmetik). |

---

### 📍 2. `Addresses`
Müşterilere ait teslimat veya fatura adreslerini saklar.  

| Alan | Açıklama |
|------|-----------|
| `AddressID` | Adres kimliği. |
| `CustomerID` | Adresin ait olduğu müşteri. |
| `Title` | Adres kısa adı (ör. Ev, Ofis). |
| `AddressLine1`, `AddressLine2` | Açık adres bilgisi. |
| `PostalCode`, `City`, `Country` | Lokasyon bilgileri. |

---

### 👥 3. `Customers`
Sisteme kayıtlı kullanıcı bilgilerini tutar.  

| Alan | Açıklama |
|------|-----------|
| `CustomerID` | Müşteri kimliği. |
| `FirstName`, `LastName` | Ad-soyad bilgisi. |
| `Email`, `Phone` | İletişim bilgileri. |
| `PasswordHash` | Şifrelenmiş parola. |
| `Gender` | Cinsiyet bilgisi. |
| `RegistrationDate` | Kayıt tarihi. |

---

### 🏢 4. `Sellers`
Platformda satış yapan firmaların veya bireysel satıcıların bilgilerini saklar.  

| Alan | Açıklama |
|------|-----------|
| `SellerID` | Satıcı kimliği. |
| `CompanyName` | Şirket veya mağaza adı. |
| `Email` | İletişim e-posta adresi. |
| `TaxNumber` | Vergi numarası. |
| `MainAddressID` | Satıcının ana adresi (Addresses tablosuna bağlı). |

---

### 📦 5. `Products`
Platformdaki tüm ürünlerin detaylarını içerir.  

| Alan | Açıklama |
|------|-----------|
| `ProductID` | Ürün kimliği. |
| `SellerID` | Ürünü satan satıcı. |
| `CategoryID` | Ürünün ait olduğu kategori. |
| `ProductName` | Ürün adı. |
| `Brand` | Marka bilgisi. |
| `Description` | Ürün açıklaması. |
| `Price` | Birim fiyat. |
| `StockQuantity` | Stok miktarı. |
| `AddedDate` | Ürünün eklenme tarihi. |
| `IsActive` | Ürünün satışta olup olmadığı. |

---

### 🧾 6. `Orders`
Müşteriler tarafından verilen siparişlerin genel bilgilerini tutar.  

| Alan | Açıklama |
|------|-----------|
| `OrderID` | Sipariş kimliği. |
| `CustomerID` | Siparişi veren müşteri. |
| `OrderDate` | Sipariş tarihi. |
| `TotalAmount` | Siparişin toplam tutarı. |
| `OrderStatus` | Siparişin durumu (ör. Hazırlanıyor, Tamamlandı). |
| `ShippingAddressID`, `BillingAddressID` | Teslimat ve fatura adresleri. |

---

### 📋 7. `OrderDetails`
Her siparişte yer alan ürünlerin detaylarını içerir (çoktan çoğa ilişkiyi temsil eder).  

| Alan | Açıklama |
|------|-----------|
| `OrderDetailID` | Detay kimliği. |
| `OrderID` | Sipariş kimliği. |
| `ProductID` | Ürün kimliği. |
| `Quantity` | Satın alınan miktar. |
| `UnitPrice` | Ürünün o anki birim fiyatı. |
| `LineTotal` | Ürün bazlı toplam tutar. |

---

### 💳 8. `Payments`
Siparişlerin ödeme bilgilerini tutar.  

| Alan | Açıklama |
|------|-----------|
| `PaymentID` | Ödeme kimliği. |
| `OrderID` | İlgili sipariş. |
| `PaymentDate` | Ödeme tarihi. |
| `Amount` | Ödenen tutar. |
| `PaymentMethod` | Ödeme yöntemi (Kredi Kartı, Havale vb.). |
| `TransactionStatus` | İşlem sonucu (Başarılı, Beklemede, İptal). |
| `TransactionCode` | Ödeme sağlayıcıdan gelen referans kodu. |

---

### 🚚 9. `Shipments`
Kargo işlemleri ve teslimat durumlarını saklar.  

| Alan | Açıklama |
|------|-----------|
| `ShipmentID` | Kargo kimliği. |
| `OrderID` | Gönderilen sipariş. |
| `TrackingNumber` | Kargo takip numarası. |
| `ShipperName` | Kargo firması adı. |
| `ShipmentDate` | Kargonun gönderim tarihi. |
| `EstimatedDeliveryDate` | Tahmini teslim tarihi. |
| `ShipmentStatus` | Gönderim durumu (Yolda, Teslim Edildi vb.). |

---

## 🔗 İlişkiler (Ozet)

- Bir **müşteri**, birden fazla **adres** ve **sipariş**e sahip olabilir.  
- Her **sipariş**, birden fazla **ürün** içerebilir (`OrderDetails` aracılığıyla).  
- Her **ürün**, bir **kategoriye** ve bir **satıcıya** bağlıdır.  
- Her **sipariş**, bir **ödeme** ve bir **kargo** kaydıyla ilişkilidir.  
- **Adresler**, hem fatura hem de teslimat için kullanılabilir.

---

## 🧩 Tasarımdan kazanılan deneyimler

Bu proje sayesinde:
- **İlişkisel veri modelleme** ve **normalizasyon** prensipleri uygulandı.  
- **Veri bütünlüğü** (foreign key, unique ) sağlandı.  
- **Sorgu optimizasyonu** ve performans odaklı düşünme becerileri geliştirildi.  
- Gerçek bir e-ticaret senaryosuna uygun **veri akışı ve mantıksal ilişkiler** başarıyla modellendi.

---

## 🧠 Sonuç

Bu çalışma, e-ticaret sistemlerinin veri yapısını anlamak ve verimli bir şekilde tasarlamak amacıyla hazırlanmıştır.
Ortaya çıkan model, hem akademik açıdan örnek teşkil eden bir veri tabanı tasarımı hem de gerçek bir uygulamanın temeli olabilecek niteliktedir.
Proje, ilerleyen aşamalarda stok takibi, kullanıcı analizi ve raporlama gibi modüllerle kolayca geliştirilebilir.


