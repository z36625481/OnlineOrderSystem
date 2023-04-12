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
