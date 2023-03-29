﻿-- delete from Menu_plus

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


-- A 料理對應到 B 類型
insert into Menuitems(MenuitemsID, items)
values(1, '份量')
insert into Menuitems(MenuitemsID, items)
values(2, '乾湯')
insert into Menuitems(MenuitemsID, items)
values(3, '主食')



--配料資料   ( B 類型對應到 C 選項)
--                         C        B
insert into MenuPlus(dishes,MenuitemsID)
values('大', 1)
insert into MenuPlus(dishes,MenuitemsID)
values('小', 1)
insert into MenuPlus(dishes,MenuitemsID)
values('乾', 2)
insert into MenuPlus(dishes,MenuitemsID)
values('湯', 2)
insert into MenuPlus(dishes,MenuitemsID)
values('意麵', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('冬粉', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('雞絲', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('烏龍', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('米粉', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('白飯', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('飯湯', 3)
insert into MenuPlus(dishes,MenuitemsID)
values('科學麵', 3)




-- 菜單資料

insert into menu(dishes, HowMuch )
values('陽春麵', 45)

insert into menu(dishes, HowMuch )
values('餛飩麵', 55)

insert into menu(dishes, HowMuch )
values('沙茶麵', 55)

insert into menu(dishes, HowMuch )
values('麻醬麵', 55)

insert into menu(dishes, HowMuch )
values('榨菜肉絲麵', 55)

--- 鍋燒系列 

insert into menu(dishes, HowMuch )
values('鍋燒-原味', 75)
insert into menu(dishes, HowMuch )
values('鍋燒-泡菜', 85)
insert into menu(dishes, HowMuch )
values('鍋燒-味噌', 85)
insert into menu(dishes, HowMuch )
values('鍋燒-沙茶', 85)
insert into menu(dishes, HowMuch )
values('鍋燒-咖哩', 85)
insert into menu(dishes, HowMuch )
values('鍋燒-豬肉片', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-皮蛋瘦肉', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-魚皮', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-魚肉', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-蛤仔', 70)
insert into menu(dishes, HowMuch )
values(N'鍋燒-魩仔魚', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-香菇雞柳', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-蔬菜蛋花', 70)
insert into menu(dishes, HowMuch )
values('鍋燒-芋頭', 70)

----湯類
insert into menu(dishes, HowMuch )
values('魚皮湯', 55)
insert into menu(dishes, HowMuch )
values('魚肉湯', 55)
insert into menu(dishes, HowMuch )
values('蛤仔湯', 55)
insert into menu(dishes, HowMuch )
values('綜合湯', 65)
insert into menu(dishes, HowMuch )
values('餛飩湯', 45)
insert into menu(dishes, HowMuch )
values('貢丸湯', 35)
insert into menu(dishes, HowMuch )
values('魚丸湯', 35)
insert into menu(dishes, HowMuch )
values('貢/魚丸湯', 35)
insert into menu(dishes, HowMuch )
values(N'魩魚蔬菜湯', 55)
insert into menu(dishes, HowMuch )
values('香菇雞柳湯', 55)
insert into menu(dishes, HowMuch )
values('紫菜蛋花湯', 45)
insert into menu(dishes, HowMuch )
values('芋頭蔬菜湯', 55)
insert into menu(dishes, HowMuch )
values('蔬菜蛋花湯', 55)
insert into menu(dishes, HowMuch )
values('榨菜肉絲湯', 40)

-- 飯類
insert into menu(dishes, HowMuch )
values('白飯', 10)
insert into menu(dishes, HowMuch )
values('雞柳飯', 40)
insert into menu(dishes, HowMuch )
values('豬肉飯', 40)


-- 水煮健康餐盒
insert into menu(dishes, HowMuch )
values('雞柳便當', 70)
insert into menu(dishes, HowMuch )
values('豬肉便當', 70)
insert into menu(dishes, HowMuch )
values('鮮蝦便當', 80)
insert into menu(dishes, HowMuch )
values('雞蝦便當', 80)
insert into menu(dishes, HowMuch )
values('豬蝦便當', 80)
insert into menu(dishes, HowMuch )
values('豬雞便當', 80)

-- 其他
insert into menu(dishes, HowMuch )
values('燙青菜', 45)
insert into menu(dishes, HowMuch )
values('燙蛤仔', 65)
insert into menu(dishes, HowMuch )
values('乾魚皮', 65)
insert into menu(dishes, HowMuch )
values('乾魚肉', 65)
insert into menu(dishes, HowMuch )
values('乾豬肉片', 65)
insert into menu(dishes, HowMuch )
values('特製炒手', 60)
insert into menu(dishes, HowMuch )
values('水餃(10顆)', 60)
insert into menu(dishes, HowMuch )
values('20粒裝生水餃', 85)
insert into menu(dishes, HowMuch )
values('特製辣椒', 150)


-- 菜單品項關聯
insert into MenuChoose(disherID, MenuitemsID)
values(1, 1)
insert into MenuChoose(disherID, MenuitemsID)
values(1, 2)
insert into MenuChoose(disherID, MenuitemsID)
values(2, 1)
insert into MenuChoose(disherID, MenuitemsID)
values(2, 2)
insert into MenuChoose(disherID, MenuitemsID)
values(3, 1)
insert into MenuChoose(disherID, MenuitemsID)
values(3, 2)
insert into MenuChoose(disherID, MenuitemsID)
values(4, 1)
insert into MenuChoose(disherID, MenuitemsID)
values(4, 2)
insert into MenuChoose(disherID, MenuitemsID)
values(5, 1)
insert into MenuChoose(disherID, MenuitemsID)
values(5, 2)
insert into MenuChoose(disherID, MenuitemsID)
values(6, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(7, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(8, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(9, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(10, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(11, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(12, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(13, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(14, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(15, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(16, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(17, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(18, 3)
insert into MenuChoose(disherID, MenuitemsID)
values(19, null)
insert into MenuChoose(disherID, MenuitemsID)
values(20, null)
insert into MenuChoose(disherID, MenuitemsID)
values(21, null)
insert into MenuChoose(disherID, MenuitemsID)
values(22, null)
insert into MenuChoose(disherID, MenuitemsID)
values(23, null)
insert into MenuChoose(disherID, MenuitemsID)
values(24, null)
insert into MenuChoose(disherID, MenuitemsID)
values(25, null)
insert into MenuChoose(disherID, MenuitemsID)
values(26, null)
insert into MenuChoose(disherID, MenuitemsID)
values(27, null)
insert into MenuChoose(disherID, MenuitemsID)
values(28, null)
insert into MenuChoose(disherID, MenuitemsID)
values(29, null)
insert into MenuChoose(disherID, MenuitemsID)
values(30, null)
insert into MenuChoose(disherID, MenuitemsID)
values(31, null)
insert into MenuChoose(disherID, MenuitemsID)
values(32, null)
insert into MenuChoose(disherID, MenuitemsID)
values(33, null)
insert into MenuChoose(disherID, MenuitemsID)
values(34, null)
insert into MenuChoose(disherID, MenuitemsID)
values(35, null)
insert into MenuChoose(disherID, MenuitemsID)
values(36, null)
insert into MenuChoose(disherID, MenuitemsID)
values(37, null)
insert into MenuChoose(disherID, MenuitemsID)
values(38, null)
insert into MenuChoose(disherID, MenuitemsID)
values(39, null)
insert into MenuChoose(disherID, MenuitemsID)
values(40, null)
insert into MenuChoose(disherID, MenuitemsID)
values(41, null)
insert into MenuChoose(disherID, MenuitemsID)
values(42, null)
insert into MenuChoose(disherID, MenuitemsID)
values(43, null)
insert into MenuChoose(disherID, MenuitemsID)
values(44, null)
insert into MenuChoose(disherID, MenuitemsID)
values(45, null)
insert into MenuChoose(disherID, MenuitemsID)
values(46, null)
insert into MenuChoose(disherID, MenuitemsID)
values(47, null)
insert into MenuChoose(disherID, MenuitemsID)
values(48, null)
insert into MenuChoose(disherID, MenuitemsID)
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


