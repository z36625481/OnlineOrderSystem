-- update �y��
create or alter procedure UpdateSeat
@OldTableID int,     -- �n��s���ู
@NewTableID int,     -- �s���ู
@TotleSeata int      -- �y��ƶq
as
begin
update dbo.seat                -- ��s��m
set TableID = @NewTableID,     -- ��s�ู
	seat = @TotleSeata         -- �`�@���X�Ӧ�m
where TableID = @OldTableID    -- �M��n��s�������ู

end;