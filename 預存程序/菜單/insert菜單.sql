-- insert菜單
create or alter procedure InsertMenu
@DisherName nvarchar(50), -- 新的菜單名稱
@HowMuch int,             -- 新的菜單價錢
-- @MenuitemsID int,         -- 菜單選項ID    (((廢棄)))
@chooce1 int = null,      -- 菜單會有的選項ID-1(預設為null)
@chooce2 int = null,      -- 菜單會有的選項ID-2(預設為null)
@chooce3 int = null       -- 菜單會有的選項ID-3(預設為null)
as
begin
    insert into menu(dishes, HowMuch )   -- 在menu中新增資料(菜單名稱, 菜單價錢)
    values(@DisherName,@HowMuch)         -- 資料內容(新的菜單名稱, 新的菜單價錢)

    declare @NewDisherID int =(
        select disherID                  -- 在 menu 中找到 
        from [dbo].[menu]                -- 新的菜單名稱
        where dishes=@DisherName         -- 的新的菜單名稱的 ID =
        )                     

    -- 1            -- 第一種菜單選項可能           
    if @chooce1 is not null    
    begin
        insert into MenuChoose(disherID, MenuitemsID)   -- 新增新菜單的品項選擇(菜單的ID, 菜單選項的ID)
        values(@NewDisherID, @chooce1)              -- 資料內容(新的菜單名稱的 ID, 有哪些菜單選項ID)
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


-- execute InsertMenu '阿普嚕派', 9999, 1, 2, 3