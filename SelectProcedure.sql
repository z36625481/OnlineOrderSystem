use Onlineordersys
go

-- ���\�I�����W�١A�åH�\�I����ID�Ѥp�ܤj�Ƨ�
create or alter procedure SelectDishType
as
begin
	SET NOCOUNT ON
	select DishType from MenuType 
	ORDER BY TypeID;
	SET NOCOUNT OFF
end
go

-- ���\�I�W�١B����B�\�I�����W��
create or alter procedure SelectMenu
as
begin
	SET NOCOUNT ON
	select dishes,
		   price,
		   t.DishType
	from dbo.menu m join dbo.MenuType t on m.TypeID	= t.TypeID
	SET NOCOUNT OFF
end
go

-- ��|���I�O���q��s���B�q�沣�ͮɶ��B�ู�B�`���B
create or alter procedure SelectOrder
as
begin
	SET NOCOUNT ON
	select p.OrderNum,
		   OrderTime,
		   TableID,
		   Total
	from OrderMeterial o join
	(
		select  OrderRecord.OrderNum,
				sum(menu.price * OrderRecord.Quantity) as Total 
		from OrderMeterial 
			join OrderRecord on OrderMeterial.OrderNum = OrderRecord.OrderNum 
			join menu on OrderRecord.DisherID = menu.DisherID	 
		where (OrderMeterial.PayTime is null)
		group by OrderRecord.OrderNum
	) p 
	on o.OrderNum = p.OrderNum	
	SET NOCOUNT OFF
end
go

-- ��s�I�O�ɶ�
create or alter procedure UpdatePayTime
@OrderNum int,
@PayTime datetime     
as
begin
	SET NOCOUNT ON
	update OrderMeterial         
	set PayTime = @PayTime
	where OrderNum = @OrderNum 
	SET NOCOUNT OFF
end
go

-- ��D���������ǿ��
create or alter procedure SelectSideDish   
as
begin
	SET NOCOUNT ON	
	select  SideDishID, 
			dishes
	from MenuPlus p join MenuItems i on p.MenuItemsID = i.MenuItemsID
	where i.items = '�D��'
	SET NOCOUNT OFF
end
go

-- �s�W�q��Ainsert���ͮɶ��B�ู�B�ѧO�X
create or alter procedure InsertOrderMeterial
@OrderTime datetime,
@TableID int,
@token nvarchar(50)
as
begin
	SET NOCOUNT ON	
	insert into OrderMeterial(OrderTime, TableID, token)
	values(@OrderTime, @TableID, @token)
	SET NOCOUNT OFF
end
go

-- ��q��s���H�ι������ѧO�X
create or alter procedure SelectOrderInfo
as
begin
	SET NOCOUNT ON
	select o.OrderNum,
		   o.token
	from OrderMeterial o join (
	select max(OrderNum) orderNum
	from OrderMeterial 
	where PayTime is null) m on o.OrderNum = m.orderNum	
	SET NOCOUNT OFF
end
go

-- �s�W�q����ӡAinsert�q��s���B�\�I�s���B�ƶq�B�ู
create or alter procedure InsertOrderRecord
@OrderNum int,
@DisherID int,
@quantity int,
@TableID int
as
begin
	SET NOCOUNT ON
	insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) 
	values(@OrderNum, @DisherID, @Quantity, @TableID)                    
	SET NOCOUNT OFF
end;
go

-- ��S�w�q��s�����ʪ����M��G�\�I�W�١B����B���q��b�P�\�I���`�ƶq
create or alter procedure SelectCartList
@orderNum int
as
begin
	SET NOCOUNT ON
	select m.dishes,
		   m.price,
		   r.quantity
	from menu m join
	(
	select m.DisherID,		   
		   sum(o.Quantity) quantity
	from menu m join OrderRecord o on m.DisherID = o.DisherID
	where o.OrderNum = @orderNum
	group by m.DisherID
	) r on m.DisherID = r.DisherID
	SET NOCOUNT OFF
end;
go

