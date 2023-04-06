create or alter procedure SelectDishType
as
begin
	SET NOCOUNT ON
	select DishType from dbo.menu 
	where DisherID in (select min(DisherID) from dbo.menu group by DishType)
	SET NOCOUNT OFF
end
go

create or alter procedure SelectNoodles
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '麵食'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectHotpot
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '鍋燒'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectRice
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '飯食'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectSoup
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '湯品'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectOthers
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '其他'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectSidedishes
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '小菜'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectOthers
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '其他'
	SET NOCOUNT OFF
end
go
