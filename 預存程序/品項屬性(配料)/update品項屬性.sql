-- update 品項屬性(配料)
create or alter procedure UpdateMenuPlus
@dishes nvarchar(50),      -- 舊的配料名稱
@NewDishes nvarchar(50)    -- 新的配料名稱
as
begin 
	declare @SideDishID int =(
		select SideDishID        -- 找配料ID 
		from [dbo].[MenuPlus]    -- 從配料資料表中尋找
		where dishes = @dishes   -- 找到逾更新的舊配料名稱
		)

    update [dbo].[MenuPlus]         -- 更新配料資料表
    set dishes = @NewDishes         -- 設定新的配菜名稱
    where SideDishID = @SideDishID  -- 找到逾更新的舊配料的ID
end;

-- execute UpdateMenuPlus '科學麵', '王子麵'