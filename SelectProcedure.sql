create or alter procedure SelectDishType
as
begin
	SET NOCOUNT ON
	select DishType from MenuType 
	ORDER BY TypeID;
	SET NOCOUNT OFF
end
go

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

create or alter procedure SelectSideDish   
as
begin
	SET NOCOUNT ON	
	select dishes
	from MenuPlus p join MenuItems i on p.MenuItemsID = i.MenuItemsID
	where i.items = '�D��'
	SET NOCOUNT OFF
end
go

create or alter procedure InsertOrderMeterial
@OrderTime datetime,
@TableID int
as
begin
	SET NOCOUNT ON	
	insert into OrderMeterial(OrderTime, TableID)
	values(@OrderTime, @TableID)
	SET NOCOUNT OFF
end
go

create or alter procedure SelectOrderNum
as
begin
	SET NOCOUNT ON
	select max(OrderNum)  
	from OrderMeterial 
	where PayTime is null
	SET NOCOUNT OFF
end
go

create or alter procedure InsertOrderRecord
@OrderNum int,
@DisherID int,
@quantity int,
@TableID int
as
begin	
	insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- �s�W "�q��s��", "���s��", "�ƶq", "�ู"
	values(@OrderNum, @DisherID, @Quantity, @TableID)                    --�n�s�W���q��s��, �n�s�W���~��, �s�W�ƶq, �s�W�ƶq
end;
go

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
    update [dbo].[menu]               -- �N menu ���� 
    set dishes = @NewDisherName,      -- ���W�٧�s���s�����W��
        price = @NewPrice             -- ������s���s������                   
    where dishes = @OirginalName	  -- ���@�D�檺
end;


/*create or alter procedure SelectMenuPlus
as
begin
	SET NOCOUNT ON
	select *,
		   i.items,
		   p.dishes
	from MenuPlus p join MenuItems i on p.MenuItemsID = i.MenuItemsID
					join MenuChoose c on p.MenuItemsID = c.MenuItemsID	
	SET NOCOUNT OFF
end
go*/



