-- 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
-- текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
-- 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 - "Добрый вечер",
-- с 00:00 до 06:00 - "Доброй ночи".

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello (value TIME)
RETURNS VARCHAR(30) DETERMINISTIC
BEGIN
	DECLARE time_value, frase VARCHAR(30);
    SET time_value = COALESCE(value, TIME(NOW()));
    SET frase = '';
    IF ((time_value >= '06:00') AND (time_value < '12:00'))
		THEN SET frase = 'Доброе утро';
	ELSEIF ((time_value >= '12:00') AND (time_value < '18:00'))
		THEN SET frase = 'Добрый день';
	ELSEIF ((time_value >= '18:00') AND (time_value <= '23:59:59'))
		THEN SET frase = 'Добрый вечер';
	ELSEIF ((time_value >= '00:00') AND (time_value < '06:00'))
		THEN SET frase = 'Доброй ночи';
	END IF;
    RETURN frase;
END//
DELIMITER ;

SELECT hello('09:00');
SELECT hello('13:00');
SELECT hello('19:00');
SELECT hello('00:01');
SELECT hello(NULL);

-- 2 В таблице products есть два текстовых поля: name с названием товара и description с его
-- описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля 
-- принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтечь того, 
-- чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям 
-- NULL-значение необходимо отменить операцию.

DELIMITER //
DROP TRIGGER IF EXISTS check_product_insert//
CREATE TRIGGER check_product_insert BEFORE INSERT ON shop.products
FOR EACH ROW
BEGIN
	IF ((NEW.name IS NULL) AND (NEW.description IS NULL))
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT CANCELLED!';
    END IF;
END//
DELIMITER ;

DELETE FROM shop.products
LIMIT 100;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1);

INSERT INTO products
	(name, description, price, catalog_id)
VALUES
  (NULL, 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2);

INSERT INTO products
  (description, price, catalog_id)
VALUES
  ('Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1);

INSERT INTO products
  (name, price, catalog_id)
VALUES
  ('AMD FX-8320E', 4780.00, 1);

INSERT INTO products
	(name, description, price, catalog_id)
VALUES 
  (NULL, NULL, 5060.00, 2);

INSERT INTO products
	(price, catalog_id)
VALUES
   (19310.00, 2);

SELECT * FROM shop.products;

-- 3 Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме
-- двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //
DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI (num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 2;
	DECLARE num1 INT DEFAULT 0;
    DECLARE num2 INT DEFAULT 1; 
    DECLARE result INT;
    
    IF (num = 0)
		THEN SET result = 0;
	ELSEIF (num = 1)
		THEN SET result = 1;
	ELSE
		WHILE i <= num DO
            SET result = num1 + num2;
            SET num1 = num2;
            SET num2 = result;
            SET i = i + 1;
        END WHILE;
    END IF;
    
    RETURN result;
END//
DELIMITER ;

SELECT FIBONACCI(0);
SELECT FIBONACCI(1);
SELECT FIBONACCI(5);
SELECT FIBONACCI(10);
SELECT FIBONACCI(17);