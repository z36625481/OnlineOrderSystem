-- delete �~���ݩ�(�t��)
create or alter procedure DeleteMenuPlus
@dishes nvarchar(50)      -- �n�R�������t�ƦW��
as
begin 
	delete from [dbo].[MenuPlus]
	where [dishes] = @dishes
end;

-- execute DeleteMenuPlus '���l��'