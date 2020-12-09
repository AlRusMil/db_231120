-- Таблицы создаются под условия каждой конкретной  задачи

DROP database IF EXISTS shop;
CREATE database shop;
USE shop;

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
  SELECT * FROM users;
  
  UPDATE users
  SET created_at = NOW(), updated_at = NOW()
  LIMIT 6;
  
  SELECT * FROM users;
  
-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом
-- VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
-- Необходимо преобразовать поля к типу DATETIME, сохранив введенные ранее значения.
  
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(20) DEFAULT NULL,
  updated_at VARCHAR(20) DEFAULT NULL
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '10.01.2000 13:25', '23.02.2012 9:10'),
  ('Александр', '1985-05-20', '14.11.1992 10:10', '08.08.2008 23:58'),
  ('Сергей', '1988-02-14', '13.12.2013 9:12', '13.12.2013 9:12'),
  ('Иван', '1998-01-12', '13.01.2011 0:12', '15.01.2012 0:18'),
  ('Мария', '1992-08-29', '10.10.2010 12:12', '02.02.2012 13:15');
  
SELECT * FROM users;
DESCRIBE users;
  
UPDATE 
	users 
SET 
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
    updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i')
LIMIT 6;

ALTER TABLE 
	users 
MODIFY COLUMN created_at DATETIME,
MODIFY COLUMN updated_at DATETIME;

SELECT * FROM users;
DESCRIBE users;
  
-- 3. В таблице складских запасов storehoues_products в поле value могут встречаться самые
-- разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
-- увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
  
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';
  
INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
	(1, 1, 0),
    (2, 2, 2500),
    (1, 3, 0),
    (3, 3, 30),
    (4, 1, 500),
    (2, 2, 1);
    
SELECT * FROM storehouses_products;
  
SELECT value FROM storehouses_products
ORDER BY (value=0), value;

-- 4. Из таблицы users необходимо извлечь пользователей, родвишихся в августе и мае.
-- Месяцы заданы в виде списка английскихназваний (may, august).

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

SELECT * FROM users
WHERE monthname(birthday_at) = 'may' or monthname(birthday_at) = 'august';

-- 5. Из таблицы catalogs извлекаются записи при помощи запроса
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке,
-- заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');  
  
SELECT * FROM catalogs WHERE id IN (5, 1, 2);

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);
