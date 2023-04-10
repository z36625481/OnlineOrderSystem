-- update ���
create or alter procedure UpdateMenu
@DisherName nvarchar(50),      -- �ª����W��
@NewDisherName nvarchar(50),   -- �s�����W��
@NewMach int,                  -- �s��������
@NewType nvarchar(50)          -- �s���������

as
begin
    declare @UpdateDisherID int =(
        select disherID                  -- ���ª����W��
        from [dbo].[menu]                -- �q menu ��
        where dishes=@DisherName         -- ���ª����W��ID
        )

    update [dbo].[menu]               -- �N menu ���� 
    set dishes = @NewDisherName,      -- ���W�٧�s���s�����W��
        price = @NewMach,             -- ������s���s������
        DishType = @NewType           -- ������s���s�������
    where disherID = @UpdateDisherID  -- ���@�D�檺

        
end;
