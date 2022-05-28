create database QuanLyQuanCafe
go

use QuanLyQuanCafe
go

create table TableFood
(
id INT IDentity primary key,
name nvarchar(100),
status nvarchar(50),

)
go
create table Account
(
UserName varchar(32) not null primary key,
password varchar(32) not null,
displayname nvarchar(100) not null,
type int not null default 0
)
go
create table FoodCategory(
id int identity primary key,
name nvarchar(100) not null,
)
create table Food
(id int identity primary key,
name nvarchar(100) not null,
idCategory int not null,
price float not null,
foreign key (idCategory) references dbo.foodcategory(id),
)

create table Bill
(id int identity primary key,
DateCheckIn date not null,
DateCheckOut date,
idTable int not null,
status int not null default 0,
foreign key (idTable) references dbo.TableFood(id)
)
create table BillInfo
(
id int identity primary key,
idBill int not null,
idFood int not null,
count int not null default 0,
foreign key (idBill) references dbo.Bill(id),
foreign key (idFood) references dbo.Food(id)
)
