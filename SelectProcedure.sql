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
	from MenuPlus where MenuItemsID = 3
	SET NOCOUNT OFF
end