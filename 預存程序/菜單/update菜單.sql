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
