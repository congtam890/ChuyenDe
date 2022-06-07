create database QuanLyQuanCafe
go

use QuanLyQuanCafe
go

create table TableFood
(
id INT IDentity primary key,
name nvarchar(100)not null default N'Bàn chưa có tên',
status nvarchar(50) not null default N'Trống',
)
go
create table Account
(
UserName varchar(32) not null primary key,
PassWord varchar(32) not null,
displayname nvarchar(100) not null,
type int not null default 0
)
go
create table FoodCategory(
id int identity primary key,
name nvarchar(100) not null default N'Chưa đặt tên',
)
create table Food
(id int identity primary key,
name nvarchar(100) not null default N'Chưa đặt tên',
idCategory int not null,
price float not null,
foreign key (idCategory) references dbo.foodcategory(id),
)

create table Bill
(id int identity primary key,
DateCheckIn date not null default getdate(),
DateCheckOut date,
idTable int not null,
status int not null default 0,
foreign key (idTable) references dbo.TableFood(id)
)
create  table BillInfo
(
id int identity primary key,
idBill int not null,
idFood int not null,
count int not null default 0,
foreign key (idBill) references dbo.Bill(id),
foreign key (idFood) references dbo.Food(id)
)

insert into dbo.Account values ('admin','1234','Admin',1);
insert into dbo.Account values ('nv001','1234',N'Nhân viên 1',0);
insert into dbo.Account values ('nv002','1234',N'Nhân viên 2',0);

select * from dbo.Account

go
CREATE PROC dbo.USP_Login
@userName varchar(100), @passWord varchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
create proc USP_GetListAccountByUserName
@userName nvarchar(100)
as
begin
select * from dbo.Account where UserName=@userName
end
go

exec dbo.USP_GetListAccountByUserName @userName = N'nv001'


declare @i int = 1
while @i <= 10
begin
	insert into dbo.TableFood(name) values (N'Bàn'+ cast(@i as nvarchar(100)))
	set @i = @i +1
end

select * from dbo.TableFood
go

create proc USP_GetTableList
as select * from dbo.TableFood
go

exec dbo.USP_GetTableList

update dbo.TableFood set status = N'Có người' where id = 9