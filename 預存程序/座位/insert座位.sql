-- insert座位
create　or alter procedure InsertSeat
@NewTableID int,  -- 新的座位(桌號)
@TotalSeat int    -- 座位數量
as
begin
insert into [dbo].[seat](TableID, Seat) --    桌號         座位數量 
values(@NewTableID, @TotalSeat)         --  新的桌號       座位總數
end;

-- execute Insertseat 7,4