-- insert品項屬性(配料)
create or alter procedure InsertMenuPlus

@dishes nvarchar(50),   -- 新的配料名稱
@MenuItemsID int        -- 對應到甚麼類型的料理
as
begin
    insert into MenuPlus(dishes, MenuItemsID)   -- 在menu中新增資料(品項的ID, 品項名稱)
    values(@dishes, @MenuitemsID)               -- 資料內容(品項ID, 品項名稱)  
end;

