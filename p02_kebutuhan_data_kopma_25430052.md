# Latihan dan Modifikasi: Kebutuhan Data Kopma (Penukaran Poin Loyalitas)

## 1. Elemen Data Tambahan
Untuk mendukung fitur penukaran poin, ditambahkan entitas dan elemen data baru:
* **Katalog_Hadiah:** `id_hadiah`, `nama_hadiah`, `poin_dibutuhkan`, `stok_hadiah`
* **Riwayat_Penukaran:** `id_penukaran`, `id_anggota`, `id_hadiah`, `tgl_tukar`, `poin_terpakai`
* **Anggota (Update):** penambahan elemen `total_poin_aktif`

## 2. Aturan Bisnis (Lanjutan)
| Kode | Aturan Bisnis |
| :--- | :--- |
| AB-07 | Anggota mendapatkan 1 poin loyalitas untuk setiap kelipatan pembelanjaan Rp 10.000 dalam satu struk transaksi. |
| AB-08 | Penukaran poin hanya bisa diproses oleh sistem jika `total_poin_aktif` anggota lebih besar atau sama dengan `poin_dibutuhkan` pada item yang dipilih di Katalog Hadiah. |
| AB-09 | Stok hadiah (`stok_hadiah`) akan berkurang dan `total_poin_aktif` anggota akan dipotong secara otomatis setiap kali proses penukaran berhasil. |

## 3. Kebutuhan Informasi Tambahan
| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| KI-06 | Laporan saldo poin loyalitas tiap anggota yang bisa digunakan | Anggota |
| KI-07 | Daftar riwayat penukaran hadiah anggota per bulan | Riwayat_Penukaran, Anggota, Katalog_Hadiah |
| KI-08 | Laporan 5 jenis hadiah yang paling sering ditukarkan | Riwayat_Penukaran, Katalog_Hadiah |

## 4. Pembaruan Matriks CRUD
Ditambahkan Proses Bisnis baru untuk "Penukaran Poin Loyalitas".

| Proses Bisnis | Anggota | Transaksi | Katalog_Hadiah | Riwayat_Penukaran |
| :--- | :--- | :--- | :--- | :--- |
| PB-06 Tukar Poin | R, U | - | R, U | C, R |

*(Catatan: `Anggota` di-Update saldo poinnya, `Katalog_Hadiah` di-Update stoknya, `Riwayat_Penukaran` di-Create)*