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
	from OrderMeterial join
	(
		select  OrderRecord.OrderNum,
				sum(menu.price * OrderRecord.Quantity) as Total 
		from OrderMeterial 
			join OrderRecord on OrderMeterial.OrderNum = OrderRecord.OrderNum 
			join menu on OrderRecord.DisherID = menu.DisherID	 
		where (OrderMeterial.PayTime is null)
		group by OrderRecord.OrderNum
	) p 
	on OrderMeterial.OrderNum = p.OrderNum
	where PayTime is null
	SET NOCOUNT OFF
end
go