-- �p��S�w�q�檺�`���B
create or alter procedure calTotal
@orderNum int
as
begin
	SET NOCOUNT ON
	select sum(o.Quantity * m.price)
	from OrderRecord o join menu m on o.DisherID = m.DisherID
	where o.OrderNum = @orderNum
end;
go

-- ��i�ΰt��W��
create or alter procedure SelectMenuPlus
as
begin
	SET NOCOUNT ON
	select items from MenuItems	
	SET NOCOUNT OFF
end
go

create or alter procedure UpdateMenu
@OirginalName  nvarchar(50),	  -- �ª��\�I�W��	
@NewDisherName nvarchar(50),      -- �s���\�I�W��
@NewPrice int					  -- �s���\�I����
as
begin
	SET NOCOUNT ON
    update [dbo].[menu]               -- �N menu ���� 
    set dishes = @NewDisherName,      -- ���W�٧�s���s�����W��
        price = @NewPrice             -- ������s���s������                   
    where dishes = @OirginalName	  -- ���@�D�檺
	SET NOCOUNT OFF
end;
go

-- ����u���b���B�K�X
create or alter procedure SelectStaff
as
begin
	SET NOCOUNT ON
	select Email, 
		   PW		
	from Staff	
	SET NOCOUNT OFF
end
go

-- �d���禬�G������J�~���A����J��h�h���A����J��h�h���
-- �������W�١B���������b�d�߮ɬq���`���B
create or alter proc calRevenue
@year int,
@month int = 0,
@day int = 0
as
begin
	-- �u��Y�~
	if @month = 0 and @day = 0
		select DishType,
			   total
		from MenuType join
			(
			 select  b.TypeID,				 -- result�G������ID�B�`���B
					 sum(b.price * a.Quantity) total
			 from(
				 select l.PayTime PayTime,	 -- a�G��I�O�ɶ��B�ƶq�B�\�IID
						o.Quantity Quantity,
						o.DisherID DisherID
				 from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
				 where DATEPART(year, l.PayTime) = @year
			) a	join
			(
			 select price,
					m.DisherID DisherID,	-- b�G�����B�\�IID�B����ID
					t.TypeID TypeID
			 from MenuType t join menu m on t.TypeID = m.TypeID 
			) b on a.DisherID = b.DisherID	
			group by b.TypeID
		) result on MenuType.TypeID = result.TypeID
		order by MenuType.TypeID -- ������ID�i��p�ܤj�ƧǡA�H�e�{�Q�n�����G
	-- ��Y�~�Y��
	else if @day = 0
		select DishType,
			   total
		from MenuType join
			(
			 select  b.TypeID,
					 sum(b.price * a.Quantity) total
			 from(
				 select l.PayTime PayTime,
						o.Quantity Quantity,
						o.DisherID DisherID
				 from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
				 where DATEPART(year, l.PayTime) = @year
				   and DATEPART(month, l.PayTime) = @month
			) a	join
			(
			 select price,
					m.DisherID DisherID,
					t.TypeID TypeID
			 from MenuType t join menu m on t.TypeID = m.TypeID
			) b on a.DisherID = b.DisherID	
			group by b.TypeID
		) result on MenuType.TypeID = result.TypeID
		order by MenuType.TypeID
	-- ��Y�~�Y��Y��
	else
		select DishType,
			   total
		from MenuType join
			(
			 select  b.TypeID,
					 sum(b.price * a.Quantity) total
			 from(
				 select l.PayTime PayTime,
						o.Quantity Quantity,
						o.DisherID DisherID
				 from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
				 where DATEPART(year, l.PayTime) = @year
				   and DATEPART(month, l.PayTime) = @month
				   and DATEPART(day, l.PayTime) = @day
			) a	join
			(
			 select price,
					m.DisherID DisherID,
					t.TypeID TypeID
			 from MenuType t join menu m on t.TypeID = m.TypeID
			) b on a.DisherID = b.DisherID	
			group by b.TypeID
		) result on MenuType.TypeID = result.TypeID
		order by MenuType.TypeID
end
go

-- �d�߬Y�S�w�������\�I�禬�G������J�����B�~���A����J��h�h���A����J��h�h���
-- ���\�I�W�١B�����\�I�b�d�߮ɬq���`���B
create or alter proc calRevenueDetail
@type nvarchar(50),
@year int,
@month int = 0,
@day int = 0
as
begin
	-- ��Y�~
	if @month = 0 and @day = 0
		select  b.dishes,
				sum(b.price * a.Quantity) total
		from(
			select l.PayTime PayTime,	-- a�G��I�O�ɶ��B�ƶq�B�\�IID
				o.Quantity Quantity,
				o.DisherID DisherID
			from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
			where DATEPART(year, l.PayTime) = @year
		) a	join
		(
			select price,				-- b�G�����B�\�IID�B�\�I�W��
				m.DisherID DisherID,
				m.dishes dishes
			from MenuType t join menu m on t.TypeID = m.TypeID
			where t.DishType = @type
		) b on a.DisherID = b.DisherID	
		group by b.dishes
		order BY total DESC				-- �N�`���B�Ѥj�ܤp�ƦC�A�H�e�{�Q�n���ĪG
	-- ��Y�~�Y��
	else if @day = 0
		select  b.dishes,
				sum(b.price * a.Quantity) total
		from(
			select l.PayTime PayTime,	
				o.Quantity Quantity,
				o.DisherID DisherID
			from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
			where DATEPART(year, l.PayTime) = @year
				and DATEPART(month, l.PayTime) = @month
		) a	join
		(
			select price,				
				m.DisherID DisherID,
				m.dishes dishes
			from MenuType t join menu m on t.TypeID = m.TypeID
			where t.DishType = @type
		) b on a.DisherID = b.DisherID	
		group by b.dishes
		order BY total DESC 
	-- ��Y�~�Y��Y��
	else
		select  b.dishes,
				sum(b.price * a.Quantity) total
		from(
			select l.PayTime PayTime,
				o.Quantity Quantity,
				o.DisherID DisherID
			from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
			where DATEPART(year, l.PayTime) = @year
			  and DATEPART(month, l.PayTime) = @month
			  and DATEPART(day, l.PayTime) = @day
		) a	join
		(
			select price,
				m.DisherID DisherID,
				m.dishes dishes
			from MenuType t join menu m on t.TypeID = m.TypeID
			where t.DishType = @type
		) b on a.DisherID = b.DisherID	
		group by b.dishes
		order BY total DESC
end
go

-- �s�W�\�I�Ainsert�\�I�W�١B����B�\�I����ID
create or alter proc InsertMenu
@dishes nvarchar(50),
@price int,
@typeID int
as
begin
	insert menu(dishes, price, TypeID)
	values(@dishes, @price, @typeID)
end
go

-- ��|���I�O���q����ӡA�q��s���B�\�I�W�١B�ƶq
create or alter procedure SelectOrderDetail
as
begin
	SET NOCOUNT ON
	select o.OrderNum,
		   m.dishes,
		   o.Quantity
	from OrderRecord o join OrderMeterial l on o.OrderNum = l.orderNum
					   join menu m on o.DisherID = m.DisherID
	where l.PayTime is null
	SET NOCOUNT OFF
end
go







