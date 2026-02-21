# VetDigital — Tam Kurulum Rehberi (Adım Adım)

Bu rehber, projeyi sıfırdan çalışır hale getirmek için yapman gereken her adımı açıklar.

---

## Ön Koşullar

Bilgisayarında şunların kurulu olması gerekir:

| Araç | Sürüm | İndirme |
|------|-------|---------|
| Docker Desktop | 4.x+ | https://www.docker.com/products/docker-desktop |
| Python | 3.11+ | https://www.python.org/downloads/ |
| Flutter SDK | 3.x+ | https://docs.flutter.dev/get-started/install |
| Git | herhangi | https://git-scm.com/ |

---

## BÖLÜM 1 — Backend Kurulumu

### Adım 1.1 — Python sanal ortamı kur

```bash
cd vetdigital-backend

# Sanal ortam oluştur
python -m venv venv

# Aktivasyon:
# Windows
venv\Scripts\activate
# Mac/Linux
source venv/bin/activate

# Bağımlılıkları yükle
pip install -r requirements/base.txt
pip install -r requirements/dev.txt
```

### Adım 1.2 — .env dosyasını kontrol et

`.env` dosyası proje içinde hazır olarak gelir. Üretimde aşağıdaki değerleri değiştirmen zorunludur:

```
SECRET_KEY=  ← En az 32 karakter, rastgele bir değer gir
```

Geliştirme için diğer değerleri olduğu gibi bırakabilirsin.

---

## BÖLÜM 2 — Docker ile Altyapıyı Başlat

### Adım 2.1 — Docker Compose ile servisleri başlat

```bash
cd vetdigital-backend/docker

docker compose up -d
```

Bu komut şunları başlatır:
- **PostgreSQL 16** (port 5432) — Ana veritabanı
- **Redis 7** (port 6379) — Cache ve Celery kuyruğu
- **EMQX** (port 1883, web UI: 18083) — MQTT IoT broker
- **MinIO** (port 9000, console: 9001) — Dosya depolama
- **NGINX** (port 80) — Reverse proxy

Servislerin ayağa kalkması 30–60 saniye alabilir.

### Adım 2.2 — Servislerin çalıştığını doğrula

```bash
docker compose ps
```

Tüm servislerin `running` durumunda olması gerekir.

---

## BÖLÜM 3 — Veritabanı Kurulumu

### Adım 3.1 — Alembic migration'ı çalıştır (tablo oluşturma)

Bu adım tüm veritabanı tablolarını ve başlangıç verilerini oluşturur.

```bash
cd vetdigital-backend

# Sanal ortam aktif olmalı!
alembic upgrade head
```

Başarılı çıktı şöyle görünür:
```
INFO  [alembic.runtime.migration] Running upgrade  -> 001_initial_schema, Initial schema...
```

**Bu adım şunları otomatik oluşturur:**
- 22 veritabanı tablosu (animals, owners, procedure_acts, vb.)
- 6 kullanıcı rolü (admin, veterinarian, farmer, inspector, lab, supplier)
- 30 izin (permission)
- 9 hayvan türü (KRS, MRS, at, deve, vb.)
- 10 ırk (kazakh whitehead, edilbay, vb.)
- 21 Kazakistan bölgesi (oblastlar + Almatı/Astana/Şımkent şehirleri)

### Adım 3.2 — Admin kullanıcı oluştur

```bash
cd vetdigital-backend
python scripts/create_admin.py
```

Script senden şunları isteyecek:
- **IIN:** 12 haneli kimlik numarası (örnek: `000000000001`)
- **Ad Soyad (Rusça):** (örnek: `Администратор Системы`)
- **Şifre:** En az 8 karakter

Çıktı şöyle görünür:
```
=== VetDigital Admin User Setup ===
IIN (12 digits): 000000000001
Full name: Администратор Системы
Password:
Confirm password:
Admin user created successfully:
  ID    : abc123...
  IIN   : 000000000001
  Name  : Администратор Системы
  Role  : admin
```

---

## BÖLÜM 4 — Backend'i Başlat

### Adım 4.1 — FastAPI sunucusunu çalıştır

```bash
cd vetdigital-backend

uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

Başarılı çıktı:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
INFO:     Application startup complete.
```

### Adım 4.2 — API'nin çalıştığını test et

Tarayıcıda aç: http://localhost:8000/docs

Swagger UI açılıyorsa backend hazır demektir.

### Adım 4.3 — Celery worker'ı başlat (arka plan görevler için)

Yeni bir terminal aç:

```bash
cd vetdigital-backend
source venv/bin/activate  # (Windows: venv\Scripts\activate)

celery -A app.tasks.celery_app worker --loglevel=info
```

### Adım 4.4 — Celery beat'i başlat (zamanlanmış görevler için)

Başka bir terminal aç:

```bash
cd vetdigital-backend
source venv/bin/activate

celery -A app.tasks.celery_app beat --loglevel=info
```

---

