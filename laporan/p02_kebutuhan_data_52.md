# Dokumen Kebutuhan Data - Toko Daring Pakaian (Toko)

## 1. Proses Bisnis Inti
Berikut adalah 4 proses bisnis utama dalam operasional Toko Daring Pakaian:
1. **PB-01: Mengelola Katalog Pakaian:** Admin toko menambahkan, memperbarui, atau menghapus data pakaian, stok, dan kategorinya.
2. **PB-02: Memproses Pesanan:** Pelanggan memilih pakaian, memasukkannya ke keranjang, dan melakukan *checkout* untuk membuat pesanan baru.
3. **PB-03: Memverifikasi Pembayaran:** Sistem dan admin memverifikasi bukti transfer dan memperbarui status pembayaran pesanan pelanggan.
4. **PB-04: Mengelola Pengiriman:** Admin memproses barang yang sudah dibayar, mencetak resi, dan menyerahkannya ke jasa ekspedisi.

## 2. Kandidat Entitas
Berdasarkan proses bisnis di atas, ditemukan 7 kandidat entitas (minimal 6):
1. `Pelanggan`: Menyimpan data pembeli.
2. `Kategori_Pakaian`: Menyimpan klasifikasi produk (misal: Kaos, Kemeja, Celana).
3. `Pakaian`: Menyimpan detail produk pakaian yang dijual.
4. `Pesanan`: Menyimpan data *header* transaksi (tanggal, total).
5. `Detail_Pesanan`: Menyimpan rincian item pakaian apa saja yang dibeli dalam satu pesanan.
6. `Pembayaran`: Menyimpan data transaksi pembayaran pesanan.
7. `Pengiriman`: Menyimpan data logistik dan nomor resi.

## 3. Aturan Bisnis (Business Rules)
1. **AB-01:** Satu pelanggan dapat melakukan banyak pesanan, tetapi satu pesanan hanya milik satu pelanggan secara mutlak.
2. **AB-02:** Satu pesanan dapat berisi maksimal 10 item pakaian.
3. **AB-03:** Pelanggan bisa mendapatkan diskon sebesar 8% jika memenuhi syarat promo toko.
4. **AB-04:** Setiap pakaian harus memiliki minimal satu kategori pakaian agar mudah dicari di katalog.
5. **AB-05:** Stok pakaian di katalog akan berkurang secara otomatis *hanya* setelah status pembayaran pesanan divalidasi (Lunas).
6. **AB-06:** Setiap pesanan yang dibuat otomatis diberi batas waktu pembayaran 24 jam. Jika lewat, pesanan dibatalkan.
7. **AB-07:** Satu pesanan hanya bisa dibayar melalui satu catatan transaksi pembayaran.
8. **AB-08:** Pesanan dengan status "Lunas" harus diteruskan ke satu proses pengiriman yang memiliki nomor resi unik.

## 4. Kebutuhan Informasi
1. **KI-01:** Menampilkan daftar pakaian yang stoknya sudah menipis (kurang dari 5).
2. **KI-02:** Menyajikan rekapitulasi riwayat pesanan dan status pengiriman untuk setiap pelanggan di halaman profil mereka.
3. **KI-03:** Menampilkan laporan total pendapatan kotor harian dan bulanan.
4. **KI-04:** Menampilkan daftar sekitar 80 pesanan harian untuk diproses admin gudang.
5. **KI-05:** Mengidentifikasi pelanggan paling aktif (paling banyak transaksi selesai) dalam satu bulan terakhir untuk program loyalitas.

## 5. Matriks CRUD
Tabel pemetaan antara Proses Bisnis dan Entitas (C=Create, R=Read, U=Update, D=Delete).

| Entitas | PB-01 (Katalog) | PB-02 (Pesanan) | PB-03 (Pembayaran) | PB-04 (Pengiriman) |
| :--- | :---: | :---: | :---: | :---: |
| **Pelanggan** | - | R, U | R | R |
| **Kategori_Pakaian**| C, R, U, D | R | - | - |
| **Pakaian** | C, R, U, D | R | U* | R |
| **Pesanan** | - | C, R, U | R, U | R, U |
| **Detail_Pesanan** | - | C, R | R | R |
| **Pembayaran** | - | - | C, R, U | R |
| **Pengiriman** | - | - | - | C, R, U |

*(Catatan: Entitas `Pelanggan` tidak memiliki huruf 'C' pada matriks ini karena pembuatan entitas pelanggan (Registrasi) terjadi di proses bisnis Manajemen Akun di luar 4 proses inti di atas. Huruf 'U' pada PB-03 entitas `Pakaian` berfungsi untuk update/pengurangan stok).*

## 6. Kamus Data Awal
Tabel definisi elemen data utama dengan penanggung jawab (PIC).

