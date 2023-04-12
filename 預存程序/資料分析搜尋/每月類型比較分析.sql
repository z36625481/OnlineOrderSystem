create or alter proc SelectMonth
@year nvarchar(50),
@month nvarchar(50)
as
begin
select menu.dishtype, sum(menu.price * OrderRecord.Quantity) as Total 
    from OrderMeterial 
    join OrderRecord on OrderMeterial.OrderNum = OrderRecord.OrderNum 
    join menu on OrderRecord.DisherID = menu.DisherID 
    where DATEPART(year, OrderMeterial.PayTime) = @year and DATEPART(month, OrderMeterial.PayTime) = @month
    group by menu.DishType
end;

go

--Execute SelectDate 2022, 5