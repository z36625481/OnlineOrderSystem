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
