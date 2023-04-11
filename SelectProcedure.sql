create or alter procedure SelectDishType
as
begin
	SET NOCOUNT ON
	select DishType from dbo.menu 
	where DisherID in (select min(DisherID) from dbo.menu group by DishType)
	SET NOCOUNT OFF
end
go

create or alter procedure SelectMenu
as
begin
	SET NOCOUNT ON
	select dishes,
		   price,
		   DishType
	from dbo.menu	
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
	select  SideDishID, 
			dishes
	from MenuPlus p join MenuItems i on p.MenuItemsID = i.MenuItemsID
	where i.items = '主食'
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
	insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- 新增 "訂單編號", "菜單編號", "數量", "桌號"
	values(@OrderNum, @DisherID, @Quantity, @TableID)                    --要新增的訂單編號, 要新增的品項, 新增數量, 新增數量
end;


