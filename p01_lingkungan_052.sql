-- p01_lingkungan_052.sql
-- Membuat basis data proyek Toko Pakaian
CREATE DATABASE IF NOT EXISTS toko_052
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Membuat akun khusus proyek dan memberikan hak akses
CREATE USER IF NOT EXISTS 'dev_052'@'localhost' IDENTIFIED BY 'PasswordToko#052';
GRANT ALL PRIVILEGES ON toko_052.* TO 'dev_052'@'localhost';