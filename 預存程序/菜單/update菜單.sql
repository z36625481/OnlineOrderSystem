-- update ���
create or alter procedure UpdateMenu
@DisherName nvarchar(50),      -- �ª����W��
-- @HowMach int,               -- �ª�������(�n�����ݭn)
@NewDisherName nvarchar(50),   -- �s�����W��
@NewMach int                   -- �s��������

as
begin
    declare @UpdateDisherID int =(
        select disherID                  -- ���ª����W��
        from [dbo].[menu]                -- �q menu ��
        where dishes=@DisherName         -- ���ª����W��ID
        )

    update [dbo].[menu]               -- �N menu ���� 
    set dishes = @NewDisherName,      -- ���W�٧�s���s�����W��
        HowMuch = @NewMach            -- ������s���s������
    where disherID = @UpdateDisherID  -- ���@�D�檺

        
end;
