
-- �w�s�{���`��



-- insert���
create or alter procedure InsertMenu
@DisherName nvarchar(50), -- �s�����W��
@price int,             -- �s��������
@DishType nvarchar(50),   -- �������
@chooce1 int = null,      -- ���|�����ﶵID-1(�w�]��null)
@chooce2 int = null,      -- ���|�����ﶵID-2(�w�]��null)
@chooce3 int = null       -- ���|�����ﶵID-3(�w�]��null)
as
begin
    insert into menu(dishes, price , DishType)   -- �bmenu���s�W���(���W��, ������)
    values(@DisherName,@price, @DishType)         -- ��Ƥ��e(�s�����W��, �s��������)

    declare @NewDisherID int =(
        select disherID                  -- �b menu ����� 
        from [dbo].[menu]                -- �s�����W��
        where dishes=@DisherName         -- ���s�����W�٪� ID =
        )                     

    -- 1            -- �Ĥ@�ص��ﶵ�i��           
    if @chooce1 is not null    
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- �s�W�s��檺�~�����(��檺ID, ���ﶵ��ID)
        values(@NewDisherID, @chooce1)                  -- ��Ƥ��e(�s�����W�٪� ID, �����ǵ��ﶵID)
    end

    -- 2            -- �ĤG�ص��ﶵ�i��    
    if @chooce1 is not null
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- �s�W�s��檺�~�����(��檺ID, ���ﶵ��ID)
        values(@NewDisherID, @chooce2)              -- ��Ƥ��e(�s�����W�٪� ID, �����ǵ��ﶵID)
    end
    -- 3            -- �ĤT�ص��ﶵ�i��   
    if @chooce1 is not null
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- �s�W�s��檺�~�����(��檺ID, ���ﶵ��ID)
        values(@NewDisherID, @chooce3)              -- ��Ƥ��e(�s�����W�٪� ID, �����ǵ��ﶵID)
    end
end;


-- execute InsertMenu '�����P��', 9999, penguin, 1, 2, 3

go

-- update ���
create or alter procedure UpdateMenu
@DisherName nvarchar(50),      -- �ª����W��
@NewDisherName nvarchar(50),   -- �s�����W��
@NewMach int,                  -- �s��������
@NewType nvarchar(50)          -- �s���������

as
begin
    declare @UpdateDisherID int =(
        select disherID                  -- ���ª����W��
        from [dbo].[menu]                -- �q menu ��
        where dishes=@DisherName         -- ���ª����W��ID
        )

    update [dbo].[menu]               -- �N menu ���� 
    set dishes = @NewDisherName,      -- ���W�٧�s���s�����W��
        price = @NewMach,             -- ������s���s������
        DishType = @NewType           -- ������s���s�������
    where disherID = @UpdateDisherID  -- ���@�D�檺

        
end;



go

-- delete���
create or alter procedure DeleteMenu
@WantDropDisherID int     -- �n delete ����� ID
as
begin       
    delete from [dbo].[menu]            -- �R�� menu ��
    where disherID = @WantDropDisherID  -- �n delete ����檺ID �����
end;
-- execute DeleteMenu 53



go

-- insert�y��
create�@or alter procedure InsertSeat
@NewTableID int,  -- �s���y��(�ู)
@TotalSeat int    -- �y��ƶq
as
begin
insert into [dbo].[seat](TableID, Seat) --    �ู         �y��ƶq 
values(@NewTableID, @TotalSeat)         --  �s���ู       �y���`��
end;

-- execute Insertseat 7,4

go

-- update �y��
create or alter procedure UpdateSeat
@OldTableID int,     -- �n��s���ู
@NewTableID int,     -- �s���ู
@TotleSeata int      -- �y��ƶq
as
begin
update dbo.seat                -- ��s��m
set TableID = @NewTableID,     -- ��s�ู
	seat = @TotleSeata         -- �`�@���X�Ӧ�m
where TableID = @OldTableID    -- �M��n��s�������ู

end;



go

-- delete �y��
create or alter procedure DeleteSeat
@TableID int -- �n�R�����ู
as
begin
delete from seat          -- �R���y��
where TableID = @TableID  -- �۹������ู
end



go

-- insert�~���ݩ�(�t��)
create or alter procedure InsertMenuPlus

@dishes nvarchar(50),   -- �s���t�ƦW��
@MenuItemsID int        -- ������ƻ��������Ʋz
as
begin
    insert into MenuPlus(dishes, MenuItemsID)   -- �bmenu���s�W���(�~����ID, �~���W��)
    values(@dishes, @MenuitemsID)               -- ��Ƥ��e(�~��ID, �~���W��)  
end;



go

-- update �~���ݩ�(�t��)
create or alter procedure UpdateMenuPlus
@dishes nvarchar(50),      -- �ª��t�ƦW��
@NewDishes nvarchar(50)    -- �s���t�ƦW��
as
begin 
	declare @SideDishID int =(
		select SideDishID        -- ��t��ID 
		from [dbo].[MenuPlus]    -- �q�t�Ƹ�ƪ��M��
		where dishes = @dishes   -- ���O��s���°t�ƦW��
		)

    update [dbo].[MenuPlus]         -- ��s�t�Ƹ�ƪ�
    set dishes = @NewDishes         -- �]�w�s���t��W��
    where SideDishID = @SideDishID  -- ���O��s���°t�ƪ�ID
end;

-- execute UpdateMenuPlus '�����', '���l��'



go

-- delete �~���ݩ�(�t��)
create or alter procedure DeleteMenuPlus
@dishes nvarchar(50)      -- �n�R�������t�ƦW��
as
begin 
	delete from [dbo].[MenuPlus]
	where [dishes] = @dishes
end;

-- execute DeleteMenuPlus '���l��'



go

-- insert�~������
create or alter procedure InsertMenuItems

@MenuitemsID�@int,�@    -- �s�~����ID
@items�@nvarchar(50)    -- �s�~�����W��
as
begin
    insert into MenuItems(MenuitemsID, items)   -- �bmenu���s�W���(�~����ID, �~���W��)
    values(@MenuitemsID, @items)         -- ��Ƥ��e(�~��ID, �~���W��)           
end;



go

-- update�~������
create or alter procedure UpdateMenuItems
@items nvarchar(50),      -- �ª��~���W��
@NewItems nvarchar(50)   -- �s���~���W��
as
begin
    declare @UpdateItemsID int =(
        select MenuitemsID            -- ���ª��~���W��
        from [dbo].[MenuItems]     �@ -- �q menu ��
        where items�@=�@@items       -- ���ª��~���W��ID
        )

    update [dbo].[MenuItems]      �@   -- �N menu ���� 
    set items = @NewItems�@    �@�@�@�@  -- �~���W�٧�s���s���~���W��
    where MenuItemsID = @UpdateItemsID  -- ���@�ӫ~����

        
end;



go

-- delete�~������
create or alter procedure DeleteMenuItems
@WantDropItems nvarchar(50)     -- �n delete ���~�� 
as�@
begin       
    delete from [dbo].[MenuItems]       -- �R�� menu ��
    where items = @WantDropItems        -- �n delete ���~����ID �����
end;

-- execute DeleteMenuItems '���q'



go

-- insesrt �q�����
create or alter procedure InsertOrderRecord
@OrderNum int,       -- �n�s�W���q��s��
@DisherID int,       -- �n�s�W���~��
@Quantity int,       -- �s�W�ƶq
@TableID int         -- �s�W�ู
as
begin
insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- �s�W "�q��s��", "���s��", "�ƶq", "�ู"
values(@OrderNum, @DisherID, @Quantity, @TableID)                  --�n�s�W���q��s��, �n�s�W���~��, �s�W�ƶq, �s�W�ƶq
end;



go

-- update �q�����
create or alter procedure UpdateOrderRecord
@OrderNum int,       -- �n��s���q��s��
@dishid int,         -- �n��s���~��
@OrderID int,        -- �O��s���~��
@Quantity int        -- ��s�ƶq
as
begin
update OrderRecord         -- ��s�q�����
set DisherID = @dishid,    -- ��s�~��
    Quantity = @Quantity   -- ��s�ƶq
where OrderNum = @OrderNum -- ���i�q�檺
end



go

-- delete �q�����
create or alter procedure DeleteOrderRecord
@OrderNum int,       -- �n�R�����q��s��
@DisherID int        -- �n�R�����~��
as
begin
delete from OrderRecord        -- �R���q��
where OrderNum = @OrderNum and DisherID = @DisherID  
end;







