-- insesrt 訂單明細
create or alter procedure InsertOrderRecord
@OrderNum int,       -- 要新增的訂單編號
@DisherID int,       -- 要新增的品項
@Quantity int,       -- 新增數量
@TableID int         -- 新增桌號
as
begin
insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- 新增 "訂單編號", "菜單編號", "數量", "桌號"
values(@OrderNum, @dishid, @Quantity, @TableID)                  --要新增的訂單編號, 要新增的品項, 新增數量, 新增數量
end;