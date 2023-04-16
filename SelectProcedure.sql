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
	select  SideDishID, 
			dishes
	from MenuPlus p join MenuItems i on p.MenuItemsID = i.MenuItemsID
	where i.items = '主食'
	SET NOCOUNT OFF
end
go

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

create or alter procedure InsertOrderRecord
@OrderNum int,
@DisherID int,
@quantity int,
@TableID int
as
begin
	SET NOCOUNT ON
	insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- 新增 "訂單編號", "菜單編號", "數量", "桌號"
	values(@OrderNum, @DisherID, @Quantity, @TableID)                    --要新增的訂單編號, 要新增的品項, 新增數量, 新增數量
	SET NOCOUNT OFF
end;
go

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

create or alter procedure SelectMenuPlus
as
begin
	SET NOCOUNT ON
	select items from MenuItems	
	SET NOCOUNT OFF
end
go

create or alter procedure UpdateMenu
@OirginalName  nvarchar(50),	  -- 舊的餐點名稱	
@NewDisherName nvarchar(50),      -- 新的餐點名稱
@NewPrice int					  -- 新的餐點價格
as
begin
	SET NOCOUNT ON
    update [dbo].[menu]               -- 將 menu 中的 
    set dishes = @NewDisherName,      -- 菜單名稱更新為新的菜單名稱
        price = @NewPrice             -- 價錢更新為新的價錢                   
    where dishes = @OirginalName	  -- 哪一道菜的
	SET NOCOUNT OFF
end;
go

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

create or alter proc calRevenue
@year int,
@month int = 0,
@day int = 0
as
begin
	if @month = 0 and @day = 0
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

-- execute calRevenue 2022, 6, 20

create or alter proc calRevenueDetail
@type nvarchar(50),
@year int,
@month int = 0,
@day int = 0
as
begin
	if @month = 0 and @day = 0
		select  b.dishes,
				sum(b.price * a.Quantity) total
		from(
			select l.PayTime PayTime,
				o.Quantity Quantity,
				o.DisherID DisherID
			from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
			where DATEPART(year, l.PayTime) = @year
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

-- execute calRevenueDetail '飯食', 2022, 6 

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







