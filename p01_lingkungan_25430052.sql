-- p01_lingkungan_25430052.sql

-- 1. Menyiapkan basis data praktik (Kopma)
CREATE DATABASE IF NOT EXISTS kopma_052 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'mhs_052'@'localhost' IDENTIFIED BY 'MhsKopma#2026';
GRANT ALL PRIVILEGES ON kopma_052.* TO 'mhs_052'@'localhost';

-- 2. Menyiapkan basis data proyek mandiri (Toko Daring)
CREATE DATABASE IF NOT EXISTS toko_052 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'dev_052'@'localhost' IDENTIFIED BY 'DevToko#2026';
GRANT ALL PRIVILEGES ON toko_052.* TO 'dev_052'@'localhost';