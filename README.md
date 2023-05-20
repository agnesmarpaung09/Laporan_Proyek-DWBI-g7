# Data Mart-based Dashboard for Kickstarter Crowdfunding 2022

## Deskripsi
Data Mart-based Dashboard for Kickstarter Crowdfunding 2022 adalah proyek mata kuliah Data Warehouse and Business Intelligence (DWBI) yang menganalisis data Kickstarter pada tahun 2022 mulai dari bulan Januari sampai Desember. Kickstarter adalah sebuah platform crowdfunding yang memungkinkan individu untuk mengumpulkan dana dari masyarakat umum guna mendukung proyek kreatif atau inovatif. Melalui Kickstarter, pendiri proyek dapat membuat kampanye dengan menentukan tujuan pendanaan dan batas waktu untuk mencapainya. Ragam proyek yang didukung melalui platform ini sangat beragam, mulai dari pengembangan permainan video, film independen, album musik, buku, produk teknologi, produk desain, hingga proyek komunitas atau amal. Pengguna Kickstarter dapat memberikan sumbangan finansial kepada proyek yang mereka minati. Kickstarter telah menjadi platform populer bagi kreator dan inovator untuk mendapatkan dukungan keuangan dan mempertahankan kendali kreatif terhadap proyek mereka.

## Latar Belakang
Pada saat ini, teknologi semakin berkembang pesat.  Dengan adanya perkembangan dari teknologi ini tentunya memudahkan dalam menghasilkan sekumpulan data yang cukup bahkan sangat besar dimana data tersebut dapat diimplementasikan ke dalam DBMS (Database Management System). DBMS diolah dan digunakan untuk memperoleh berbagai informasi yang akurat, berguna, dan cepat.
Kickstarter merupakan sebuah platform pendanaan terbesar untuk proyek kreatif di dunia saat ini.Penggunaan data warehouse pada Kickstarter bertujuan untuk mengumpulkan, mengintegrasikan, dan menganalisis data dari berbagai sumber yang berbeda terkait dengan kampanye crowdfunding yang dilakukan di platform mereka. Dalam hal ini, data warehouse dapat membantu Kickstarter dalam pengambilan keputusan bisnis yang diterapkan. Proses sinkronisasi di dalam data warehouse juga disebut dengan ETL (extract, transform, dan load) yang merupakan proses yang menghubungkan data transaksi dan media penyimpan. Pada data warehouse diperlukan database metadata yang berguna untuk mendeskripsikan data dan mendefinisi setiap tabel yang ada. Pada Kickstarter juga terdapat penggunaan data mart yang berguna untuk membantu perusahaan untuk mendapatkan pemahaman yang lebih baik tentang data tertentu dan mengeksplorasi lebih dalam mengenai data tersebut. Data mart adalah subset dari data warehouse yang ditujukan untuk mengumpulkan data yang spesifik dan fokus pada area tertentu dari bisnis.

## Ruang Lingkup Implementasi
| Komponen                            | Alat                      |
| ----------------------------------- | ------------------------- |     
| Data Mart                           | Json                      |
| Extract, Transform, and Load        | Pentaho Data Integration  |
| Business Intelligence Apllication   | Tableau Public            |

## Model Dimensi
1. Dimensi Creator 
    -> berisi atribut creator_id dan creator_name.
2. Dimensi Location 
    -> berisi atribut location_id dan location_name.
3. Dimensi Date 
    -> berisi atribut period.
4. Dimensi Project 
    -> berisi atribut project_id dan project_name.
5. Fact Campaign 
    -> berisi atribut campaign_id, creator_id, location_id, period, dan project_id.