## BÖLÜM 5 — Flutter Mobil Uygulaması

### Adım 5.1 — Flutter bağımlılıklarını yükle

```bash
cd vetdigital_mobile

flutter pub get
```

### Adım 5.2 — Kod üretimini çalıştır (Freezed, JSON serialization, Drift)

```bash
cd vetdigital_mobile

dart run build_runner build --delete-conflicting-outputs
```

Bu komut yaklaşık 2–5 dakika sürer. Şunları üretir:
- `*.freezed.dart` — Immutable model dosyaları
- `*.g.dart` — JSON serialization kodu
- `app_database.g.dart` — Drift (SQLite) veritabanı kodu

### Adım 5.3 — API base URL'ini yapılandır

`vetdigital_mobile/lib/core/config/app_config.dart` dosyasını aç ve backend adresini güncelle:

```dart
// Geliştirme ortamı için:
static const String baseUrl = 'http://10.0.2.2:8000/api/v1';  // Android emülatör
// veya
static const String baseUrl = 'http://localhost:8000/api/v1';   // iOS simülatör / web
```

**Not:** Android emülatöründe `localhost` çalışmaz, `10.0.2.2` kullan.

### Adım 5.4 — Uygulamayı çalıştır

```bash
cd vetdigital_mobile

# Bağlı cihazları listele
flutter devices

# Seçili cihazda çalıştır (örnek: emülatör)
flutter run

# Belirli cihaz ID ile:
flutter run -d emulator-5554
```

---

## BÖLÜM 6 — Firebase Push Notifications (İsteğe Bağlı)

Push bildirimler için Firebase projesi gereklidir. Firebase'i yapılandırmadan da uygulama çalışır — sadece push bildirimleri devre dışı olur.

### Adım 6.1 — Firebase projesi oluştur

1. https://console.firebase.google.com/ adresine git
2. "Add project" → proje adı: `VetDigital`
3. Google Analytics'i etkinleştir (opsiyonel)

### Adım 6.2 — Android uygulamasını ekle

1. Firebase Console → "Add app" → Android
2. **Package name:** `kz.gov.vetdigital` (veya projedeki değer)
3. `google-services.json` dosyasını indir
4. Dosyayı buraya koy: `vetdigital_mobile/android/app/google-services.json`

### Adım 6.3 — iOS uygulamasını ekle (Mac gerektirir)

1. Firebase Console → "Add app" → iOS
2. **Bundle ID:** `kz.gov.vetdigital`
3. `GoogleService-Info.plist` dosyasını indir
4. Dosyayı buraya koy: `vetdigital_mobile/ios/Runner/GoogleService-Info.plist`

### Adım 6.4 — Backend için service account key oluştur

1. Firebase Console → Project Settings → Service accounts
2. "Generate new private key" → JSON dosyasını indir
3. Dosyayı şu konuma koy: `vetdigital-backend/firebase-credentials.json`
4. `.env` dosyasında path'i doğrula: `FIREBASE_CREDENTIALS_PATH=./firebase-credentials.json`

---

## BÖLÜM 7 — MinIO Bucket Yapılandırması

### Adım 7.1 — MinIO Console'a gir

Tarayıcıda aç: http://localhost:9001

- Kullanıcı adı: `minioadmin`
- Şifre: `minioadmin`

### Adım 7.2 — Bucket'ları oluştur

"Create Bucket" butonuna tıkla ve sırayla şu isimlerde 2 bucket oluştur:
1. `vetdigital-documents` — PDF prosedür aktları ve belgeler
2. `vetdigital-photos` — Hayvan fotoğrafları

Her bucket için Access Policy'yi **Public** olarak ayarla (opsiyonel — sadece geliştirme için).

---

## BÖLÜM 8 — EMQX MQTT Broker Yapılandırması

### Adım 8.1 — EMQX Dashboard'a gir

Tarayıcıda aç: http://localhost:18083

- Kullanıcı adı: `admin`
- Şifre: `public`

### Adım 8.2 — MQTT kullanıcısı oluştur

1. Authentication → "Add" → Username/Password
2. Username: `vetdigital`
3. Password: `mqtt_pass` (`.env` ile aynı olmalı)

---

## BÖLÜM 9 — Smart Bridge Entegrasyonu (Üretimde Zorunlu)

Smart Bridge (iszh.gov.kz), Kazakistan'ın devlet veri alışverişi platformudur. Gerçek hayvan verileriyle çalışmak için kayıt zorunludur.

### Adım 9.1 — Sistem olarak kayıt ol

