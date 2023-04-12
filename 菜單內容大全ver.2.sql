-- delete from Menu_plus

-- delete from menu

-- select * from Menu_plus go select * from menu

use Onlineordersys


/*
select * from Menu
go
select * from MenuChoose
go
select * from MenuItems
go
select * from MenuPlus
go

*/
--員工資料
insert into staff(Email, PW, personnel)
values('Boss@OldBrother.com', 'I_am_Boss', 'Boss')
insert into staff(Email, PW, personnel)
values('chef@OldBrother.com', 'I_am_chef', 'Staff')
insert into staff(Email, PW, personnel)
values('waiter@OldBrother.com', 'I_am_Waiter', 'Staff')
insert into staff(Email, PW, personnel)
values('Trash@OldBrother.com', 'I_am_Trash', 'Staff')

--客人資料
----
----
----
----


--菜單分類
/*
insert into MenuType(TypeID, DishType)
values(1, '麵食')
insert into MenuType(TypeID, DishType)
values(2, '鍋燒')
insert into MenuType(TypeID, DishType)
values(3, '飯食')
insert into MenuType(TypeID, DishType)
values(4, '湯品')
insert into MenuType(TypeID, DishType)
values(5, '小菜')
insert into MenuType(TypeID, DishType)
values(6, '其他')    */

insert into MenuType(DishType)
values('麵食')
insert into MenuType(DishType)
values('鍋燒')
insert into MenuType(DishType)
values('飯食')
insert into MenuType(DishType)
values('湯品')
insert into MenuType(DishType)
values('小菜')
insert into MenuType(DishType)
values('其他')


-- A 料理對應到 B 類型
insert into MenuItems(MenuItemsID, items)
values(1, '份量')
insert into MenuItems(MenuItemsID, items)
values(2, '乾湯')
insert into MenuItems(MenuItemsID, items)
values(3, '主食')



