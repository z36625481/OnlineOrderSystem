-- delete菜單
create or alter procedure DeleteMenu
@WantDropDisherID int     -- 要 delete 的菜單 ID
as
begin       
    delete from [dbo].[menu]            -- 刪除 menu 的
    where disherID = @WantDropDisherID  -- 要 delete 的菜單的ID 的資料
end;
-- execute DeleteMenu 53