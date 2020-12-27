USE shop;

-- 1 В базе данных shop и sample присутствуют одни и те же таблицы,
-- учебной базы данных. Переместите запись id = 1 из таблицы 
-- shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users (id, name, birthday_at, created_at, updated_at)
	SELECT * 
	FROM shop.users
	WHERE id = 1; 

DELETE FROM shop.users
WHERE id = 1;

COMMIT;

-- 2 Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW prod_info AS
SELECT pr.name AS product, ct.name AS catalog 
FROM products AS pr
LEFT JOIN catalogs AS ct
ON pr.catalog_id = ct.id;

SELECT * FROM prod_info;

SHOW TABLES;

-- 3 Пусть имеется таблица с календарным полем created_at. В ней размещены
-- разряженные календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16'
-- и '2018-08-17'. Составьте запрос, который выводит полный список дат за август, выставляя в
-- соседнем поле значение 1, если дата присутствует в исходной таблице и 0, если она отсутствует.

DELIMITER //
DROP PROCEDURE IF EXISTS table_filling//
CREATE PROCEDURE table_filling (first_date DATE)
BEGIN
    DECLARE curr_date DATETIME;
    
    SET curr_date = first_date;
    REPEAT
		INSERT INTO date_status (date) VALUES (curr_date);
		SET curr_date = ADDDATE(curr_date, 1);
    UNTIL curr_date > LAST_DAY(first_date) 
    END REPEAT;
END//
DELIMITER ;

DROP TABLE IF EXISTS dates;
CREATE TEMPORARY TABLE dates (created_at DATE);
INSERT INTO dates VALUES
	('2018-08-01'),
    ('2018-08-04'),
    ('2018-08-16'),
    ('2018-08-17');

DROP TABLE IF EXISTS date_status;
CREATE TEMPORARY TABLE date_status (date DATE UNIQUE);
CALL table_filling('2018-08-01');

PREPARE date_status_query FROM
'SELECT ds.date, IF(d.created_at IS NOT NULL, 1, 0) AS status
FROM date_status AS ds LEFT JOIN dates AS d
ON ds.date = d.created_at;';
EXECUTE date_status_query;

-- UPDATE date_status
-- SET status = 1
-- WHERE date IN (SELECT created_at FROM dates)
-- LIMIT 31;

SELECT * FROM dates;
SELECT * FROM date_status;
DROP TABLE dates;
DROP TABLE date_status;

-- 4 Пусть имеется любая таблица с календарным полем created_at. Создайте
-- запрос, который удаляет устаревшие записи из таблицы, оставляя только 5
-- самых свежей записей.

DROP TABLE IF EXISTS all_dates;
CREATE TABLE all_dates (created_at DATE);

INSERT INTO all_dates VALUES
	('2018-04-01'),
    ('2018-03-04'),
    ('2018-02-16'),
    ('2018-12-17'),
    ('2018-09-20'),
    ('2018-09-22'),
    ('2018-10-01'),
    ('2018-11-22'),
    ('2018-06-12'),
    ('2018-01-11');
    
CREATE OR REPLACE VIEW fresh_dates AS
SELECT * FROM all_dates
ORDER BY created_at DESC
LIMIT 5;

DELETE FROM all_dates
WHERE created_at NOT IN (SELECT * FROM fresh_dates)
LIMIT 100;

SELECT * FROM all_dates;

DROP VIEW fresh_dates;
DROP TABLE all_dates;