-- 1.   Создайте таблицу logs типа Archive. 
-- Пусть при каждом создании записи в таблицах users, catalogs, products
-- в таблицу logs время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	create_at DATETIME NOT NULL,
    tab_name VARCHAR(10) NOT NULL,
    key_value BIGINT UNSIGNED NOT NULL,
    name_value VARCHAR(255) NOT NULL
) ENGINE=ARCHIVE;

DELIMITER //
DROP TRIGGER IF EXISTS log_users_insert//
CREATE TRIGGER log_users_insert AFTER INSERT ON shop.users
FOR EACH ROW
BEGIN
	INSERT INTO logs (create_at, tab_name, key_value, name_value)
    VALUES (CURRENT_TIMESTAMP, 'users', NEW.id, NEW.name);
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS log_catalogs_insert//
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON shop.catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (create_at, tab_name, key_value, name_value)
    VALUES (CURRENT_TIMESTAMP, 'catalogs', NEW.id, NEW.name);
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS log_products_insert//
CREATE TRIGGER log_products_insert AFTER INSERT ON shop.products
FOR EACH ROW
BEGIN
	INSERT INTO logs (create_at, tab_name, key_value, name_value)
    VALUES (CURRENT_TIMESTAMP, 'products', NEW.id, NEW.name);
END//
DELIMITER ;

INSERT INTO users (name, birthday_at) VALUES
  ('Михаил', '1991-10-05'),  
  ('Никита', '1984-12-12');

INSERT INTO users (name, birthday_at) VALUES
  ('Алексей', '1989-05-20');
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i7-9100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 17890.00, 1),
  ('Intel Core i7-7500', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 22700.00, 1);
  
INSERT INTO products
	(name, description, price, catalog_id)
VALUES
  ('AMD FXX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4720.00, 1),
  ('AMD FX-822320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 9120.00, 1);
  
INSERT INTO catalogs VALUES
  (NULL, 'Блок питания');
  
INSERT INTO catalogs VALUES
  (NULL, 'Системный блок');
  
INSERT INTO products
	(name, description, price, catalog_id)
VALUES
	('Acer Nitro N50-610', 'Системный блок Acer.', 81990.00, 7);
  
  SELECT * FROM users;
  SELECT * FROM catalogs;
  SELECT * FROM products;
  SELECT * FROM logs;