USE shop;

-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders
-- в интернет-магазине.
SELECT name
FROM users
WHERE id IN (SELECT DISTINCT user_id FROM orders);

SELECT name
FROM users AS u
JOIN orders AS o ON u.id = o.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT pr.name, pr.description, pr.price, ct.name AS catalog
FROM products AS pr JOIN catalogs AS ct
ON pr.catalog_id = ct.id; 

-- 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские назания городов, поле name - русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- УТОЧНЕНИЕ!!! При создании таблиц в таблице flights названия столбцов вылета и прилета
-- назвал from_ и to_.
SELECT fr.id, fr.from, t.to
FROM 
	(SELECT id, ci.name AS 'from' 
     FROM flights AS fl JOIN cities AS ci ON fl.from_ = ci.label) AS fr
	JOIN
    (SELECT id, ci.name AS 'to'
     FROM flights AS fl JOIN cities AS ci ON fl.to_ = ci.label) AS t
	ON fr.id = t.id
ORDER BY id;