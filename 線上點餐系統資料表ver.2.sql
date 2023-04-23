/* 
1.���إ߸�Ʈw
	create database Onlineordersys
2.�N��Ʈw�v�����浹 pyuser (�ݥ��Х�pyuser�o�ӨϥΪ�)
	USE master
	GO
	ALTER AUTHORIZATION ON DATABASE::Onlineordersys TO pyuser
3.�إ߸�ƪ�
*/
use Onlineordersys

-- �\�I����
create table MenuType(
    TypeID int primary key identity not null , -- �\�I����ID
    DishType nvarchar(50) unique not null	   -- �\�I�����W�١A���i����
    )

-- ���
create table menu(
    DisherID int primary key identity not null, -- �\�IID
    dishes nvarchar(50) unique not null,        -- �\�I�W�١A���i����
    price int not null,						    -- ��~����
	TypeID int foreign key references MenuType(TypeID) on delete cascade not null -- �\�I������
    )

-- �i���ݩʺ���
-- �����B�j�p�B�D������
create table MenuItems(
    MenuItemsID int primary key not null,   -- �i���ݩʺ���ID
    items nvarchar(50) unique null          -- �i���ݩʺ����W��
    )
	
-- �U���������ԲӦW��
-- �Ҧp�G���q �� �j�B�p�F���� �� ���B��
create table MenuPlus(
    SideDishID int primary key identity  not null,  -- �����Բ�ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade not null, -- �i���ݩʺ���ID
    dishes nvarchar(50) unique not null,   -- �����ԲӦW��
    )

-- �����i��������p
-- �Ҧp�G�ѭ��i�H�u�[�j�v�B�u�����v�F��N�i�H�u�D���v
create table MenuChoose(
    TypeID int foreign key references MenuType(TypeID) on delete cascade not null,        -- ����ID
    MenuItemsID int foreign key references MenuItems(MenuItemsID) on delete cascade�@null -- �i�H�����������
    )
  
-- �y��
create table seat(
    TableID int primary key  not null,  -- �ู(ID)
    seat int not null,					-- �i�e�ǤH��
    )

-- ���u
create table staff(
    UserID int identity not null,             -- �H���s��
	Email nvarchar(50) primary key not null,  -- �b��(E-mail)
	PW nvarchar(50) not null,                 -- �K�X                     
    personnel nvarchar(50)  not null          -- ����
    )

-- �q�����
create table OrderMeterial(
    OrderNum int primary key identity not null, -- �q��s��
    OrderTime datetime not null,				-- �q�沣�ͮɶ�
    PayTime datetime null,						-- ���b�ɶ�
    TableID int foreign key references seat(TableID) not null, -- �ู
	token nvarchar(50) unique not null			-- �ѧO�X 
    )

-- �q���������
create table OrderRecord(
    OrderID int primary key identity not null,									-- �q������Բ�ID
    OrderNum int references OrderMeterial(OrderNum) on delete cascade not null, -- �q��s�� (�Ѧҭq�����)
    DisherID int foreign key references menu(DisherID) not null,				-- �\�IID
    Quantity int not null,														-- �ƶq
    TableID int foreign key references seat(TableID) not null					-- �ู
    )





