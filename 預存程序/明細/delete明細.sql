-- delete �q�����
create or alter procedure DeleteOrderRecord
@OrderNum int,       -- �n�R�����q��s��
@DisherID int        -- �n�R�����~��
as
begin
delete from OrderRecord        -- �R���q��
where OrderNum = @OrderNum and DisherID = @DisherID  
end;