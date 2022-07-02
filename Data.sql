create database QuanLyQuanCafe
go
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE ON
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY SIMPLE
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF
GO
use QuanLyQuanCafe
go

create table TableFood
(
id INT IDentity primary key,
name nvarchar(100)not null default N'Bàn chưa có tên',
status nvarchar(50) not null default N'Trống',
)
go
create table AccountType
(type int primary key not null,
name nvarchar(100) not null default N'Nhân viên'
)
go
create table Account 
(
UserName varchar(32) not null primary key,
PassWord varchar(32) not null,
displayname nvarchar(100) not null,
type int not null default 0,
foreign key (type) references dbo.AccountType(type),
)
go
create table FoodCategory
(
id int identity primary key,
name nvarchar(100) not null default N'Chưa đặt tên',
)
create table  Food
(id int identity primary key,
name nvarchar(100) not null default N'Chưa đặt tên',
idCategory int not null,
price float not null,
foreign key (idCategory) references dbo.FoodCategory(id),
)
create table Bill
(id int identity primary key,
DateCheckIn datetime not null default getdate(),
DateCheckOut datetime,
idTable int not null,
status int not null default 0,
discount int not null,
totalPrice float,
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
---------------
insert into dbo.AccountType values(1,N'Admin');
insert into dbo.AccountType values(0,N'Nhân viên')
------------tai khoan---------
insert into dbo.Account values ('admin','1234','Admin',1);
insert into dbo.Account values ('nv001','1234',N'Nhân viên 1',0);
insert into dbo.Account values ('nv002','1234',N'Nhân viên 2',0);

-----------Loai-----------
insert into dbo.FoodCategory values(N'Cafe');
insert into dbo.FoodCategory values(N'Trà sửa');
insert into dbo.FoodCategory values(N'Yaourt');
insert into dbo.FoodCategory values(N'Đồ ăn');

-------------Đồ uống + ăn-----------------------
insert into dbo.Food values(N'Cafe đen',1,15000);
insert into dbo.Food values(N'Cafe sữa',1,17000);
insert into dbo.Food values(N'Bạc xỉu',1,20000);
insert into dbo.Food values(N'Cafe dừa',1,24000);
insert into dbo.Food values(N'Trà sửa truyền thống',2,18000);
insert into dbo.Food values(N'Trà sửa socola',2,20000);
insert into dbo.Food values(N'Trà sửa dâu',2,20000);
insert into dbo.Food values(N'Yaourt hạt đát',3,22000);
insert into dbo.Food values(N'Yaourt đá',3,20000);
insert into dbo.Food values(N'Yaourt mít đát',3,24000);
insert into dbo.Food values(N'Mì tôm trứng',4,22000);
insert into dbo.Food values(N'Mì tôm trứng + xúc xích',4,25000);

-----them table------
declare @i int = 1
while @i <= 15
begin
	insert into dbo.TableFood(name) values (N'Bàn'+ cast(@i as nvarchar(100)))
	set @i = @i +1
end

-------------------
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

-----------
create proc USP_GetTableList
as select * from dbo.TableFood
go


go
CREATE PROC dbo.USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT	dbo.Bill 
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idTable ,
	          status,
	          discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @idTable , -- idTable - int
	          0,  -- status - int
	          0	  
	        )
END
CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill,
          @idFood, 
          @count  
          )
	END
	END
END


------------
create trigger UTG_UpdateBillInfo
on dbo.BillInfo for insert, update
as
begin
	declare @idBill int
	select @idBill = idBill from Inserted
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id = @idBill and status = 0
	update dbo.TableFood set status = N' Có người' where id = @idTable
end
go
---------
------------
create trigger UTG_UpdateBill
on dbo.Bill	 for update
as
begin 
	declare @idBill int
	select @idBill = id from Inserted
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id = @idBill 
	declare @count int = 0 
	select @count = count(*) from dbo.Bill where idTable = @idTable and status = 0
	if(@count =0)
		update dbo.TableFood set status = N'Trống' where id = @idTable
end
go


CREATE PROC dbo.USP_SwitchTable
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO
--------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC dbo.USP_GetListBillByDate
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [Tên bàn], b.totalPrice*1000 AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC dbo.USP_UpdateAccount
@userName VARCHAR(100), @displayName NVARCHAR(100), @password VARCHAR(100), @newPassword VARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO

create trigger UTG_DeleteBillInfo
on dbo.BillInfo for delete
as
begin
	declare @idBillInfo int
	declare @idBill int
	select @idBillInfo = id, @idBill = deleted.idBill from deleted
	
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id = @idBill
	declare @count int = 0
	select @count = count(*) from dbo.BillInfo as bi, dbo.Bill as b where b.id = bi.idBill and b.id = @idBill and status = 0
	
	if(@count = 0)
		update dbo.TableFood set status = N'Trống' where id=@idTable
end
------ function tim gan dung
CREATE FUNCTION dbo.fuConvertToUnsign1 ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
-----------


CREATE alter PROC dbo.USP_GetListBillByDateAndPage
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	
	declare @pageRows INT = 10
	declare @selectRows INT = @pageRows
	declare @exceptRows INT = (@page - 1) * @pageRows
	
	;with BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	from dbo.Bill AS b,dbo.TableFood AS t, dbo.BillInfo as bi
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable and b.ID = bi.id)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow) 
END
go
-----------------------------
create proc dbo.USP_GetNumBillByDate
@checkIn date, @checkOut date
as 
begin
	select COUNT(*)
	from dbo.Bill as b,dbo.TableFood AS t
	where DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
end
go
------------------------------
CREATE alter PROC dbo.usp_GetTotalPrice
@checkIn datetime, @checkOut datetime
AS	
	SELECT sum(b.totalPrice)
	from dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1 AND t.id = b.idTable
go
------lấy ra danh sach bill-----------
SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá], f.name [tên món] ,f.[]
	from dbo.Bill AS b,dbo.TableFood AS t, dbo.BillInfo as bi, dbo.Food as f
	WHERE   b.status = 1 AND t.id = b.idTable and b.ID = bi.id 
select 
