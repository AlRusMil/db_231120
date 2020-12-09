DROP database IF EXISTS shop;
CREATE database shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29'),
  ('Георгий', '1984-10-10'),
  ('Дмитрий', '1989-12-01'),
  ('Евгения', '1979-03-25'),
  ('Анна', '1981-05-23');

-- 1. Подсчитайте средний возраст пользователей в таблице users.
  
SELECT name, timestampdiff(YEAR, birthday_at, NOW()) AS age
FROM users;
  
SELECT round(avg(timestampdiff(YEAR, birthday_at, NOW())),2) AS age
FROM users;  
  
SELECT round(avg(timestampdiff(YEAR, birthday_at, NOW()))) AS age
FROM users;    
  
-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- Дни рождения у пользователей
SELECT name,  DAYNAME(STR_TO_DATE(CONCAT(YEAR(NOW()),'-',
								  MONTH(birthday_at),'-',
                                  DAY(birthday_at)), '%Y-%m-%d')) as DAYOFWEEK
FROM users;

-- Количество дней рождения на каждый день недели
SELECT DAYNAME(STR_TO_DATE(CONCAT(YEAR(NOW()),'-',
								  MONTH(birthday_at),'-',
                                  DAY(birthday_at)), '%Y-%m-%d')) as DAYOFWEEK, COUNT(*)
FROM users
GROUP BY DAYOFWEEK;
  
-- 3. Подсчитайте произведение чисел в столбце таблицы.
  
DROP TABLE IF EXISTS sometab;
CREATE TABLE sometab (
  id SERIAL PRIMARY KEY,
  value INT
);

INSERT INTO sometab (value) VALUES
	(1),
    (2),
    (3),
    (4),
    (5),
    (10),
    (5),
    (4),
    (4);
    
SELECT value FROM sometab;

SELECT ROUND(EXP(SUM(LN(value)))) FROM sometab;
  