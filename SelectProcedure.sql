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
	where DishType = '�ѭ�'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectHotpot
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '��N'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectRice
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '����'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectSoup
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '���~'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectOthers
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '��L'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectSidedishes
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '�p��'
	SET NOCOUNT OFF
end
go

create or alter procedure SelectOthers
as
begin
	SET NOCOUNT ON
	select dishes from dbo.menu
	where DishType = '��L'
	SET NOCOUNT OFF
end
go
