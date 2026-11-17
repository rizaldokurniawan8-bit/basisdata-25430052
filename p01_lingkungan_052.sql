-- p01_lingkungan_052.sql
-- 1. Membuat basis data praktikum (Kopma) dan proyek mandiri (Toko Daring)
CREATE DATABASE IF NOT EXISTS kopma_052
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS toko_052
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Membuat akun kerja dan akun tamu (password asli diganti penanda)
CREATE USER IF NOT EXISTS 'mhs_052'@'localhost' IDENTIFIED BY '<password_mhs>';
GRANT ALL PRIVILEGES ON kopma_052.* TO 'mhs_052'@'localhost';

CREATE USER IF NOT EXISTS 'dev_052'@'localhost' IDENTIFIED BY '<password_dev>';
GRANT ALL PRIVILEGES ON toko_052.* TO 'dev_052'@'localhost';

CREATE USER IF NOT EXISTS 'tamu_052'@'localhost' IDENTIFIED BY '<password_tamu>';
GRANT SELECT ON kopma_052.* TO 'tamu_052'@'localhost';

FLUSH PRIVILEGES;