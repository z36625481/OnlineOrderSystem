-- update �q�����
create or alter procedure UpdateOrderRecord
@OrderNum int,       -- �n��s���q��s��
@dishid int,         -- �n��s���~��
@OrderID int,        -- �O��s���~��
@Quantity int        -- ��s�ƶq
as
begin
update OrderRecord         -- ��s�q�����
set DisherID = @dishid,    -- ��s�~��
    Quantity = @Quantity   -- ��s�ƶq
where OrderNum = @OrderNum -- ���i�q�檺
end
