-- create database Onlineordersys
-- drop database Onlineordersys
-- use Onlineordersys


-- delete from Menu
/*
select * from Menu
go
select * from MenuItems
go
select * from Menuplus
go
select * from Menuchoose
*/

--菜單
create table menu(
    DisherID int primary key identity not null, -- 料理 ID
    dishes nvarchar(50) not null,     -- 料理名稱
    HowMuch int not null,   -- 總金額
    )
create unique index same on menu(dishes)  -- 建立唯一索引 確保其欄位( 料理名稱 )值之唯一性

-- 品項類型 
create table MenuItems(
    MenuItemsID int primary key not null,   -- 品項的ID
    items nvarchar(50) null              ,  -- 品項名稱
    )

create unique index same on MenuItems(items)  -- 建立唯一索引 確保其欄位( B[品項名稱] )值之唯一性

-- 品項屬性(配料)
create table MenuPlus(
    SideDishID int primary key identity not null,  -- 配料 ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade not null, -- 對應到甚麼類型的料理
    dishes nvarchar(50) not null,   -- 配料名稱
    )
create unique index same on MenuPlus(dishes)  -- 建立唯一索引 確保其欄位( B[品項名稱] )值之唯一性

-- 菜單品項關聯 (A 料理對應到 B 類型)
create table MenuChoose(
    DisherID int foreign key references Menu(DisherID) on delete cascade not null,       -- 什麼樣的料理
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade　null -- 會有甚麼樣的類型選擇
    )

  
-- 座位
create table seat(
    TableID int primary key  not null,  -- 桌號(ID)
    seat int not null,   -- 位子數量
    )

-- 訂單紀錄
create table OrderMeterial(
    OrderNum varchar primary key  not null, --訂單編號
    OrderTime datetime not null, -- 點餐時間
    PayTime datetime null,       -- 結帳時間
    TableID int foreign key references seat(TableID) not null -- 參考桌號
    )
    

-- 訂單明細
create table OrderRecord(
    OrderID int primary key identity not null,  -- 訂單ID
    OrderNum varchar references OrderMeterial(OrderNum)not null,    --訂單編號 (參考訂單紀錄)
    DisherID int foreign key references Menu(DisherID) not null,    -- 參考料理 ID
    Quantity int not null,        -- 數量
    TableID int foreign key references Seat(TableID) not null -- 參考桌號
    )


    




