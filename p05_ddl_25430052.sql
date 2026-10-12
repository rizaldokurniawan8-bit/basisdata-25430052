-- P05_ddl_25430052.sql
-- Tema: Toko Daring (toko_052)
-- Menghapus tabel dari anak ke induk agar dapat diulang tanpa error (ERROR 1050 / 1451)
DROP TABLE IF EXISTS pengiriman;
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS pelanggan;

-- TABEL INDUK 1: pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT NOT NULL AUTO_INCREMENT,
    no_pelanggan CHAR(6) NOT NULL,
    nama_pelanggan VARCHAR(100) NOT NULL,
    no_hp_pelanggan VARCHAR(15) NOT NULL, -- Data Pribadi
    alamat_pelanggan VARCHAR(200) NOT NULL,
    PRIMARY KEY (id_pelanggan),
    UNIQUE KEY uq_pelanggan_no (no_pelanggan),
    UNIQUE KEY uq_pelanggan_hp (no_hp_pelanggan)
) ENGINE=InnoDB;

-- TABEL INDUK 2: barang
CREATE TABLE barang (
    id_barang INT NOT NULL AUTO_INCREMENT,
    kode_barang VARCHAR(10) NOT NULL,
    nama_barang VARCHAR(100) NOT NULL,
    harga_jual_barang DECIMAL(12,2) NOT NULL,
    stok_barang INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_barang),
    UNIQUE KEY uq_barang_kode (kode_barang),
    CONSTRAINT ck_barang_stok CHECK (stok_barang >= 0), -- AB: Stok tidak boleh minus
    CONSTRAINT ck_barang_harga CHECK (harga_jual_barang > 0)
) ENGINE=InnoDB;

-- TABEL KEPALA TRANSAKSI: pesanan
CREATE TABLE pesanan (
    id_pesanan INT NOT NULL AUTO_INCREMENT,
    no_pesanan CHAR(12) NOT NULL,
    tgl_pesanan DATETIME NOT NULL,
    id_pelanggan INT NOT NULL,
    status_pesanan ENUM('pending', 'dibayar', 'dikirim', 'selesai') NOT NULL DEFAULT 'pending',
    PRIMARY KEY (id_pesanan),
    UNIQUE KEY uq_pesanan_no (no_pesanan),
    CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) 
        REFERENCES pelanggan (id_pelanggan)
) ENGINE=InnoDB;

-- TABEL DETAIL TRANSAKSI: detail_pesanan
CREATE TABLE detail_pesanan (
    id_pesanan INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_pesanan SMALLINT NOT NULL,
    harga_satuan_detail_pesanan DECIMAL(12,2) NOT NULL, -- AB: Harga disalin saat transaksi
    PRIMARY KEY (id_pesanan, id_barang),
    CONSTRAINT fk_detail_pesanan FOREIGN KEY (id_pesanan) 
        REFERENCES pesanan (id_pesanan) ON DELETE CASCADE,
    CONSTRAINT fk_detail_barang FOREIGN KEY (id_barang) 
        REFERENCES barang (id_barang),
    CONSTRAINT ck_detail_qty CHECK (qty_detail_pesanan > 0),
    CONSTRAINT ck_batas_item_p CHECK (qty_detail_pesanan <= 10) -- Batas P+2 (10 item max) per baris
) ENGINE=InnoDB;

-- TABEL ANAK TRANSAKSI: pengiriman
CREATE TABLE pengiriman (
    id_pengiriman INT NOT NULL AUTO_INCREMENT,
    id_pesanan INT NOT NULL,
    kurir_pengiriman VARCHAR(50) NOT NULL,
    no_resi_pengiriman VARCHAR(30) NOT NULL,
    tgl_pengiriman DATETIME NOT NULL,
    PRIMARY KEY (id_pengiriman),
    UNIQUE KEY uq_pengiriman_pesanan (id_pesanan),
    UNIQUE KEY uq_pengiriman_resi (no_resi_pengiriman),
    CONSTRAINT fk_pengiriman_pesanan FOREIGN KEY (id_pesanan) 
        REFERENCES pesanan (id_pesanan) ON DELETE CASCADE
) ENGINE=InnoDB;