/* 
1.先建立資料庫
	create database Onlineordersys
2.將資料庫權限移交給 pyuser (需先創立pyuser這個使用者)
	USE master
	GO
	ALTER AUTHORIZATION ON DATABASE::Onlineordersys TO pyuser
3.建立資料表
*/
use Onlineordersys

-- 餐點類型
create table MenuType(
    TypeID int primary key identity not null , -- 餐點類型ID
    DishType nvarchar(50) unique not null	   -- 餐點類型名稱，不可重複
    )

-- 菜單
create table menu(
    DisherID int primary key identity not null, -- 餐點ID
    dishes nvarchar(50) unique not null,        -- 餐點名稱，不可重複
    price int not null,						    -- 單品價格
	TypeID int foreign key references MenuType(TypeID) on delete cascade not null -- 餐點的類型
    )

-- 可選屬性種類
-- 乾湯、大小、主食等等
create table MenuItems(
    MenuItemsID int primary key not null,   -- 可選屬性種類ID
    items nvarchar(50) unique null          -- 可選屬性種類名稱
    )
	
-- 各種類有的詳細名稱
-- 例如：份量 有 大、小；乾湯 有 乾、湯
create table MenuPlus(
    SideDishID int primary key identity  not null,  -- 種類詳細ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade not null, -- 可選屬性種類ID
    dishes nvarchar(50) unique not null,   -- 種類詳細名稱
    )

-- 類型可選種類關聯
-- 例如：麵食可以「加大」、「乾湯」；鍋燒可以「主食」
create table MenuChoose(
    TypeID int foreign key references MenuType(TypeID) on delete cascade not null,        -- 類型ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade　null -- 可以有的種類選擇
    )
  
-- 座位
create table seat(
    TableID int primary key  not null,  -- 桌號(ID)
    seat int not null,					-- 可容納人數
    )

-- 員工
create table staff(
    UserID int identity not null,             -- 人員編號
	Email nvarchar(50) primary key not null,  -- 帳號(E-mail)
	PW nvarchar(50) not null,                 -- 密碼                     
    personnel nvarchar(50)  not null          -- 階級
    )

-- 訂單紀錄
create table OrderMeterial(
    OrderNum int primary key identity not null, -- 訂單編號
    OrderTime datetime not null,				-- 訂單產生時間
    PayTime datetime null,						-- 結帳時間
    TableID int foreign key references seat(TableID) not null, -- 桌號
	token nvarchar(50) unique not null			-- 識別碼 
    )

-- 訂單紀錄明細
create table OrderRecord(
    OrderID int primary key identity not null,									-- 訂單紀錄詳細ID
    OrderNum int references OrderMeterial(OrderNum) on delete cascade not null, -- 訂單編號 (參考訂單紀錄)
    DisherID int foreign key references menu(DisherID) not null,				-- 餐點ID
    Quantity int not null,														-- 數量
    TableID int foreign key references seat(TableID) not null					-- 桌號
    )





