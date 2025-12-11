# 🎵 ConcertFlow

Aplikasi mobile Flutter untuk menemukan, menjelajahi, dan mengelola acara konser favorit Anda. Aplikasi ini dibangun dengan teknologi terkini untuk memberikan pengalaman pengguna yang seamless dan intuitif.

## 📋 Daftar Isi
- [Fitur Utama](#fitur-utama)
- [Tech Stack](#tech-stack)
- [Prasyarat](#prasyarat)
- [Instalasi](#instalasi)
- [Struktur Proyek](#struktur-proyek)
- [Konfigurasi Firebase](#konfigurasi-firebase)
- [Menggunakan Aplikasi](#menggunakan-aplikasi)
- [Kontribusi](#kontribusi)

## ✨ Fitur Utama

- **Autentikasi Firebase** - Login dan registrasi aman menggunakan Firebase Authentication
- **Jelajahi Acara** - Temukan konser dan acara musik terbaru dengan mudah
- **Favorit Acara** - Simpan acara favorit untuk akses cepat di kemudian hari
- **Manajemen Artis** - Lihat profil artis dan acara mereka
- **Tema Gelap** - Antarmuka yang nyaman untuk mata dengan desain tema gelap modern
- **Responsif Multi-Platform** - Kompatibel dengan Android, iOS, Web, Windows, dan Linux

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: GetX 4.7.3
- **Backend**: Firebase (Auth, Cloud Firestore, Realtime Database)
- **UI/UX**: 
  - Google Fonts 6.3.2
  - Iconsax 0.0.8
  - Flutter Animate 4.5.2
  - Animated Bottom Navigation Bar 1.4.0
- **Utilities**: 
  - Intl 0.20.2 (Internasionalisasi)
  - HTTP 1.6.0

## 📦 Prasyarat

Sebelum memulai, pastikan Anda telah menginstal:
- **Flutter SDK** (versi 3.7.2 atau lebih tinggi)
- **Dart** (disertakan dengan Flutter)
- **Git**
- **IDE**: Android Studio, VS Code, atau Xcode (untuk iOS)
- **Akun Firebase** (untuk backend)

## 🚀 Instalasi

### 1. Clone Repository
```bash
git clone <repository-url>
cd cf_ta
```

### 2. Instal Dependensi
```bash
flutter pub get
```

### 3. Konfigurasi Firebase
Pastikan file `google-services.json` (untuk Android) dan `GoogleService-Info.plist` (untuk iOS) sudah dikonfigurasi dengan project Firebase Anda.

### 4. Jalankan Aplikasi
```bash
flutter run
```

Untuk platform tertentu:
```bash
# Android
flutter run -d android

# iOS
flutter run -d iphone

# Web
flutter run -d chrome

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

## 📂 Struktur Proyek

```
lib/
├── main.dart                          # Entry point aplikasi
│
├── controllers/                       # GetX Controllers untuk state management
│   ├── auth_controller.dart          # Manajemen autentikasi & user session
│   ├── event_controller.dart         # Manajemen data & logic acara
│   ├── artist_controller.dart        # Manajemen data artis
│   ├── favourite_controller.dart     # Manajemen acara favorit user
│   └── order_controller.dart         # Manajemen pesanan/tiket
│
├── models/                            # Data models & entities
│   ├── user_model.dart               # Model data user
│   ├── event_model.dart              # Model data acara
│   ├── artist_model.dart             # Model data artis
│   └── order_model.dart              # Model data pesanan
│
├── views/                             # UI Screens & Pages
│   ├── auth/                         # Halaman autentikasi
│   │   ├── login_page.dart
│   │   └── register_page.dart
│   ├── home/                         # Halaman utama/dashboard
│   ├── event/                        # Halaman detail acara
│   │   ├── event_list_page.dart
│   │   └── event_detail_page.dart
│   ├── artist/                       # Halaman profil & detail artis
│   │   ├── artist_list_page.dart
│   │   └── artist_detail_page.dart
│   ├── favourite_page/               # Halaman acara favorit
│   │   └── favourite_page.dart
│   ├── order/                        # Halaman pemesanan tiket
│   │   ├── order_page.dart
│   │   └── order_detail_page.dart
│   ├── profile_page/                 # Halaman profil user
│   │   └── profile_page.dart
│   ├── search/                       # Halaman pencarian
│   │   └── search_page.dart
│   ├── root/                         # Layout utama dengan navigation
│   │   └── root_page.dart
│   └── widgets/                      # Reusable widgets & components
│       ├── event_card.dart
│       ├── artist_card.dart
│       └── custom_app_bar.dart
│
├── services/                          # Business logic & API services
│   ├── api.dart                      # API integration & HTTP calls
│   └── currency_format.dart          # Utilitas format currency
│
├── theme/                             # Konfigurasi tema aplikasi
│   ├── app_theme.dart                # Tema gelap (dark theme)
│   └── app_colors.dart               # Palet warna aplikasi
│
android/                              # Konfigurasi Android native
├── app/
├── gradle/
└── ...
ios/                                  # Konfigurasi iOS native
├── Runner/
├── Runner.xcodeproj/
└── ...
build/                                # Output build (auto-generated)
web/                                  # Konfigurasi web platform
windows/                              # Konfigurasi Windows platform
linux/                                # Konfigurasi Linux platform
macos/                                # Konfigurasi macOS platform
```

Layanan Firebase yang digunakan:
- **Firebase Authentication** - Untuk login dan registrasi pengguna
- **Firebase Realtime Database** - Database real-time untuk data dinamis

## 📱 Menggunakan Aplikasi

### Login
1. Buka aplikasi
2. Masukkan email dan password Anda
3. Atau daftar akun baru jika belum memiliki akun

### Jelajahi Acara
1. Setelah login, navigasi ke halaman acara
2. Lihat daftar konser dan acara musik terbaru
3. Ketuk acara untuk melihat detail lengkap

### Tambahkan ke Favorit
1. Buka detail acara
2. Ketuk ikon hati untuk menambahkan ke favorit
3. Akses favorit dari menu profil atau bagian khusus

## 🎨 Desain & UX

Aplikasi menggunakan palet warna gelap yang modern untuk kenyamanan mata dan estetika visual yang menarik. Setiap elemen dirancang dengan perhatian terhadap aksesibilitas dan responsivitas.

## 🔄 State Management

Aplikasi menggunakan **GetX** untuk manajemen state yang efisien:
- Controllers diinisialisasi sebagai permanent saat aplikasi dimulai
- Data binding otomatis dengan UI menggunakan `Obx()`
- Navigasi mudah dengan `Get.to()`, `Get.back()`, dll

## 📝 Lisensi

Proyek ini dikembangkan sebagai tugas akhir. Mohon hubungi pengembang untuk informasi lisensi.

## 👤 Pengembang

---

Jika Anda menemukan bug atau memiliki saran, silakan buat issue atau pull request!
