
-- 預存程序總覽



-- insert菜單
create or alter procedure InsertMenu
@DisherName nvarchar(50), -- 新的菜單名稱
@price int,             -- 新的菜單價錢
@DishType nvarchar(50),   -- 菜單類型
@chooce1 int = null,      -- 菜單會有的選項ID-1(預設為null)
@chooce2 int = null,      -- 菜單會有的選項ID-2(預設為null)
@chooce3 int = null       -- 菜單會有的選項ID-3(預設為null)
as
begin
    insert into menu(dishes, price , DishType)   -- 在menu中新增資料(菜單名稱, 菜單價錢)
    values(@DisherName,@price, @DishType)         -- 資料內容(新的菜單名稱, 新的菜單價錢)

    declare @NewDisherID int =(
        select disherID                  -- 在 menu 中找到 
        from [dbo].[menu]                -- 新的菜單名稱
        where dishes=@DisherName         -- 的新的菜單名稱的 ID =
        )                     

    -- 1            -- 第一種菜單選項可能           
    if @chooce1 is not null    
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- 新增新菜單的品項選擇(菜單的ID, 菜單選項的ID)
        values(@NewDisherID, @chooce1)                  -- 資料內容(新的菜單名稱的 ID, 有哪些菜單選項ID)
    end

    -- 2            -- 第二種菜單選項可能    
    if @chooce1 is not null
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- 新增新菜單的品項選擇(菜單的ID, 菜單選項的ID)
        values(@NewDisherID, @chooce2)              -- 資料內容(新的菜單名稱的 ID, 有哪些菜單選項ID)
    end
    -- 3            -- 第三種菜單選項可能   
    if @chooce1 is not null
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- 新增新菜單的品項選擇(菜單的ID, 菜單選項的ID)
        values(@NewDisherID, @chooce3)              -- 資料內容(新的菜單名稱的 ID, 有哪些菜單選項ID)
    end
end;


-- execute InsertMenu '阿普嚕派', 9999, penguin, 1, 2, 3

go

-- update 菜單
create or alter procedure UpdateMenu
@DisherName nvarchar(50),      -- 舊的菜單名稱
@NewDisherName nvarchar(50),   -- 新的菜單名稱
@NewMach int,                  -- 新的菜單價錢
@NewType nvarchar(50)          -- 新的菜單類型

as
begin
    declare @UpdateDisherID int =(
        select disherID                  -- 用舊的菜單名稱
        from [dbo].[menu]                -- 從 menu 中
        where dishes=@DisherName         -- 找舊的菜單名稱ID
        )

    update [dbo].[menu]               -- 將 menu 中的 
    set dishes = @NewDisherName,      -- 菜單名稱更新為新的菜單名稱
        price = @NewMach,             -- 價錢更新為新的價錢
        DishType = @NewType           -- 類型更新為新菜單類型
    where disherID = @UpdateDisherID  -- 哪一道菜的

        
end;



go

-- delete菜單
create or alter procedure DeleteMenu
@WantDropDisherID int     -- 要 delete 的菜單 ID
as
begin       
    delete from [dbo].[menu]            -- 刪除 menu 的
    where disherID = @WantDropDisherID  -- 要 delete 的菜單的ID 的資料
end;
-- execute DeleteMenu 53



go

-- insert座位
create　or alter procedure InsertSeat
@NewTableID int,  -- 新的座位(桌號)
@TotalSeat int    -- 座位數量
as
begin
insert into [dbo].[seat](TableID, Seat) --    桌號         座位數量 
values(@NewTableID, @TotalSeat)         --  新的桌號       座位總數
end;

-- execute Insertseat 7,4

go

-- update 座位
create or alter procedure UpdateSeat
@OldTableID int,     -- 要更新的桌號
@NewTableID int,     -- 新的桌號
@TotleSeata int      -- 座位數量
as
begin
update dbo.seat                -- 更新位置
set TableID = @NewTableID,     -- 更新桌號
	seat = @TotleSeata         -- 總共有幾個位置
where TableID = @OldTableID    -- 尋找要更新的對應桌號

end;



go

-- delete 座位
create or alter procedure DeleteSeat
@TableID int -- 要刪除的桌號
as
begin
delete from seat          -- 刪除座位
where TableID = @TableID  -- 相對應的桌號
end



go

