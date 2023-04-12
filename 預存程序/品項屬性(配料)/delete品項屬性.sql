-- delete 品項屬性(配料)
create or alter procedure DeleteMenuPlus
@dishes nvarchar(50)      -- 要刪除的的配料名稱
as
begin 
	delete from [dbo].[MenuPlus]
	where [dishes] = @dishes
end;

-- execute DeleteMenuPlus '王子麵'