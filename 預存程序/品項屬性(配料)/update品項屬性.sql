-- update �~���ݩ�(�t��)
create or alter procedure UpdateMenuPlus
@dishes nvarchar(50),      -- �ª��t�ƦW��
@NewDishes nvarchar(50)    -- �s���t�ƦW��
as
begin 
	declare @SideDishID int =(
		select SideDishID        -- ��t��ID 
		from [dbo].[MenuPlus]    -- �q�t�Ƹ�ƪ��M��
		where dishes = @dishes   -- ���O��s���°t�ƦW��
		)

    update [dbo].[MenuPlus]         -- ��s�t�Ƹ�ƪ�
    set dishes = @NewDishes         -- �]�w�s���t��W��
    where SideDishID = @SideDishID  -- ���O��s���°t�ƪ�ID
end;

-- execute UpdateMenuPlus '�����', '���l��'