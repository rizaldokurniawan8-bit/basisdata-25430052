# Dokumen Kebutuhan Data RK Apparel

## 1. Latar Belakang dan Aktivitas Organisasi
RK Apparel adalah toko daring (*online store*) yang menjual berbagai macam pakaian dan aksesori fesyen. Toko ini melayani pelanggan dari seluruh Indonesia. Aktivitas utamanya meliputi pengelolaan katalog produk pakaian, pendaftaran akun pelanggan, pencatatan pesanan melalui sistem keranjang belanja, proses verifikasi pembayaran, serta pengiriman barang melalui pihak ekspedisi.

## 2. Aktor dan Proses Bisnis
| Kode  | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| PB-01 | Mendaftar dan mengelola akun pelanggan | Pelanggan | Pengunjung web ingin melakukan transaksi pertama kali |
| PB-02 | Mengelola katalog dan stok produk | Admin Penjualan | Ada barang baru atau perubahan harga dari pihak manajemen |
| PB-03 | Mencatat pesanan dan pembayaran | Sistem / Pelanggan | Pelanggan melakukan *checkout* pesanan dan transfer pembayaran |
| PB-04 | Memproses dan mengirim pesanan | Petugas Gudang | Pembayaran pesanan telah diverifikasi oleh sistem |
| PB-05 | Membuat laporan penjualan | Admin Penjualan | Memasuki akhir hari atau akhir bulan pembukuan |

## 3. Dokumen Sumber yang Dianalisis
**Nama Dokumen Fiktif:** Bukti Pesanan (Invoice Digital) RK Apparel

**Anatomi Dokumen:**
*   **Identitas Transaksi:** No. Pesanan (INV-202610-0012), Tanggal Waktu, Status Pesanan.
*   **Data Pelanggan & Pengiriman:** Nama Pelanggan, No. HP, Alamat Pengiriman Lengkap, Jasa Kurir, Resi Pengiriman.
*   **Data Transaksi (Rincian):** SKU Produk, Nama Pakaian, Ukuran, Qty, Harga Satuan saat dibeli.
*   **Nilai Turunan (Dihitung):** Subtotal Barang, Ongkos Kirim, Diskon Promosi, Total Pembayaran.

## 4. Entitas Kandidat dan Elemen Data
1.  **Pelanggan:** id_pelanggan, nama, email, no_hp, tgl_lahir
2.  **Produk:** sku_produk, nama_produk, kategori, ukuran, harga_jual, stok
3.  **Pesanan:** no_pesanan, tgl_pesanan, status_pesanan, id_pelanggan, alamat_pengiriman, total_bayar
4.  **Detail_Pesanan:** no_pesanan, sku_produk, qty, harga_saat_transaksi
5.  **Pengiriman:** id_kirim, no_pesanan, kurir, no_resi, ongkir
6.  **Pembayaran:** id_bayar, no_pesanan, metode_bayar, jumlah_bayar, tgl_bayar

## 5. Aturan Bisnis
| Kode  | Aturan Bisnis |
| :--- | :--- |
| AB-01 | Setiap pesanan harus memiliki nomor invoice yang unik dan berisi minimal satu jenis produk baju/aksesori. |
| AB-02 | Maksimal jenis item (baris detail) dalam satu transaksi pesanan dibatasi sebanyak 10 item (Batas = P + 2, dengan P=8). |
| AB-03 | Pelanggan setia yang berbelanja di hari ulang tahunnya berhak mendapatkan diskon promo sebesar 8% (sesuai parameter P). |
| AB-04 | Stok produk tidak boleh bernilai negatif; sistem akan menolak pesanan jika kuantitas barang melebihi sisa stok yang ada. |
| AB-05 | Harga jual yang tercatat pada detail pesanan adalah harga pada saat *checkout*, dan tidak akan berubah meskipun harga master produk dinaikkan di masa depan. |
| AB-06 | Alamat pengiriman beserta ongkos kirim wajib disimpan per pesanan agar arsip riwayat pesanan lama tidak ikut berubah jika alamat pelanggan diganti suatu hari nanti. |
| AB-07 | Alamat email (sebagai *username*) dan nomor HP pelanggan harus unik dan tidak boleh dipakai oleh dua akun yang berbeda. |
| AB-08 | Transaksi pesanan dianggap batal secara otomatis jika pelanggan tidak melakukan pembayaran dalam kurun waktu 24 jam. |

## 6. Kebutuhan Informasi
| Kode  | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| KI-01 | Ringkasan omzet dan jumlah total pesanan per hari serta per bulan | Pesanan, Detail_Pesanan |
| KI-02 | Laporan 5 produk pakaian paling laris terjual per bulan berdasarkan qty | Detail_Pesanan, Produk |
| KI-03 | Daftar produk yang sisa stoknya menipis (di bawah 5 *pieces*) | Produk |
| KI-04 | Laporan 10 pelanggan dengan total akumulasi nilai belanja terbesar | Pelanggan, Pesanan, Detail_Pesanan |
| KI-05 | Daftar pesanan yang sudah lunas dibayar namun belum masuk tahap pengiriman | Pesanan, Pembayaran, Pengiriman |