| No | Elemen Data | Entitas | Tipe Data | Deskripsi | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | `ID_Pelanggan` | Pelanggan | String | ID unik pengguna | Sistem / Admin IT |
| 2 | `Nama_Lengkap` | Pelanggan | String | Nama asli pelanggan | Pelanggan |
| 3 | `No_Handphone` | Pelanggan | String | Nomor HP aktif pembeli | Pelanggan |
| 4 | `Alamat_Kirim` | Pelanggan | Text | Alamat tujuan pengiriman | Pelanggan |
| 5 | `ID_Kategori` | Kategori_Pakaian | String | ID unik kategori produk | Admin Toko |
| 6 | `Nama_Kategori` | Kategori_Pakaian | String | Nama kategori (Kaos, dll) | Admin Toko |
| 7 | `ID_Pakaian` | Pakaian | String | SKU/ID unik baju | Admin Toko |
| 8 | `Nama_Pakaian` | Pakaian | String | Nama produk pakaian | Admin Toko |
| 9 | `Ukuran` | Pakaian | String | Ukuran baju (S/M/L/XL) | Admin Toko |
| 10 | `Harga_Satuan` | Pakaian | Integer | Harga per *pcs* dalam Rupiah | Admin Toko |
| 11 | `Stok_Tersedia` | Pakaian | Integer | Jumlah barang di gudang | Admin Gudang |
| 12 | `ID_Pesanan` | Pesanan | String | Nomor invoice unik | Sistem |
| 13 | `Tgl_Pesanan` | Pesanan | DateTime | Waktu *checkout* dilakukan | Sistem |
| 14 | `Total_Tagihan` | Pesanan | Integer | Total harga + ongkos kirim | Sistem |
| 15 | `Kuantitas` | Detail_Pesanan | Integer | Jumlah baju yang dibeli | Pelanggan |
| 16 | `Subtotal_Harga` | Detail_Pesanan | Integer | Harga Satuan x Kuantitas | Sistem |
| 17 | `ID_Pembayaran` | Pembayaran | String | ID transaksi *payment gateway*| Sistem |
| 18 | `Metode_Bayar` | Pembayaran | String | Transfer Bank / E-Wallet | Pelanggan |
| 19 | `ID_Pengiriman` | Pengiriman | String | ID pencatatan logistik | Admin Gudang |
| 20 | `No_Resi` | Pengiriman | String | Resi cetak dari ekspedisi | Admin Gudang / Kurir |

## 7. Kebutuhan Non-Fungsional & Data Pribadi
* **Identifikasi Data Pribadi (Privasi):** Data `Nama_Lengkap`, `No_Handphone`, dan `Alamat_Kirim` dikategorikan sebagai Data Pribadi (PII). 
* **Akses Data:** Data pribadi ini hanya boleh diakses oleh **Admin Toko** (untuk memproses pesanan) dan dienkripsi saat transit. Data alamat dan telepon akan diteruskan ke **Kurir Ekspedisi** semata-mata untuk keperluan pengiriman barang.
* **Performa:** Basis data harus dirancang untuk mampu mengelola setidaknya pencatatan 80 nota transaksi per hari tanpa mengalami *lag* lebih dari 3 detik saat memuat halaman katalog.

## 8. Pembedahan Dokumen Sumber (Fiktif)
**Dokumen Sumber: Faktur / Rincian Pesanan Halaman Checkout**
*(Deskripsi Tampilan: Terdapat Header Invoice, Data Pembeli, Tabel Barang yang Dibeli, dan Total Harga)*

**Hasil Pembedahan ke Entitas:**
* "Faktur #INV-202611-001", "Tgl: 11 Nov 2026" -> Masuk ke atribut entitas `Pesanan`.
* "Dikirim ke: Restu Kurniawan, Kota Metro, HP: 0812xxx" -> Masuk ke atribut entitas `Pelanggan`.
* "1x Kaos Polos Hitam (L) - Rp 50.000" -> Dipecah menjadi entitas `Pakaian` (Kaos Polos Hitam, L) dan entitas `Detail_Pesanan` (Kuantitas 1, Harga Rp 50.000).
* "Total Bayar: Rp 50.000" -> Masuk ke atribut entitas `Pesanan`.

## 9. Perhitungan Parameter P
Sesuai dua digit terakhir NIM (52):
* **Nilai P:** (52 mod 9) + 1 = 7 + 1 = **8**.
* **Batas maksimal item per transaksi:** P + 2 = 8 + 2 = **10 item**.
* **Persentase diskon toko:** P = **8%**.
* **Perkiraan volume transaksi harian:** 40 + (5 x P) = 40 + (5 x 8) = 40 + 40 = **80 nota/hari**.