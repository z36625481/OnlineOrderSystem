-- create database Onlineordersys
-- drop database Onlineordersys
use Onlineordersys


-- delete from menu
/*
select * from menu
go
select * from MenuItems
go
select * from Menuplus
go
select * from MenuChoose
go
select * from seat
go
select * from OrderMeterial
go
select * from OrderRecord
*/

--���
create table menu(
    DisherID int primary key identity not null, -- �Ʋz ID
    dishes nvarchar(50) unique not null,     -- �Ʋz�W��
    price int not null,   -- ���B
	DishType nvarchar(50) -- ����
    )
--create unique index same on menu(dishes)  -- �إ߰ߤ@���� �T�O�����( �Ʋz�W�� )�Ȥ��ߤ@��
--alter table menu ADD DishType nvarchar(50)
-- �~������ 
create table MenuItems(
    MenuItemsID int primary key not null,   -- �~����ID
    items nvarchar(50) unique null              ,  -- �~���W��
    )

--create unique index same on MenuItems(items)  -- �إ߰ߤ@���� �T�O�����( B[�~���W��] )�Ȥ��ߤ@��

-- �~���ݩ�(�t��)
create table MenuPlus(
    SideDishID int primary key identity not null,  -- �t�� ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade not null, -- ������ƻ��������Ʋz
    dishes nvarchar(50) unique not null,   -- �t�ƦW��
    )
--create unique index same on MenuPlus(dishes)  -- �إ߰ߤ@���� �T�O�����( B[�~���W��] )�Ȥ��ߤ@��

-- ���~�����p (A �Ʋz������ B ����)
create table MenuChoose(
    DisherID int foreign key references menu(DisherID) on delete cascade not null,       -- ����˪��Ʋz
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade�@null -- �|���ƻ�˪��������
    )

  
-- �y��
create table seat(
    TableID int primary key  not null,  -- �ู(ID)
    seat int not null,   -- ��l�ƶq
    )

-- �q�����
create table OrderMeterial(
    OrderNum int primary key identity not null, --�q��s��
    OrderTime datetime not null, -- �I�\�ɶ�
    PayTime datetime null,       -- ���b�ɶ�
    TableID int foreign key references seat(TableID) not null -- �ѦҮู
    )
    

-- �q�����
create table OrderRecord(
    OrderID int primary key identity not null,  -- �q��ID
    OrderNum int references OrderMeterial(OrderNum)not null,    --�q��s�� (�Ѧҭq�����)
    DisherID int foreign key references menu(DisherID) not null,    -- �ѦҮƲz ID
    Quantity int not null,        -- �ƶq
    TableID int foreign key references seat(TableID) not null -- �ѦҮู
    )


    




