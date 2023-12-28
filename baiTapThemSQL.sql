use quanLyTruongHoc;

CREATE TABLE DMKHOA(
	MaKhoa VARCHAR(20)  PRIMARY KEY,
	TenKhoa VARCHAR(255)	
);

INSERT INTO DMKHOA(MaKhoa,TenKhoa) VALUES
("CNTT","Công Nghệ Thông Tin"),
("KT","Kế Toán"),
("SP","Sư Phạm");


CREATE TABLE DMNGANH(
	MaNganh INT PRIMARY KEY,
	TenNganh VARCHAR(255),
	MaKhoa VARCHAR(20),
	FOREIGN KEY (MaKhoa) REFERENCES DMKHOA(MaKhoa)
);	

INSERT INTO DMNGANH(MaNganh,TenNGanh,MaKhoa) VALUES
(140902,"Sư Phạm Toán Tin","SP"),
(480202,"Tin Học Ứng Dụng","CNTT");

CREATE TABLE DMLOP(
	MaLop VARCHAR(20) PRIMARY KEY,
	TenLop VARCHAR(255),
	MaNganh INT,
	FOREIGN KEY(MaNganh) REFERENCES DMNGANH(MaNganh),
	KhoaHoc INT,
	HeDT VARCHAR(10),
	NamNhapHoc YEAR
);

INSERT INTO DMLOP(MaLop,TenLop,MaNganh,KhoaHoc,HeDT,NamNhapHoc) VALUES
("CT11","Cao đẳng tin học",480202,11,"TC",2013),
("CT12","Cao đẳng tin học",480202,12,"CĐ",2013),
("CT13","Cao đẳng tin học",480202,13,"CĐ",2014);

CREATE TABLE SINHVIEN(
	MaSV INT PRIMARY KEY,
	HoTen VARCHAR(255),
	MaLop VARCHAR(20),
	FOREIGN KEY(MaLop) REFERENCES DMLOP(MaLop),
	GioiTinh BOOLEAN,
	NgaySinh DATE,
	DiaChi VARCHAR(255)
);

INSERT INTO SINHVIEN(MaSV,HoTen,MaLop,GioiTinh,NgaySinh,DiaChi) VALUES
(1,"Phan Thanh","CT12",FALSE,"1990-12-09","Tuy Phước"),
(2,"Nguyễn Thị Cẩm","CT12",TRUE,"1994-12-01","Quy Nhơn"),
(3,"Võ Thị Hà","CT12",TRUE,"1995-02-07","An Nhơn"),
(4,"Trần Hoài Nam","CT12",FALSE,"1994-05-04","Tây Sơn"),
(5,"Trần Văn Hoàng","CT13",FALSE,"1995-04-08","Vĩnh Thạnh"),
(6,"Đặng Thị Thảo","CT13",TRUE,"1995-12-06","Quy Nhơn"),
(7,"Lê Thị Sen","CT13",TRUE,"1994-12-08","Phù Cát"),
(8,"Nguyễn Văn Huy","CT11",FALSE,"1995-04-06","Phù Mỹ"),
(9,"Trần Thị Hoa","CT11",TRUE,"1994-09-08","Hoài Nhơn");

CREATE TABLE DMHOCPHAN(
	MaHP INT PRIMARY KEY,
	TenHP VARCHAR(255),
	MaNganh INT,
	FOREIGN KEY (MaNganh) REFERENCES DMNGANH(MaNganh),
	Sodvht INT,
	HocKy INT	
);

INSERT INTO DMHOCPHAN(MaHP,TenHP,Sodvht,MaNganh,HocKy) VALUES
(1,"Toán Cao Cấp A1",4,480202,1),
(2,"Tiếng Anh 1",3,480202,1),
(3,"Vật lí đại cương",4,480202,1),
(4,"Tiếng Anh 2",7,480202,1),
(5,"Tiếng Anh 3",3,140902,2),
(6,"Xác suất thống kê",3,140902,2);

CREATE TABLE DIEMHP(
	MaSV INT,
	FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MaSV),
	MaHP INT,
	FOREIGN KEY(MaHP) REFERENCES DMHOCPHAN(MaHP),
	DiemHP FLOAT
);

INSERT INTO DIEMHP(MaSV,MaHP,DiemHP) VALUES
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4.0),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4.0),
(7,1,6.2);

-- 1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5.

SELECT sv.MaSV , sv.HoTen,sv.MaLop, dhp.DiemHP , dhp.MaHP FROM SINHVIEN as sv
INNER JOIN DIEMHP as dhp
ON sv.MaSV = dhp.MaSV
WHERE dhp.DiemHP >= 5;

-- 2. Hiển thị danh sách MaSV, HoTen , MaLop, MaHP, DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần.

SELECT sv.MaSV , sv.HoTen,sv.MaLop, dhp.DiemHP , dhp.MaHP FROM SINHVIEN as sv
INNER JOIN DIEMHP as dhp
ON sv.MaSV = dhp.MaSV
ORDER BY sv.MaLop , sv.HoTen ASC;

