CREATE SCHEMA `shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE `shop`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `discount` TINYINT NOT NULL,
  `aliace_name` VARCHAR(128) NULL,
  PRIMARY KEY (`id`));
  
#  ALTER TABLE `shop`.`category` 
# ADD COLUMN `aliace_name` VARCHAR(128) NULL AFTER `discount`;

CREATE TABLE `shop`.`product_brend` (
  `id` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `shop`.`product_type` (
  `id` INT NOT NULL,
  `type` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `shop`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `shop`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `phone` VARCHAR(32) NOT NULL,
  `datetime` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`));
  
    CREATE TABLE `shop`.`order_products` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `count` INT NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`));
  
# DROP TABLE `shop`.`category`;
# DROP TABLE `shop`.`order_products`;

# DROP DATABASE `shop`

# ALTER TABLE `shop`.`product_brend` 
# CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;


# INSERT -- Добавляем в таблицу новые позиции

INSERT INTO `shop`.`category` (`id`, `name`, `discount`) VALUES ('1', 'Женская одежда', '5');
INSERT INTO `shop`.`category` (`id`, `name`, `discount`) VALUES ('2', 'Мужская одежда', '0');
INSERT INTO `shop`.`category` (`id`, `name`, `discount`, `aliace_name`) VALUES ('3', 'Женская обувь', '10', NULL);
INSERT INTO `shop`.`category` (`id`, `name`, `discount`, `aliace_name`) VALUES ('4', 'Мужская обувь', '10', 'man''s chose');
INSERT INTO `shop`.`category` (`id`, `name`, `discount`) VALUES ('5', 'Шляпы', '0');

INSERT INTO `shop`.`product_brend` (`id`, `name`) VALUES ('1', 'Marc O''Polo');
INSERT INTO `shop`.`product_brend` (`id`, `name`) VALUES ('2', 'ALCOTT');
INSERT INTO `shop`.`product_brend` (`id`, `name`) VALUES ('3', 'GUESS');

INSERT INTO `shop`.`product_type` (`id`, `type`) VALUES ('1', 'Платье');
INSERT INTO `shop`.`product_type` (`id`, `type`) VALUES ('2', 'Футболка');

INSERT INTO `shop`.`product` (brand_id, type_id, category_id, price) VALUES ('1', '1', '1', 8999);

INSERT INTO `shop`.`order` (name, phone, datetime) VALUES ('Василий Пупкин', '+79817500060', '2017-08-09 14:45');
INSERT INTO `shop`.`order` (name, phone, datetime) VALUES ('Петров Иван', '+79057511160', '2017-08-20 15:00');

INSERT INTO `shop`.`product_type` (`id`, `type`) VALUES ('3', 'Майки'); -- Добавляем новую категорию "майки"

INSERT INTO `shop`.`order_products` (`order_id`, `product_id`, `count`) VALUES ('2', '3', '2'); -- Новый заказ Петрова
INSERT INTO `shop`.`order_products` (`order_id`, `product_id`, `count`) VALUES ('2', '1', '2'); -- Новый заказ Петрова

# SELECT -- Фильтруем данные и выводим на экран

-- Выводим все категории--
SELECT * from shop.category;

-- Выводим категории с id = 3 --
SELECT * from shop.category where id = 3;

-- Выводим категории со скидкой не равной 0 --
SELECT * from shop.category where discount != 0;

-- Выводим категории со скидкой больше 5 --
SELECT * from shop.category where discount > 5;

-- Выводим категории со скидкой больше 5 и меньше 15 процентов --
SELECT * from shop.category where (discount > 5) and (discount < 15) ;

-- Выводим категории со скидкой меньше 5 и больше или равно 10 процентов --
SELECT * from shop.category where (discount < 5) or (discount >= 10) ;

-- Выводим категории с псевдонимом NULL или NOT NULL --
SELECT * from shop.category where aliace_name is not null;
SELECT * from shop.category where aliace_name is null;


# SELECT столбец

-- Выводим названия категорий--
SELECT name from shop.category;

-- Выводим названия категорий и скидки--
SELECT name, discount from shop.category;


# DISTINCT == уникальные значения

-- Выводим уникальные значения скидок вне зависимоти от количества одинаковых значений --
SELECT distinct discount from shop.category;


# ORDER BY == сортировка значений

-- Сортируем значения скидок по возрастанию --
SELECT name, discount from shop.category order by discount;

-- Сортируем значения скидок по убыванию --
SELECT name, discount from shop.category order by discount desc;

-- Сортируем значения скидок по убыванию где скидка не равна нулю --
SELECT name, discount from shop.category where discount != 0 order by discount;


# LIMIT == задаём количество выводимых значений

-- Выводим первые две строки из таблицы --
SELECT * from shop.category limit 2;

-- SELECT id from shop.category where discount = 3;

-- Выводим первые 3 строки из таблицы где скидка не равна 0 --
SELECT * from shop.category where discount != 0 limit 3;

-- Домашнее задание --
	SELECT * from shop.product_brend where id = 3; -- Выводим название бренда под id = 3
	SELECT * from shop.product_type limit 2; -- Выводим два первых типа товаров
	SELECT name, discount from shop.category where discount < 10 order by name; -- Выводим названия товаров со скидкой меньше 10 и сортируем их по имени
    

# UPDATE == заменяем значение выбранной позиции

-- Заменяем в таблице category позицию "Шляпы" на "Головные уборы" --
update shop.category set name = 'Головные уборы' where id = 5;

-- Заменяем в таблице category все нулевые скидки на 3 --
update shop.category set discount = 3 where id in (2, 5);


# DELETE == удаляет выбранную позицио из таблицы

-- Удаляем из таблицы category позицию "Головные уборы" --
delete from shop.category  where id = 5;

-- Удалить весь столбец из таблицы --
ALTER TABLE shop.order DROP COLUMN price;

-- Домашнее задание --
	update shop.category set aliace_name = 'вся жен. одежда' where id = 1; -- Заменяем aliace_name для категории "Женсткая одежда"
	update shop.category set aliace_name = 'вся муж. одежда' where id = 2; -- Заменяем aliace_name для категории "Мужская одежда"
	update shop.category set aliace_name = 'women chose' where id = 3; -- Заменяем aliace_name для категории "Женсткая обувь"
 
	INSERT INTO shop.category (id, `name`, `discount`) VALUES (5, 'Тетя Клава Company', '50'); -- Добавляем в таблицу категорий новый бренд
	# INSERT INTO shop.category (`name`, `discount`) VALUES ('Тетя Клава Company', '50'); -- Добавляем в таблицу категорий новый бренд
    delete from shop.category  where id = 5; -- Удаляем новый добавленный бренд
    # delete from shop.category  where id = 6; -- Удаляем новый добавленный бренд
    
    
# FOREIGN KEY - Создает взаимосвясь таблиц
    
ALTER TABLE `shop`.`product` 
ADD INDEX `fk_brend_idx` (`brand_id` ASC);
ALTER TABLE `shop`.`product` 
ADD CONSTRAINT `fk_brend`
  FOREIGN KEY (`brand_id`)
  REFERENCES `shop`.`product_brend` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  

ALTER TABLE `shop`.`product` 
ADD INDEX `fk_type_idx` (`type_id` ASC);
ALTER TABLE `shop`.`product` 
ADD CONSTRAINT `fk_type`
  FOREIGN KEY (`type_id`)
  REFERENCES `shop`.`product_type` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  
ALTER TABLE `shop`.`product` 
ADD INDEX `fk_category_idx` (`category_id` ASC);
ALTER TABLE `shop`.`product` 
ADD CONSTRAINT `fk_category`
  FOREIGN KEY (`category_id`)
  REFERENCES `shop`.`category` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  
  ALTER TABLE `shop`.`order_products` 
ADD INDEX `fk_product_idx` (`product_id` ASC);
ALTER TABLE `shop`.`order_products` 
ADD CONSTRAINT `fk_product`
  FOREIGN KEY (`product_id`)
  REFERENCES `shop`.`product` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


# INNER JOIN - Вывод данных по зависимым таблицам

select * from shop.product
inner join shop.category on product.category_id = category.id;

select product.id, price, name from shop.product
inner join shop.category on product.category_id = category.id;

select product.id, price, name from shop.category
inner join shop.product on product.category_id = category.id;

select product.id, price, name from shop.product
inner join shop.category on product.category_id = category.id
where price < 8000;

select * from shop.product
inner join shop.category on product.category_id = category.id
inner join shop.product_brand on product.brand_id = product_brand.id
inner join shop.product_type on product.type_id = product_type.id;

select product.id, product_brand.name, product_type.type, category.name, product.price from shop.product
inner join shop.category on product.category_id = category.id
inner join shop.product_brand on product.brand_id = product_brand.id
inner join shop.product_type on product.type_id = product_type.id;


-- Домашнее задание --
	select product.id, product_brand.name, product_type.type, category.name, product.price from shop.product
	inner join shop.category on product.category_id = category.id
	inner join shop.product_brand on product.brand_id = product_brand.id
	inner join shop.product_type on product.type_id = product_type.id
	where product_type.type = 'Футболка';
    
    
# LEFT JOIN - Добавляет все поля из левой таблицы и пересекающиеся поля из правой.

select category.id, category.name, category.discount, product.price from shop.product
left join shop.category on product.category_id = category.id;


# LEFT JOIN - Добавляет все поля из левой таблицы и пересекающиеся поля из правой.

select category.id, category.name, category.discount, product.price from shop.product
right join shop.category on product.category_id = category.id;

-- Домашнее задание --
	select product_type.* from shop.product_type
	left join shop.product on product_type.id = product.type_id
    where product.type_id is null;
    
    select product.id, product_brand.name, product_type.type, category.name, product.price from shop.product
	left join shop.order_products on product.id = order_products.product_id
	left join shop.category on product.category_id = category.id
	left join shop.product_brand on product.brand_id = product_brand.id
	left join shop.product_type on product.type_id = product_type.id
    where order_products.order_id is null;
    
    
# UNION - "склеивает" 2 запросы приставляя второй внизу первого. 

select * from shop.category
UNION
select * from shop.order;


# АГРЕГИРУЮЩИЕ ФУНКЦИИ - позволяют выполнять арифметические действия над данными ячеек в таблице. 
	# sum() avg() max() min() count()

select count(category.discount) as количество from shop.category where category.discount < 10;
select sum(category.discount) as summ, min(category.discount) as min, max(category.discount) as max from shop.category;

-- Домашнее задание --
	-- Проверка объединенных табличных данных
	select * from shop.order_products
	inner join shop.product on order_products.product_id = product.id
	inner join shop.order on order_products.order_id = `order`.id;


	select `order`.name, sum(product.price*order_products.count) as `Сумма заказа` from shop.order_products
	inner join shop.product on order_products.product_id = product.id
	inner join shop.order on order_products.order_id = `order`.id
    where `order`.name = 'Василий Пупкин'
    
    UNION
    
	select `order`.name, sum(product.price*order_products.count) as `Сумма заказа` from shop.order_products
	inner join shop.product on order_products.product_id = product.id
	inner join shop.order on order_products.order_id = `order`.id
    where `order`.name = 'Петров Иван';

    
# GROUP BY - 

	select `order`.name, sum(price*order_products.count) as `Сумма заказа` from shop.order_products
	inner join shop.product on order_products.product_id = product.id
	inner join shop.order on order_products.order_id = `order`.id
    group by `order`.name;
    
    select `order`.name, max(price*`count`), count(*) from shop.order_products
	inner join shop.product on order_products.product_id = product.id
	inner join shop.order on order_products.order_id = `order`.id
    group by `order`.name;

    
# Like - ищет символыalter
		
select `order`.name, max(price*`count`), count(*) from shop.order_products
inner join shop.product on order_products.product_id = product.id
inner join shop.order on order_products.order_id = `order`.id
where `order`.name like 'В%'
group by `order`.name;

# having - вводит ограничения (фильтры) где нельзя использовать where

select `order`.name, max(price*`count`), sum(`count`) from shop.order_products
inner join shop.product on order_products.product_id = product.id
inner join shop.order on order_products.order_id = `order`.id
group by `order`.name
having sum(`count`) > 2;


# INDEX - делает ускорение запросов в базу данных по выбранному параметру. В данном случае оптимизируем price
ALTER TABLE `shop`.`product` 
ADD INDEX `price_index` (`price` ASC);

# TRANSACTION - делает совместное выполнение операций. Выполнение произойдет, если вся группа операций будет выполнено.

select * from shop.product;
start transaction;
	update shop.product set product.price = product.price - 100 where product.id = 1;  
	update shop.product set product.price = product.price + 100 where product.id = 2;  
commit;    
    