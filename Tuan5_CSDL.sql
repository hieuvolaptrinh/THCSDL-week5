create database TUAN5_NHOM2_TCSDL204
GO
USE TUAN5_NHOM2_TCSDL204
GO
create table KhachHang
(
	MaKhachHang char(20) primary key,
	TenCongTy nvarchar(50) not null,
	TenGiaoDich nvarchar(50) not null,
	DiaChi nvarchar(100) not null,
	Email varchar(30) not null,
	DienThoai varchar(11) unique,
	Fax char (10) unique
)

go

create table NhanVien 
(
	MaNhanVien char(20) primary key,
	Ho nvarchar (20) not null,
	Ten nvarchar (15) not null,
	NgaySinh date,
	NgayLamViec date not null, 
	DiaChi nvarchar(100),
	DienThoai varchar(11) unique,
	LuongCoBan decimal(10, 2),
	PhuCap decimal(9, 2)
)
go 

create table LoaiHang
(
	MaLoaiHang char(20) primary key,
	TenLoaiHang nvarchar(50) not null
)

go

create table NhaCungCap
(
	MaCongTy char(20) primary key,
	TenCongTy  nvarchar(50) not null,
	TenGiaoDich nvarchar(50) not null,
	DiaChi nvarchar (50) not null,
	DienThoai varchar(11) unique,
	Email varchar(30) unique,
	Fax char(10) unique
)

go


create table MatHang
(
	MaHang char(10) primary key,
	TenHang nvarchar(30) not null,
	MaCongTy char(20),
	MaLoaiHang char(20),
	SoLuong int,
	DonViTinh nvarchar(20),
	GiaHang decimal(10, 2),
	constraint FK_MaCT_MatHang foreign key (MaCongTy) references NhaCungCap(MaCongTy),
	constraint FK_MaLH_MatHang foreign key (MaLoaiHang) references LoaiHang(MaLoaiHang),
	constraint DieuKienSoLuong check (
		SoLuong > 0
	)
)

go

create table DonDatHang
(	
	SoHoaDon char(20) primary key,
	MaKhachHang char(20),
	MaNhanVien char(20),
	NgayDatHang datetime,
	NgayGiaoHang datetime,
	NgayChuyenHang datetime ,
	NoiGiaoHang nvarchar(100) not null,
	constraint DieuKienNgay check(
		NgayDatHang <= NgayGiaoHang and
		NgayChuyenHang >= NgayDatHang
	),
	constraint FK_MaNV_DDH foreign key (MaNhanVien) references NhanVien(MaNhanVien),
	constraint FK_MaNV_MKH foreign key (MaKhachHang) references KhachHang(MaKhachHang)

)
go

create table ChiTietDonHang
(
	SoHoaDon char(20),
	MaHang char(10),
	GiaBan decimal (10, 2) not null,
	SoLuong int,
	MucGiamGia decimal(5, 2)
	primary key (SoHoaDon, MaHang),
	constraint DKSoLuong check (
		SoLuong > 0
	),
	FOREIGN KEY (SoHoaDon) REFERENCES DonDatHang(SoHoaDon),
	FOREIGN KEY (MaHang) REFERENCES MatHang(MaHang)

)


