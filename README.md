# Analyzing eCommerce Business Performance with SQL: Project Overview
Berperan sebagai anggota dari tim Data Analytics di sebuah perusahaan eCommerce dengan tugas untuk menganalisis tiga aspek yang berkaitan dengan performa bisnis perusahaan :
- Pertumbuhan Pelanggan
- Kualitas Produk
- Tipe Pembayaran
## Data Preparation
Langkah-langkah yang dilakukan untuk menyiapkan data adalah sebagai berikut :
- Membuat database baru beserta tabelnya dan menentukan tipe data dari setiap kolom
- Mengimport data dari csv ke dalam database yang sudah di buat
- Membuat Entity Relationship Diagram (ERD) antar tabel
![ERD](https://user-images.githubusercontent.com/99067834/163707816-c361adba-e472-459c-89d5-f3b7b01f6552.jpg)
## Annual Customer Activity Growth Analysis
- Ada pengingkatan aktifitas customer diikuti dengan penambahan customer baru dari tahun 2017 ke 2018
![Rata-rata MAU per Tahun](https://user-images.githubusercontent.com/99067834/163708164-87a07eae-b43b-466d-a3fa-defde8ff1274.png)
![Total Customer Baru Per Tahun](https://user-images.githubusercontent.com/99067834/163708231-0c610f06-31d6-4d51-abe7-d29317fe1e7a.png)
- Ada penurunan jumlah customer yang melakukan repeat order<br/>
![Customer yang melakukan repeat order per tahun](https://user-images.githubusercontent.com/99067834/163708312-eec2468d-b38b-49e9-ba16-7396382a2983.png)
- Rata-rata customer melakukan order hanya 1 kali dalam 1 tahun<br/>
![Rata-rata frekuensi order untuk setiap tahun](https://user-images.githubusercontent.com/99067834/163708344-fd3207d2-6e42-498d-8166-67007430040f.png)
## Annual Product Category Quality Analysis
- Ada peningkatan revenue yang signifikan. Untuk kategori produk yang paling banyak di beli, berbeda setiap tahunnya begitu pula dengan kategori produk yang di cancel
![Product Category Quality Analysis](https://user-images.githubusercontent.com/99067834/163708683-b7f5c4bb-a4cc-405a-9768-0914971e93bc.png)
## Analysis of Annual Payment Type Usage
- Credit card menjadi tipe pembayaran yang paling banyak digunakan oleh customer dan debit card menjadi tipe pembayaran yang paling sedikit digunakan oleh customer<br/>
![Annual Payment Type Usage](https://user-images.githubusercontent.com/99067834/163708800-92b7e9a8-6e39-4ebc-86c8-1dfeb49114c1.png)
