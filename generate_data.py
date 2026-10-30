import random

print("DELETE FROM detail_pesanan;\nDELETE FROM pesanan;\nDELETE FROM barang;\nDELETE FROM pelanggan;\n")

print("INSERT INTO pelanggan (id_pelanggan, no_pelanggan, nama_pelanggan, no_hp_pelanggan, alamat_pelanggan) VALUES")
print("(1, 'CUS001', 'Andi Saputra', '0811111111', 'Jl. Mawar 1, Metro'),")
print("(2, 'CUS002', 'Budi Santoso', '0822222222', 'Jl. Melati 2, Metro'),")
print("(3, 'CUS003', 'Citra Kirana', '0833333333', 'Jl. Anggrek 3, Bandar Lampung'),")
print("(4, 'CUS004', 'Dina Wijaya', '0844444444', 'Jl. Kenanga 4, Bandar Lampung'),")
print("(5, 'CUS005', 'Eko Pratama', '0855555555', 'Jl. Kamboja 5, Metro');\n")

print("INSERT INTO barang (id_barang, kode_barang, nama_barang, harga_jual_barang, stok_barang) VALUES")
print("(1, 'BRG01', 'Kaos Polos Hitam RK', 55000, 100),")
print("(2, 'BRG02', 'Kemeja Flanel RK', 125000, 75),")
print("(3, 'BRG03', 'Jaket Denim RK', 250000, 40),")
print("(4, 'BRG04', 'Celana Chino RK', 150000, 80),")
print("(5, 'BRG05', 'Jaket Hoodie RK', 185000, 50);\n")

print("INSERT INTO pesanan (id_pesanan, no_pesanan, tgl_pesanan, id_pelanggan, status_pesanan) VALUES")
orders = []
for i in range(1, 41):
    id_pes = 100 + i
    no_pes = f"'ORD-{id_pes:03d}'"
    tgl = random.choice(["'2026-10-20 10:00:00'", "'2026-10-21 14:00:00'", "'2026-10-22 09:30:00'"])
    id_pel = random.randint(1, 5)
    stat = random.choice(["'pending'", "'dibayar'", "'dikirim'", "'selesai'"])
    orders.append(f"({id_pes}, {no_pes}, {tgl}, {id_pel}, {stat})")

print(",\n".join(orders) + ";\n")

print("INSERT INTO detail_pesanan (id_pesanan, id_barang, qty_detail_pesanan, harga_satuan_detail_pesanan) VALUES")
details = []
prices = {1: 55000, 2: 125000, 3: 250000, 4: 150000, 5: 185000}

for i in range(1, 41):
    id_pes = 100 + i
    items = random.sample([1, 2, 3, 4, 5], 2) # Ambil 2 barang unik per pesanan
    for item in items:
        qty = random.randint(1, 3)
        harga = prices[item]
        details.append(f"({id_pes}, {item}, {qty}, {harga})")

print(",\n".join(details) + ";")