-- delete�~������
create or alter procedure DeleteMenuItems
@WantDropItems nvarchar(50)     -- �n delete ���~�� 
as�@
begin       
    delete from [dbo].[MenuItems]       -- �R�� menu ��
    where items = @WantDropItems        -- �n delete ���~����ID �����
end;

-- execute DeleteMenuItems '���q'