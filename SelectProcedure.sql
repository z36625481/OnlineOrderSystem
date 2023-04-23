use Onlineordersys
go

-- 找餐點類型名稱，並以餐點類型ID由小至大排序
create or alter procedure SelectDishType
as
begin
	SET NOCOUNT ON
	select DishType from MenuType 
	ORDER BY TypeID;
	SET NOCOUNT OFF
end
go

-- 找餐點名稱、價格、餐點類型名稱
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

-- 找尚未付費的訂單編號、訂單產生時間、桌號、總金額
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

-- 更新付費時間
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

-- 找主食內有哪些選擇
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

-- 新增訂單，insert產生時間、桌號、識別碼
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

-- 找訂單編號以及對應的識別碼
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

-- 新增訂單明細，insert訂單編號、餐點編號、數量、桌號
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

-- 找特定訂單編號的購物車清單：餐點名稱、價格、此訂單在同餐點的總數量
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

-- 計算特定訂單的總金額
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

-- 找可用配對名稱
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

-- 找員工的帳號、密碼
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

-- 查詢營收：必須輸入年份，有輸入月則多找月，有輸入日則多找日
-- 找類型名稱、那個類型在查詢時段的總金額
create or alter proc calRevenue
@year int,
@month int = 0,
@day int = 0
as
begin
	-- 只找某年
	if @month = 0 and @day = 0
		select DishType,
			   total
		from MenuType join
			(
			 select  b.TypeID,				 -- result：找類型ID、總金額
					 sum(b.price * a.Quantity) total
			 from(
				 select l.PayTime PayTime,	 -- a：找付費時間、數量、餐點ID
						o.Quantity Quantity,
						o.DisherID DisherID
				 from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
				 where DATEPART(year, l.PayTime) = @year
			) a	join
			(
			 select price,
					m.DisherID DisherID,	-- b：找價格、餐點ID、類型ID
					t.TypeID TypeID
			 from MenuType t join menu m on t.TypeID = m.TypeID 
			) b on a.DisherID = b.DisherID	
			group by b.TypeID
		) result on MenuType.TypeID = result.TypeID
		order by MenuType.TypeID -- 依類型ID進行小至大排序，以呈現想要的結果
	-- 找某年某月
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
	-- 找某年某月某日
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

-- 查詢某特定類型的餐點營收：必須輸入類型、年份，有輸入月則多找月，有輸入日則多找日
-- 找餐點名稱、那個餐點在查詢時段的總金額
create or alter proc calRevenueDetail
@type nvarchar(50),
@year int,
@month int = 0,
@day int = 0
as
begin
	-- 找某年
	if @month = 0 and @day = 0
		select  b.dishes,
				sum(b.price * a.Quantity) total
		from(
			select l.PayTime PayTime,	-- a：找付費時間、數量、餐點ID
				o.Quantity Quantity,
				o.DisherID DisherID
			from OrderRecord o join OrderMeterial l on o.OrderNum = l.OrderNum
			where DATEPART(year, l.PayTime) = @year
		) a	join
		(
			select price,				-- b：找價格、餐點ID、餐點名稱
				m.DisherID DisherID,
				m.dishes dishes
			from MenuType t join menu m on t.TypeID = m.TypeID
			where t.DishType = @type
		) b on a.DisherID = b.DisherID	
		group by b.dishes
		order BY total DESC				-- 將總金額由大至小排列，以呈現想要的效果
	-- 找某年某月
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
	-- 找某年某月某日
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

-- 新增餐點，insert餐點名稱、價格、餐點類型ID
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

-- 找尚未付費的訂單明細，訂單編號、餐點名稱、數量
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







