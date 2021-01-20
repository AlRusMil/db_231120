-- 2 Создать SQL-запрос, который помещает в таблицу users миллион строк.

USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- 1 вариант
DELIMITER //
DROP PROCEDURE IF EXISTS user_inserting//
CREATE PROCEDURE user_inserting (IN numb INT)
BEGIN
	DECLARE i INT;
	SET i = 0;
    WHILE i < numb DO
		 INSERT INTO users (name, birthday_at) VALUES
			(FLOOR(RAND() * 10000), DATE(NOW()) - INTERVAL FLOOR(RAND() * 10000) DAY);
		SET i = i + 1;
    END WHILE;
END//
DELIMITER ;

-- keep-alive interval - 60000
-- read timeout interval - 30000

CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);
CALL user_inserting (100000);

SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM logs;

-- 2 вариант
CALL user_inserting (100);

SELECT COUNT(*) FROM users as us1, users as us2, users as us3;

INSERT INTO users (name, birthday_at)
	SELECT us1.name AS name, us2.birthday_at as birthday_at
	FROM users as us1, users as us2, users as us3;