-- 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I.

SELECT sv.MaSV , sv.HoTen,sv.MaLop, dhp.DiemHP , dhp.MaHP FROM SINHVIEN as sv
INNER JOIN DIEMHP as dhp
ON sv.MaSV = dhp.MaSV
INNER JOIN DMHOCPHAN as dmhp
ON dmhp.MaHP = dhp.MaHP
WHERE (dhp.DiemHP >=5) AND (dhp.DiemHP<=7) AND(dmhp.HocKy=1);

-- 4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT.

SELECT sv.MaSV,sv.HoTen,sv.MaLop,dml.TenLop,dmn.MaKhoa FROM SINHVIEN as sv 
INNER JOIN DMLOP as dml
ON sv.MaLop = dml.MaLop
INNER JOIN DMNGANH as dmn
ON dmn.MaNganh = dml.MaNganh
WHERE dmn.MaKhoa = "CNTT";

-- 5.Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp.

SELECT dml.MaLop , dml.TenLop , COUNT(sv.MaLop) as Tong_Sinh_Vien_LOP FROM DMLOP as dml 
INNER JOIN SINHVIEN as sv
ON dml.MaLop = sv.MaLop
GROUP BY sv.MaLop;

-- 6.Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ.

SELECT sv.MaSV,sv.HoTen,AVG(dhp.DiemHP) as diem_TB,dmhp.HocKy FROM SINHVIEN as sv
INNER JOIN DIEMHP as dhp
ON sv.MaSV = dhp.MaSV
INNER JOIN DMHOCPHAN as dmhp
ON dmhp.MaHP = dhp.MaHP
GROUP BY sv.MaSV , dmhp.HocKy
ORDER BY sv.MaSV ASC;

-- test 
-- SELECT * FROM SINHVIEN as sv
-- INNER JOIN DIEMHP as dhp
-- ON sv.MaSV = dhp.MaSV
-- INNER JOIN DMHOCPHAN as dmhp
-- ON dmhp.MaHP = dhp.MaHP
-- ORDER BY sv.MaSV

-- 7. Cho biết MaLop, TenLop có tổng số sinh viên >10.

SELECT dml.MaLop , dml.TenLop , COUNT(sv.MaLop) as Tong_Sinh_Vien_LOP FROM DMLOP as dml 
INNER JOIN SINHVIEN as sv
ON dml.MaLop = sv.MaLop
GROUP BY sv.MaLop
HAVING Tong_Sinh_Vien_LOP>10;

-- 8. Cho biết HoTen sinh viên có điểm Trung bình chung các học phần < 3.

-- SELECT * FROM SINHVIEN as sv
-- INNER JOIN DIEMHP as dhp
-- ON sv.MaSV = dhp.MaSV;

SELECT sv.HoTen ,dmhp.HocKy, AVG(dhp.DiemHP) as Diem_TB FROM SINHVIEN as sv
INNER JOIN DIEMHP as dhp
ON sv.MaSV = dhp.MaSV
INNER JOIN DMHOCPHAN as dmhp 
ON dmhp.MaHP = dhp.MaHP
GROUP BY sv.MaSV , dmhp.HocKy
HAVING Diem_TB < 3;

-- 9. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5.

-- check
-- SELECT * FROM SINHVIEN as sv 
-- INNER JOIN DIEMHP as dhp 
-- ON sv.MaSV = dhp.MaSV
-- WHERE dhp.DiemHP < 5;

SELECT sv.MaSV,sv.HoTen FROM SINHVIEN as sv 
INNER JOIN DIEMHP as dhp 
ON sv.MaSV = dhp.MaSV
WHERE dhp.DiemHP < 5
GROUP BY sv.MaSV
HAVING COUNT(dhp.MaHP) >=2;

-- 10. Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5


-- check
-- SELECT * FROM SINHVIEN as sv 
-- LEFT JOIN DIEMHP as dhp
-- ON sv.MaSV = dhp.MaSV;

SELECT sv.MaSV, sv.HoTen FROM SINHVIEN as sv 
WHERE sv.MaSV NOT IN (
	SELECT dhp.MaSV FROM DIEMHP as dhp 
	WHERE dhp.DiemHP < 5
);

-- 11. Cho biết Họ tên sinh viên KHÔNG học học phần nào.

SELECT sv.MaSV,sv.HoTen FROM SINHVIEN as sv 
LEFT JOIN DIEMHP as dhp 
ON sv.MaSV = dhp.MaSV
WHERE dhp.MaHP IS NULL;

-- 12. Cho biết Tên lớp có sinh viên tên Hoa.

SELECT dml.MaLop, dml.TenLop FROM SINHVIEN as sv 
INNER JOIN DMLOP as dml 
ON sv.MaLop = dml.MaLop
WHERE sv.HoTen LIKE "%Hoa";

