-- update 菜單
create or alter procedure UpdateMenu
@DisherName nvarchar(50),      -- 舊的菜單名稱
-- @HowMach int,               -- 舊的菜單價錢(好像不需要)
@NewDisherName nvarchar(50),   -- 新的菜單名稱
@NewMach int                   -- 新的菜單價錢

as
begin
    declare @UpdateDisherID int =(
        select disherID                  -- 用舊的菜單名稱
        from [dbo].[menu]                -- 從 menu 中
        where dishes=@DisherName         -- 找舊的菜單名稱ID
        )

    update [dbo].[menu]               -- 將 menu 中的 
    set dishes = @NewDisherName,      -- 菜單名稱更新為新的菜單名稱
        HowMuch = @NewMach            -- 價錢更新為新的價錢
    where disherID = @UpdateDisherID  -- 哪一道菜的

        
end;
