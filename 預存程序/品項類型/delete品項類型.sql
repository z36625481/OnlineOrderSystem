-- delete品項類型
create or alter procedure DeleteMenuItems
@WantDropItems nvarchar(50)     -- 要 delete 的品項 
as　
begin       
    delete from [dbo].[MenuItems]       -- 刪除 menu 的
    where items = @WantDropItems        -- 要 delete 的品項的ID 的資料
end;

-- execute DeleteMenuItems '份量'