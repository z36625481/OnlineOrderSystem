-- delete���
create or alter procedure DeleteMenu
@WantDropDisherID int     -- �n delete ����� ID
as
begin       
    delete from [dbo].[menu]            -- �R�� menu ��
    where disherID = @WantDropDisherID  -- �n delete ����檺ID �����
end;
-- execute DeleteMenu 53