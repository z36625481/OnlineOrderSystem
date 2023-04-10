create or alter proc SelectMonthDetail
@year nvarchar(50),
@month nvarchar(50),
@type nvarchar(50)

as
begin
select menu.dishes, sum(menu.price * OrderRecord.Quantity) as Total 
    from OrderMeterial 
    join OrderRecord on OrderMeterial.OrderNum = OrderRecord.OrderNum 
    join menu on OrderRecord.DisherID = menu.DisherID 
    where DATEPART(year, OrderMeterial.PayTime) = @year and DATEPART(month, OrderMeterial.PayTime) = @month and DishType = @type
    group by menu.DishType, menu.dishes
end;

go

--Execute SelectDateDetail 2022, 5, 'Áç¿N'