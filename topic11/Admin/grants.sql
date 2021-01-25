USE shop;

SELECT * FROM catalogs;

-- 1. Создайте двух пользователей, которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop_all - любые операции в пределах базы данных shop.

SELECT `User`, `Host` FROM mysql.user
WHERE `User` LIKE '%shop%';

DROP USER IF EXISTS shop_read;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'passr';
SHOW GRANTS FOR shop_read;

DROP USER IF EXISTS shop_all;
CREATE USER shop_all IDENTIFIED WITH sha256_password BY 'passa';
SHOW GRANTS FOR shop_all;

GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop_all;
GRANT GRANT OPTION ON shop.* TO shop_all;
FLUSH PRIVILEGES;

DROP USER IF EXISTS user_for_shop;
CREATE USER user_for_shop;

-- 2. Пусть имеется таблица accounts, содержащая три столбца id, name, password,
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
-- username таблицы accounts, предоставляющий доступ к столбцам id и name.
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
-- однако, мог бы извлекать записи из представления username.

DROP TABLE IF EXISTS `shop`.`accounts` ;
CREATE TABLE IF NOT EXISTS `shop`.`accounts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `accounts`
	(`id`, `Name`, `Password`)
VALUES
	(NULL, 'Dima', '12345'),
    (NULL, 'Ivan', '23456'),
    (NULL, 'Alex', '34567'),
    (NULL, 'Sergey', '45678'),
	(NULL, 'Vitaly', '56789');
    
CREATE OR REPLACE
VIEW username
AS
SELECT `id`, `Name`
FROM `accounts`;

SELECT * FROM username;

DROP USER IF EXISTS user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY 'passur';
SHOW GRANTS FOR user_read;

GRANT SELECT ON shop.username TO user_read;