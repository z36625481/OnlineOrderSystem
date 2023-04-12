-- update 座位
create or alter procedure UpdateSeat
@OldTableID int,     -- 要更新的桌號
@NewTableID int,     -- 新的桌號
@TotleSeata int      -- 座位數量
as
begin
update dbo.seat                -- 更新位置
set TableID = @NewTableID,     -- 更新桌號
	seat = @TotleSeata         -- 總共有幾個位置
where TableID = @OldTableID    -- 尋找要更新的對應桌號

end;