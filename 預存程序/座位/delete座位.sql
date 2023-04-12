-- delete 座位
create or alter procedure DeleteSeat
@TableID int -- 要刪除的桌號
as
begin
delete from seat          -- 刪除座位
where TableID = @TableID  -- 相對應的桌號
end