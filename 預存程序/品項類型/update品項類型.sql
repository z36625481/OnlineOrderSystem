-- update�~������
create or alter procedure UpdateMenuItems
@items nvarchar(50),      -- �ª��~���W��
@NewItems nvarchar(50)   -- �s���~���W��
as
begin
    declare @UpdateItemsID int =(
        select MenuitemsID            -- ���ª��~���W��
        from [dbo].[MenuItems]     �@ -- �q menu ��
        where items�@=�@@items       -- ���ª��~���W��ID
        )

    update [dbo].[MenuItems]      �@   -- �N menu ���� 
    set items = @NewItems�@    �@�@�@�@  -- �~���W�٧�s���s���~���W��
    where MenuItemsID = @UpdateItemsID  -- ���@�ӫ~����

        
end;
