-- insesrt �q�����
create or alter procedure InsertOrderRecord
@OrderNum int,       -- �n�s�W���q��s��
@DisherID int,       -- �n�s�W���~��
@Quantity int,       -- �s�W�ƶq
@TableID int         -- �s�W�ู
as
begin
insert into [dbo].[OrderRecord](OrderNum, DisherID, Quantity, TableID) -- �s�W "�q��s��", "���s��", "�ƶq", "�ู"
values(@OrderNum, @dishid, @Quantity, @TableID)                  --�n�s�W���q��s��, �n�s�W���~��, �s�W�ƶq, �s�W�ƶq
end;