## 7. Matriks CRUD
| Proses Bisnis | Pelanggan | Produk | Pesanan | Detail_Pesanan | Pengiriman | Pembayaran |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PB-01 Daftar/Kelola Akun | C, R, U | - | - | - | - | - |
| PB-02 Kelola Produk | - | C, R, U, D | - | - | - | - |
| PB-03 Catat Pesanan & Bayar | R | R, U | C, R | C, R | - | C, R |
| PB-04 Proses Pengiriman | R | R | R, U | R | C, R, U | R |
| PB-05 Laporan Penjualan | R | R | R | R | - | - |

## 8. Kamus Data Awal
| Elemen Data | Arti | Contoh | Aturan | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| id_pelanggan | ID unik pelanggan | PLG-001 | Unik, AI | Admin Penjualan |
| email_pelanggan | Email login | rk@email.com | Unik, Data Pribadi | Admin Penjualan |
| no_hp_pelanggan | Kontak aktif | 0812345678 | Data Pribadi | Admin Penjualan |
| sku_produk | Kode unik baju | KEM-P-M-01 | Unik, kombinasi jenis & ukuran | Petugas Gudang |
| nama_produk | Nama barang | Kemeja Pria Polos M | Tidak boleh kosong | Petugas Gudang |
| kategori | Kategori barang | Atasan, Celana | Sesuai daftar kategori | Admin Penjualan |
| harga_jual | Harga master | 150000 | Angka >= 0 | Admin Penjualan |
| stok_produk | Jumlah barang riil | 25 | Angka >= 0 (AB-04) | Petugas Gudang |
| no_pesanan | Nomor invoice | INV-202610-123 | Unik | Admin Penjualan |
| tgl_pesanan | Waktu checkout | 2026-10-04 10:00 | DATETIME | Admin Penjualan |
| alamat_pengiriman | Lokasi tujuan paket | Jl. Ahmad Yani... | Disimpan per pesanan | Petugas Gudang |
| qty_detail | Jumlah dibeli | 2 | Angka > 0 | Sistem |
| harga_transaksi | Harga saat checkout | 150000 | Mengikat (AB-05) | Sistem |
| subtotal_detail | Harga * qty | 300000 | Nilai turunan (dihitung) | Sistem |
| id_bayar | Kode bayar | BYR-0991 | Unik | Sistem |
| metode_bayar | Transfer/E-Wallet | Transfer Bank | Daftar metode baku | Admin Penjualan |
| jumlah_bayar | Uang masuk | 320000 | Angka >= 0 | Sistem |
| tgl_bayar | Waktu pelunasan | 2026-10-04 10:15 | DATETIME | Sistem |
| no_resi | Resi logistik | JNT123456789 | Boleh kosong di awal | Petugas Gudang |
| kurir | Nama jasa logistik | J&T Reguler | - | Petugas Gudang |
| ongkir | Biaya kirim | 20000 | Angka >= 0 | Sistem |

## 9. Kebutuhan Non-fungsional Data
*   **Perhitungan Parameter P:** 2 digit terakhir NIM (52) mod 9 = 7. Maka P = 7 + 1 = **8**. Parameter ini digunakan untuk menentukan maksimal limit baris item pesanan (10 item) dan diskon ultah (8%).
*   **Estimasi Volume Data:** Berdasarkan parameter P, diperkirakan terjadi volume transaksi harian sebesar 40 + (5 x 8) = 80 transaksi pesanan per hari.
*   **Retensi Data:** Data riwayat pesanan pelanggan dan data riwayat pembayaran akan disimpan secara aktif selama minimal 5 tahun untuk keperluan audit keuangan koperasi.
*   **Privasi dan Akses Data Pribadi:** Elemen data privasi seperti `email_pelanggan`, `no_hp_pelanggan`, dan `tgl_lahir` dibatasi hak aksesnya. Petugas Gudang dan pihak ekspedisi hanya memiliki izin baca (Read) pada elemen nama pembeli, no HP, dan `alamat_pengiriman` pada tabel pesanan, namun tidak dapat melihat profil lengkap pelanggan di master data.

## 10. Isu Kualitas Data yang Diantisipasi
*   **Ketidakkonsistenan Format No HP:** Pelanggan sering memasukkan no HP dengan awalan yang berbeda-beda (+62, 62, 08), sehingga dapat menyulitkan saat notifikasi dikirim.
*   **Penulisan Alamat Kurang Lengkap:** Terdapat risiko pelanggan tidak mencantumkan kodepos, kecamatan, atau kelurahan dengan detail, yang dapat memicu gagal kirim (retur) dari kurir.
*   **Email Tidak Valid/Typo:** Kesalahan ketik domain email (misal: @gmil.com atau @yaho.com) yang membuat sistem gagal mengirimkan struk invoice digital.