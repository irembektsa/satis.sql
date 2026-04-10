create table kategoriler (
    kategori_id int primary key,
    kategori_adi varchar(50)
);

create table urunler (
    urun_id int primary key,
    urun_adi varchar(100),
    fiyat decimal(10, 2),
    kategori_id int,
    foreign key (kategori_id) references kategoriler(kategori_id)
);

create table musteriler (
    musteri_id int primary key,
    ad_soyad varchar(100),
    sehir varchar(50)
);

create table satislar (
    satis_id int primary key,
    musteri_id int,
    urun_id int,
    adet int,
    satis_tarihi date,
    foreign key (musteri_id) references musteriler(musteri_id),
    foreign key (urun_id) references urunler(urun_id)
);

insert into kategoriler values 
(1, 'Elektronik'), 
(2, 'Aksesuar');

insert into urunler values 
(101, 'Akıllı Telefon', 25000.00, 1), 
(102, 'Laptop', 45000.00, 1), 
(103, 'Kablosuz Kulaklık', 2000.00, 2);

insert into musteriler values 
(1, 'Ahmet Yılmaz', 'İstanbul'), 
(2, 'Ayşe Demir', 'Ankara'), 
(3, 'Caner Şahin', 'İzmir');

insert into satislar values 
(1001, 1, 101, 1, '2026-04-01'), 
(1002, 2, 102, 1, '2026-04-05'), 
(1003, 1, 103, 2, '2026-04-08'), 
(1004, 3, 101, 1, '2026-04-10');

select 
    m.ad_soyad as musteri, 
    u.urun_adi as urun, 
    s.adet, 
    (s.adet * u.fiyat) as toplam_tutar,
    s.satis_tarihi
from satislar s
join musteriler m on s.musteri_id = m.musteri_id
join urunler u on s.urun_id = u.urun_id
order by toplam_tutar desc;

select 
    k.kategori_adi, 
    sum(s.adet * u.fiyat) as toplam_kategori_geliri
from satislar s
join urunler u on s.urun_id = u.urun_id
join kategoriler k on u.kategori_id = k.kategori_id
group by k.kategori_adi;
