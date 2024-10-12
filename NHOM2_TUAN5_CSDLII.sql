create database NHOM2_TCSDLII
go

use NHOM2_TCSDLII
go

create table KHACHHANG 
( 
	MAKHACHHANG char(20) not null primary key,
	TENCONGTY nvarchar(50) not null,
	TENGIAODICH nvarchar(50) not null,
	DIACHI nvarchar(100) not null,
	EMAIL varchar(30) unique,
	DIENTHOAI varchar(11) unique,
	FAX char(10) unique
)
go

create table NHANVIEN
(
	MANHANVIEN char(20) not null primary key,
	HO nvarchar(20),
	TEN nvarchar(15) not null,
	NGAYSINH date,
	NGAYLAMVIEC date not null,
	DIACHI nvarchar(100) not null,
	DIENTHOAI varchar(11) unique,
	LUONGCOBAN decimal(10,2),
	PHUCAP decimal(9,2)
)
go

create table LOAIHANG
(
	MALOAIHANG char(20) not null primary key,
	TENLOAIHANG nvarchar(50) not null
)
go

create table NHACUNGCAP
(
	MACONGTY char(20) not null primary key,
	TENCONGTY nvarchar(50) not null,
	TENGIAODICH nvarchar(50) not null,
	DIACHI nvarchar(100) not null,
	DIENTHOAI varchar(11),
	EMAIL varchar(30),
	FAX char(10)
)
go

create table MATHANG
(
	MAHANG char(10) not null primary key,
	TENHANG nvarchar(30) not null,
	MACONGTY char(20) not null,
	MALOAIHANG char(20) not null,
	SOLUONG int,
	DONVITINH nvarchar(20),
	GIAHANG decimal(10,2),
	FOREIGN KEY(MACONGTY) REFERENCES NHACUNGCAP(MACONGTY),
	FOREIGN KEY(MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG),
	CONSTRAINT DK_SOLUONG CHECK (SOLUONG > 0)
)
go

create table DONDATHANG
(
	SOHOADON char(20) not null primary key,
	MAKHACHHANG char(20) not null,
	MANHANVIEN char(20) not null,
	NGAYDATHANG datetime,
	NGAYGIAOHANG datetime,
	NGAYCHUYENHANG datetime,
	NOIGIAOHANG nvarchar(100) not null,
	FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG),
	FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
	CONSTRAINT DK_NGAYGIAOHANG CHECK (NGAYGIAOHANG >= NGAYDATHANG),
	CONSTRAINT DK_NGAYCHUYENHANG CHECK (NGAYGIAOHANG > NGAYCHUYENHANG AND NGAYCHUYENHANG > NGAYDATHANG)
)
go

create table CHITIETDATHANG
(
	SOHOADON char(20) not null,
	MAHANG char(10) not null,
	GIABAN decimal(10,2) not null,
	SOLUONG int,
	MUCGIAMGIA decimal(5,2),
	PRIMARY KEY (SOHOADON,MAHANG),
	FOREIGN KEY (SOHOADON) REFERENCES DONDATHANG(SOHOADON),
	FOREIGN KEY (MAHANG) REFERENCES MATHANG(MAHANG)
)