--配料資料   ( B 類型對應到 C 選項)
--                         C        B
insert into MenuPlus(dishes,MenuItemsID)
values('大', 1)
insert into MenuPlus(dishes,MenuItemsID)
values('小', 1)
insert into MenuPlus(dishes,MenuItemsID)
values('乾', 2)
insert into MenuPlus(dishes,MenuItemsID)
values('湯', 2)
insert into MenuPlus(dishes,MenuItemsID)
values('意麵', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('冬粉', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('雞絲', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('烏龍', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('米粉', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('白飯', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('飯湯', 3)
insert into MenuPlus(dishes,MenuItemsID)
values('科學麵', 3)




-- 菜單資料

insert into menu(dishes, price, TypeID)
values('陽春麵', 45, 1)

insert into menu(dishes, price, TypeID)
values('餛飩麵', 55, 1)

insert into menu(dishes, price, TypeID)
values('沙茶麵', 55, 1)

insert into menu(dishes, price, TypeID)
values('麻醬麵', 55, 1)

insert into menu(dishes, price, TypeID)
values('榨菜肉絲麵', 55, 1)

--- 鍋燒系列 

insert into menu(dishes, price, TypeID)
values('鍋燒-原味', 75, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-泡菜', 85, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-味噌', 85, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-沙茶', 85, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-咖哩', 85, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-豬肉片', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-皮蛋瘦肉', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-魚皮', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-魚肉', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-蛤仔', 70, 2)
insert into menu(dishes, price, TypeID)
values(N'鍋燒-魩仔魚', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-香菇雞柳', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-蔬菜蛋花', 70, 2)
insert into menu(dishes, price, TypeID)
values('鍋燒-芋頭', 70, 2)

----湯類
insert into menu(dishes, price, TypeID)
values('魚皮湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('魚肉湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('蛤仔湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('綜合湯', 65, 3)
insert into menu(dishes, price, TypeID)
values('餛飩湯', 45, 3)
insert into menu(dishes, price, TypeID)
values('貢丸湯', 35, 3)
insert into menu(dishes, price, TypeID)
values('魚丸湯', 35, 3)
insert into menu(dishes, price, TypeID)
values('貢/魚丸湯', 35, 3)
insert into menu(dishes, price, TypeID)
values(N'魩魚蔬菜湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('香菇雞柳湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('紫菜蛋花湯', 45, 3)
insert into menu(dishes, price, TypeID)
values('芋頭蔬菜湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('蔬菜蛋花湯', 55, 3)
insert into menu(dishes, price, TypeID)
values('榨菜肉絲湯', 40, 3)

-- 飯類
insert into menu(dishes, price, TypeID)
values('白飯', 10, 4)
insert into menu(dishes, price, TypeID)
values('雞柳飯', 40, 4)
insert into menu(dishes, price, TypeID)
values('豬肉飯', 40, 4)


-- 水煮健康餐盒
insert into menu(dishes, price, TypeID)
values('雞柳便當', 70, 4)
insert into menu(dishes, price, TypeID)
values('豬肉便當', 70, 4)
insert into menu(dishes, price, TypeID)
values('鮮蝦便當', 80, 4)
insert into menu(dishes, price, TypeID)
values('雞蝦便當', 80, 4)
insert into menu(dishes, price, TypeID)
values('豬蝦便當', 80, 4)
insert into menu(dishes, price, TypeID)
values('豬雞便當', 80, 4)

-- 其他
insert into menu(dishes, price, TypeID)
values('燙青菜', 45, 5)
insert into menu(dishes, price, TypeID)
values('燙蛤仔', 65, 5)
insert into menu(dishes, price, TypeID)
values('乾魚皮', 65, 5)
insert into menu(dishes, price, TypeID)
values('乾魚肉', 65, 5)
insert into menu(dishes, price, TypeID)
values('乾豬肉片', 65, 5)
insert into menu(dishes, price, TypeID)
values('特製炒手', 60, 5)
insert into menu(dishes, price, TypeID)
values('水餃(10顆)', 60, 6)
insert into menu(dishes, price, TypeID)
values('20粒裝生水餃', 85, 6)
insert into menu(dishes, price, TypeID)
values('特製辣椒', 150, 6)


-- 菜單品項關聯
insert into MenuChoose(DisherID, MenuItemsID)
values(1, 1)
insert into MenuChoose(DisherID, MenuItemsID)
values(1, 2)
insert into MenuChoose(DisherID, MenuItemsID)
values(2, 1)
insert into MenuChoose(DisherID, MenuItemsID)
values(2, 2)
insert into MenuChoose(DisherID, MenuItemsID)
values(3, 1)
insert into MenuChoose(DisherID, MenuItemsID)
values(3, 2)
insert into MenuChoose(DisherID, MenuItemsID)
values(4, 1)
insert into MenuChoose(DisherID, MenuItemsID)
values(4, 2)
insert into MenuChoose(DisherID, MenuItemsID)
values(5, 1)
insert into MenuChoose(DisherID, MenuItemsID)
values(5, 2)
insert into MenuChoose(DisherID, MenuItemsID)
values(6, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(7, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(8, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(9, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(10, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(11, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(12, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(13, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(14, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(15, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(16, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(17, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(18, 3)
insert into MenuChoose(DisherID, MenuItemsID)
values(19, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(20, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(21, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(22, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(23, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(24, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(25, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(26, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(27, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(28, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(29, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(30, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(31, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(32, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(33, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(34, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(35, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(36, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(37, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(38, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(39, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(40, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(41, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(42, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(43, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(44, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(45, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(46, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(47, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(48, null)
insert into MenuChoose(DisherID, MenuItemsID)
values(49, null)

-- 座位

insert into seat(TableID, seat)
values(1, 6)
insert into seat(TableID, seat)
values(2, 6)
insert into seat(TableID, seat)
values(3, 6)
insert into seat(TableID, seat)
values(4, 6)
insert into seat(TableID, seat)
values(5, 6)


