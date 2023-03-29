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

--���
create table menu(
    DisherID int primary key identity not null, -- �Ʋz ID
    dishes nvarchar(50) not null,     -- �Ʋz�W��
    HowMuch int not null,   -- �`���B
    )
create unique index same on menu(dishes)  -- �إ߰ߤ@���� �T�O�����( �Ʋz�W�� )�Ȥ��ߤ@��

-- �~������ 
create table MenuItems(
    MenuItemsID int primary key not null,   -- �~����ID
    items nvarchar(50) null              ,  -- �~���W��
    )

create unique index same on MenuItems(items)  -- �إ߰ߤ@���� �T�O�����( B[�~���W��] )�Ȥ��ߤ@��

-- �~���ݩ�(�t��)
create table MenuPlus(
    SideDishID int primary key identity not null,  -- �t�� ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade not null, -- ������ƻ��������Ʋz
    dishes nvarchar(50) not null,   -- �t�ƦW��
    )
create unique index same on MenuPlus(dishes)  -- �إ߰ߤ@���� �T�O�����( B[�~���W��] )�Ȥ��ߤ@��

-- ���~�����p (A �Ʋz������ B ����)
create table MenuChoose(
    DisherID int foreign key references Menu(DisherID) on delete cascade not null,       -- ����˪��Ʋz
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade�@null -- �|���ƻ�˪��������
    )

  
-- �y��
create table seat(
    TableID int primary key  not null,  -- �ู(ID)
    seat int not null,   -- ��l�ƶq
    )

-- �q�����
create table OrderMeterial(
    OrderNum varchar primary key  not null, --�q��s��
    OrderTime datetime not null, -- �I�\�ɶ�
    PayTime datetime null,       -- ���b�ɶ�
    TableID int foreign key references seat(TableID) not null -- �ѦҮู
    )
    

-- �q�����
create table OrderRecord(
    OrderID int primary key identity not null,  -- �q��ID
    OrderNum varchar references OrderMeterial(OrderNum)not null,    --�q��s�� (�Ѧҭq�����)
    DisherID int foreign key references Menu(DisherID) not null,    -- �ѦҮƲz ID
    Quantity int not null,        -- �ƶq
    TableID int foreign key references Seat(TableID) not null -- �ѦҮู
    )


    




