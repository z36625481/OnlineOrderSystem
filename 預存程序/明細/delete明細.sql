-- delete 訂單明細
create or alter procedure DeleteOrderRecord
@OrderNum int,       -- 要刪除的訂單編號
@DisherID int        -- 要刪除的品項
as
begin
delete from OrderRecord        -- 刪除訂單
where OrderNum = @OrderNum and DisherID = @DisherID  
end;