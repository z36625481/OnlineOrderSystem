-- insert�~���ݩ�(�t��)
create or alter procedure InsertMenuPlus

@dishes nvarchar(50),   -- �s���t�ƦW��
@MenuItemsID int        -- ������ƻ��������Ʋz
as
begin
    insert into MenuPlus(dishes, MenuItemsID)   -- �bmenu���s�W���(�~����ID, �~���W��)
    values(@dishes, @MenuitemsID)               -- ��Ƥ��e(�~��ID, �~���W��)  
end;