-- insert品項屬性(配料)
create or alter procedure InsertMenuPlus

@dishes nvarchar(50),   -- 新的配料名稱
@MenuItemsID int        -- 對應到甚麼類型的料理
as
begin
    insert into MenuPlus(dishes, MenuItemsID)   -- 在menu中新增資料(品項的ID, 品項名稱)
    values(@dishes, @MenuitemsID)               -- 資料內容(品項ID, 品項名稱)  
end;



go

-- update 品項屬性(配料)
create or alter procedure UpdateMenuPlus
@dishes nvarchar(50),      -- 舊的配料名稱
@NewDishes nvarchar(50)    -- 新的配料名稱
as
begin 
	declare @SideDishID int =(
		select SideDishID        -- 找配料ID 
		from [dbo].[MenuPlus]    -- 從配料資料表中尋找
		where dishes = @dishes   -- 找到逾更新的舊配料名稱
		)

    update [dbo].[MenuPlus]         -- 更新配料資料表
    set dishes = @NewDishes         -- 設定新的配菜名稱
    where SideDishID = @SideDishID  -- 找到逾更新的舊配料的ID
end;

-- execute UpdateMenuPlus '科學麵', '王子麵'



go

-- delete 品項屬性(配料)
create or alter procedure DeleteMenuPlus
@dishes nvarchar(50)      -- 要刪除的的配料名稱
as
begin 
	delete from [dbo].[MenuPlus]
	where [dishes] = @dishes
end;

-- execute DeleteMenuPlus '王子麵'



go

-- insert品項類型
create or alter procedure InsertMenuItems

@MenuitemsID　int,　    -- 新品項的ID
@items　nvarchar(50)    -- 新品項的名稱
as
begin
    insert into MenuItems(MenuitemsID, items)   -- 在menu中新增資料(品項的ID, 品項名稱)
    values(@MenuitemsID, @items)         -- 資料內容(品項ID, 品項名稱)           
end;



go

-- update品項類型
create or alter procedure UpdateMenuItems
@items nvarchar(50),      -- 舊的品項名稱
@NewItems nvarchar(50)   -- 新的品項名稱
as
begin
    declare @UpdateItemsID int =(
        select MenuitemsID            -- 用舊的品項名稱
        from [dbo].[MenuItems]     　 -- 從 menu 中
        where items　=　@items       -- 找舊的品項名稱ID
        )

    update [dbo].[MenuItems]      　   -- 將 menu 中的 
    set items = @NewItems　    　　　　  -- 品項名稱更新為新的品項名稱
    where MenuItemsID = @UpdateItemsID  -- 哪一個品項的

        
end;



go

-- delete品項類型
create or alter procedure DeleteMenuItems
@WantDropItems nvarchar(50)     -- 要 delete 的品項 
as　
begin       
    delete from [dbo].[MenuItems]       -- 刪除 menu 的
    where items = @WantDropItems        -- 要 delete 的品項的ID 的資料
end;

-- execute DeleteMenuItems '份量'



go

-- insesrt 訂單明細
create or alter procedure InsertOrderRecord
@OrderNum int,       -- 要新增的訂單編號
@DisherID int,       -- 要新增的品項
@Quantity int,       -- 新增數量
@TableID int         -- 新增桌號
as
begin
insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- 新增 "訂單編號", "菜單編號", "數量", "桌號"
values(@OrderNum, @DisherID, @Quantity, @TableID)                  --要新增的訂單編號, 要新增的品項, 新增數量, 新增數量
end;



go

-- update 訂單明細
create or alter procedure UpdateOrderRecord
@OrderNum int,       -- 要更新的訂單編號
@dishid int,         -- 要更新的品項
@OrderID int,        -- 逾更新的品項
@Quantity int        -- 更新數量
as
begin
update OrderRecord         -- 更新訂單明細
set DisherID = @dishid,    -- 更新品項
    Quantity = @Quantity   -- 更新數量
where OrderNum = @OrderNum -- 哪張訂單的
end



go

-- delete 訂單明細
create or alter procedure DeleteOrderRecord
@OrderNum int,       -- 要刪除的訂單編號
@DisherID int        -- 要刪除的品項
as
begin
delete from OrderRecord        -- 刪除訂單
where OrderNum = @OrderNum and DisherID = @DisherID  
end;







