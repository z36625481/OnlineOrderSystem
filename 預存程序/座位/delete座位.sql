-- delete �y��
create or alter procedure DeleteSeat
@TableID int -- �n�R�����ู
as
begin
delete from seat          -- �R���y��
where TableID = @TableID  -- �۹������ู
end