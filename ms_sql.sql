create table product
(
	"Артикул" INT PRIMARY KEY,
	"Название товара" TEXT NOT NULL,
	"Цена"  NUMERIC NOT NULL,
	"Описание"  TEXT NOT NULL
);

create table warehouse
(
	"Номер склада" INT PRIMARY KEY,
	"Город" TEXT NOT NULL,
	"Адрес" TEXT NOT NULL
);

create table product_on_warehouse
(
	"Артикул" INT NOT NULL,
	"Номер склада" INT NOT NULL,
	CONSTRAINT product_id FOREIGN KEY ("Артикул") REFERENCES product ("Артикул"),
	CONSTRAINT warehouse_id FOREIGN KEY ("Номер склада") REFERENCES warehouse ("Номер склада")
);


insert into product("Название товара", "Артикул", "Цена", "Описание")
values ('Джинсы',123, 1500, '1'),
		('Джинсы', 1234, 1700, '2'),
		('Футболка', 12345, 500, '3'),
		('Носки', 123456, 300, '4');

insert into warehouse("Номер склада", "Город", "Адрес")
values (1, 'Казань', 'ул.Мира,5'),
		(2, 'Москва', 'ул.Ленина,10'),
		(3, 'Пермь', 'ул.Кривошеина,2'),
		(4, 'Воронеж', 'ул.Домостроителей,7');

insert into product_on_warehouse("Артикул", "Номер склада")
values (123,4);,
		(1234,1),
		(12345,2),
		(12345,2),
		(123456,3),
		(123,4);

select "Номер склада"
	from product_on_warehouse
 where "Артикул"=123;

select "Артикул" ,
		COUNT (*) "Количество" 
	from product_on_warehouse
 where "Номер склада"=1
 group by "Артикул";

select "Название товара"
	from product_on_warehouse pow
 join warehouse w on pow.[Номер склада]=w.[Номер склада]
 join product p on pow.Артикул=p.Артикул
 where CONVERT(varchar,"Город")='Казань';

with a as (
select "Номер склада",
       COUNT("Артикул") art_count
	from product_on_warehouse
 where "Артикул"=123
 group by "Номер склада")
select top 1 "Номер склада" from a
 where art_count = (select max(art_count) from a);