1. https://e-license.kz/ adresine git
2. EDS (Elektronik Dijital İmza) ile giriş yap
3. "Ақпараттық жүйені тіркеу" (BIS'e kayıt) bölümüne git
4. Sistemi kaydet:
   - Sistem adı: `VetDigital`
   - Sistem ID: `vetdigital`
   - Entegrasyon tipi: `Smart Bridge REST API`

### Adım 9.2 — API anahtarını al ve .env'e ekle

Kayıt onaylandıktan sonra API anahtarını `.env` dosyasına ekle:

```
SMART_BRIDGE_API_KEY=alınan-api-anahtarı-buraya
```

**Not:** Bu süreç birkaç iş günü sürebilir. Geliştirme aşamasında bu entegrasyon olmadan da uygulama çalışır.

---

## BÖLÜM 10 — RFID Bluetooth Okuyucu

Hayvan kulak etiketlerini (ISO 11784 mikrocip, 134.2 kHz) okumak için Bluetooth RFID okuyucu gereklidir. Telefon NFC'si bu frekansı desteklemez.

### Önerilen Cihazlar:
- **ISENVO AR190E** — BLE + 134.2 kHz FDX-B
- **Agrident AWR250** — BLE + ISO 11784/11785

### Adım 10.1 — Okuyucuyu Flutter'a bağla

`flutter_blue_plus` paketi `pubspec.yaml`'da zaten tanımlıdır. RFID ekranı açıldığında otomatik BLE taraması başlar.

### Adım 10.2 — Bluetooth izinlerini kontrol et

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>RFID okuyucu için Bluetooth gereklidir</string>
```

---

## BÖLÜM 11 — EDS (Elektronik Dijital İmza) Test Kurulumu

### Geliştirme için:

1. https://pki.gov.kz/get-cert-individual/ adresinden test EDS sertifikası al
2. Test IIN kullan: `000000000001`
3. eGov Mobile uygulamasını yükle (App Store / Google Play: "eGov Mobile")
4. Test sertifikasını eGov Mobile'a aktar

### İmzalama akışı:

1. Uygulama prosedür aktını oluşturur → PDF üretir
2. `egov://sign?...` deep link QR kodu gösterir
3. Veteriner eGov Mobile ile QR'ı okur → imzalar
4. Backend imzayı doğrular → akta eklenir

---

## BÖLÜM 12 — Test

### Backend testlerini çalıştır:

```bash
cd vetdigital-backend
source venv/bin/activate

# Tüm testler
pytest

# Sadece unit testler
pytest -m unit

# Sadece integration testler (PostgreSQL gerektirir)
pytest -m integration

# Belirli dosya
pytest tests/unit/test_validators.py -v
```

### Flutter testlerini çalıştır:

```bash
cd vetdigital_mobile

# Unit testler
flutter test

# Widget testler
flutter test test/widget/

# Integration test (cihazda)
flutter test integration_test/
```

---

## BÖLÜM 13 — Üretim Ortamı için Ek Adımlar

Üretim ortamına deploy etmeden önce şunları yap:

1. **SECRET_KEY** — Rastgele 64 karakter, güvenli bir değer ata
2. **DEBUG=false** — `.env`'de
3. **CORS_ORIGINS** — Sadece izin verilen domain'leri listele
4. **Şifreleri değiştir** — PostgreSQL, Redis, MinIO, EMQX
5. **HTTPS/TLS** — NGINX için SSL sertifikası yapılandır
6. **Firebase** — Gerçek proje ile gerçek credentials
7. **MinIO bucket policy** — Public erişimi kapat, presigned URL kullan
8. **Backup** — PostgreSQL için günlük yedekleme planla
9. **Monitoring** — Prometheus endpoint aktif: `GET /metrics`

---

## Sorun Giderme

### "relation 'regions' does not exist" hatası
```bash
alembic upgrade head
```
Migration çalışmamış. Yukarıdaki komutu tekrar çalıştır.

### "Connection refused" port 5432
Docker container'ı çalışmıyor:
```bash
docker compose up -d postgres
```

### Flutter build_runner hatası
```bash
cd vetdigital_mobile
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### MQTT bağlantı hatası
EMQX web dashboard'unda (http://localhost:18083) Authentication bölümünde kullanıcı oluşturulduğundan emin ol.

### "Firebase credentials not found" uyarısı
Sadece push bildirimler çalışmaz, uygulama çalışmaya devam eder. `firebase-credentials.json` dosyasını ekleyene kadar bu normal.

---

## Hızlı Başlangıç Özeti

```bash
# 1. Docker servislerini başlat
cd vetdigital-backend/docker && docker compose up -d

# 2. Python ortamı kur
cd .. && python -m venv venv && venv/Scripts/activate && pip install -r requirements/base.txt

# 3. Veritabanı tablolarını oluştur
alembic upgrade head

# 4. Admin kullanıcı oluştur
python scripts/create_admin.py

# 5. Backend başlat
uvicorn app.main:app --reload --port 8000

# 6. Flutter bağımlılıklarını yükle (yeni terminal)
cd ../vetdigital_mobile && flutter pub get
dart run build_runner build --delete-conflicting-outputs

# 7. Mobil uygulamayı başlat
flutter run
```

API Docs: http://localhost:8000/docs
MinIO Console: http://localhost:9001 (admin/minioadmin)
EMQX Dashboard: http://localhost:18083 (admin/public)
