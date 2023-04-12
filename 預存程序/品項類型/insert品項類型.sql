-- insert品項類型
create or alter procedure InsertMenuItems

@MenuitemsID　int,　    -- 新品項的ID
@items　nvarchar(50)    -- 新品項的名稱
as
begin
    insert into MenuItems(MenuitemsID, items)   -- 在menu中新增資料(品項的ID, 品項名稱)
    values(@MenuitemsID, @items)         -- 資料內容(品項ID, 品項名稱)           
end;


