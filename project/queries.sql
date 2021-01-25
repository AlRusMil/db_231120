USE mydb;

-- ПРОСТЫЕ ЗАПРОСЫ
SELECT * FROM Positions;
SELECT * FROM Employees;
SELECT * FROM Services;
SELECT * FROM Admissions;
SELECT * FROM Clients;
SELECT * FROM Appeals;
SELECT * FROM Orders;
SELECT * FROM Nomenclature;
SELECT * FROM Requests;
SELECT * FROM RequestDetails;
SELECT * FROM Equipments;
SELECT * FROM MedMaterials;
SELECT * FROM ConsumptionRates;

SELECT COUNT(*) FROM Clients;

SELECT `Name`, `Duration(days)`
FROM Services
WHERE Cost > 1600.00;

SELECT CONCAT(`Surname`, ' ', `Name`, ' ', `LastName`) AS FIO, Phone
FROM Clients
WHERE JSON_EXTRACT(`Document`, '$.name') = 'birth certification';

SELECT CONCAT(`Surname`, ' ', `Name`, ' ', `LastName`) AS FIO, JSON_EXTRACT(`Document`, '$.seria') AS seria, JSON_EXTRACT(`Document`, '$.number') AS `number` 
FROM Clients
WHERE JSON_EXTRACT(`Document`, '$.name')="military certificate";

-- ЗАПРОС С ПОДЗАПРОСОМ, который выводит информацию о сотрудниках, у которых есть невыполненные заказы (Orders)
SELECT CONCAT(`Surname`, ' ', `Name`, ' ', `LastName`) AS FIO, Experience
FROM Employees
WHERE id_Employee IN (SELECT DISTINCT(Employee_id) 
					  FROM Orders 
                      WHERE ExecutionStatus=0);

-- ЗАПРОС С ПОДЗАПРОСОМ, который выводит ФИО сотрудников, а также имеющиеся у них допуска.
SELECT 
	(SELECT CONCAT(`Surname`, ' ', `Name`, ' ', `LastName`) FROM Employees AS em WHERE em.id_Employee = ord.Employee_id) AS FIO,
    (SELECT `Name` FROM Services AS se WHERE se.id_Service = ord.Service_id) AS `Service`,
    Begin_at
FROM Admissions as ord
ORDER BY FIO, Begin_at;

-- ЗАПРОС С ГРУППИРОВКОЙ с выводом информации о том, сколько сотрудников работает на должностях
SELECT pos.Name AS `Name`, ANY_VALUE(pos.Salary) AS Salary, COUNT(em.id_Employee) AS `Count`
FROM Positions AS pos JOIN Employees AS em ON pos.id_Position = em.Position_id
GROUP BY `Name`
ORDER BY `Count` DESC;

-- ЗАПРОС С ГРУППИРОВКОЙ и Having'ом, выводящий информацию об исполненных заказах с общей суммой свыше 1000000
SELECT re.id_Request AS `Request`, SUM(rd.Count * rd.UnitCost) AS `TotalSum`
FROM Requests AS re JOIN RequestDetails AS rd ON re.id_Request = rd.Request_id
WHERE re.Status = 'executed'
GROUP BY `Request`
HAVING `TotalSum` > 1000000;

-- ЗАПРОС С ИСПОЛЬЗОВАНИЕМ JOIN с выводом  иформации о предметах, 
-- заказ на которые отправлен, но еще не выполнен
SELECT nom.Name, nom.Type, rd.Count
FROM RequestDetails AS rd JOIN Nomenclature AS nom ON rd.Nomenclature_id = nom.id_Nomenclature
JOIN Requests AS re ON rd.Request_id = re.id_Request
WHERE re.Status = 'sent';

-- ЗАПРОС С ИСПОЛЬЗОВАНИЕМ JOIN, который выводит информацию о клиентах, 
-- а также о количестве сделанных ими заказов и общей суммой, ими потраченной.
-- При этом сумма заказанных, но неоплаченных услуг не учитывается.
SELECT CONCAT(cl.Surname, ' ', cl.Name, ' ', cl.LastName) AS FIO, ANY_VALUE(Phone) AS Phone, SUM(se.Cost) AS TotalSum
FROM Clients AS cl  JOIN Appeals AS ap ON cl.id_Client = ap.Client_id
JOIN Orders AS ord ON ap.id_Appeal = ord.Appeal_id
JOIN Services AS se ON ord.Service_id = se.id_Service
WHERE ap.Status <> 'booking'
GROUP BY FIO
ORDER BY TotalSum DESC;

-- ПРЕДСТАВЛЕНИЕ, выводящее информацию о врачах и имеющихся у них допусках.
CREATE OR REPLACE
VIEW view_AdmissionInfo
AS
SELECT CONCAT(em.Surname, ' ', em.Name, ' ', em.LastName) AS FIO, se.Name AS Service
FROM Employees AS em JOIN Admissions AS ad ON em.id_Employee = ad.Employee_id
LEFT JOIN Services AS se ON ad.Service_id = se.id_Service
ORDER BY FIO;

SELECT * FROM view_AdmissionInfo;

-- ПРЕДСТАВЛЕНИЕ, выводящее информацию о совершеннолетних клиентах, 
-- средняя стоимость заказов которых на оказание медицинских услуг превышает 5000.00.
CREATE OR REPLACE
VIEW view_avgcost
AS
SELECT `client`, ANY_VALUE(ClientBirth) AS age, ROUND(AVG(totalcost), 2) AS avgcost
FROM(
	SELECT ap.id_Appeal AS appeal, CONCAT(cl.Surname, ' ', cl.Name, ' ', cl.LastName) AS `client`, cl.DateBirth AS ClientBirth, 
		   CONCAT(em.Surname, ' ', em.Name, ' ', em.LastName) AS `doctor`, SUM(se.Cost) AS totalcost, ap.Status
	FROM Appeals AS ap JOIN Clients AS cl ON ap.Client_id = cl.id_Client
	JOIN Employees AS em ON ap.Employee_id = em.id_Employee
	JOIN Orders AS ord ON ap.id_Appeal = ord.Appeal_id
	JOIN Services AS se ON ord.Service_id = se.id_Service
	GROUP BY appeal
	ORDER BY appeal) AS tbl
WHERE (YEAR(CURRENT_DATE) - YEAR(ClientBirth) - (RIGHT(CURRENT_DATE, 5)<RIGHT(ClientBirth, 5))) >= 18
GROUP BY `client`
HAVING avgcost > 5000.00;

SELECT * FROM view_avgcost;

-- ТРИГГЕР, который проверяет наличие допуска у сотрудника при добавлении записи в Orders
DELIMITER //
DROP TRIGGER IF EXISTS check_employee_admission//
CREATE TRIGGER check_employee_admission BEFORE INSERT ON mydb.Orders
FOR EACH ROW
BEGIN
	IF ((SELECT COUNT(*) FROM Admissions AS ad WHERE ad.Employee_id = NEW.Employee_id AND ad.Service_id = NEW.Service_id) = 0)
	THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'INSERT CANCELLED! Employee doesn\'t have admission for this service!';
    END IF;
END//
DELIMITER ;

-- ПРОВЕРКА ПРАВИЛЬНОСТИ РАБОТЫ ТРИГГЕРА
-- Создали заказ
INSERT INTO Appeals
	(id_Appeal, Client_id, Employee_id, Created_at, Status)
VALUES
	(NULL, 12, 4, '2021-01-09', 'booking');
    
-- На основании заказов назначаем нужные процедуры
-- Сотрудник (4) имеет допуск к процедуре (1)
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 21, 1, 4, '2020-03-11', 0);

-- Сотрудник (17) не имеет допуск к процедуре (4)
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 21, 4, 17, '2020-03-15', 0);

-- Сотрудник (10) имеет допуск к процедуре (4)
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 21, 4, 10, '2020-03-17', 0);
    
-- В результате вставлено всего две записи, а не три
SELECT * FROM Orders WHERE Appeal_id = 21;

-- ТРИГГЕР, который проверяет возможность оформления заказа на оказание услуги (Orders).
-- Если какого-либо материала будет не хватать или отсутствовать в наличии, то вставка не производится.

DELIMITER //
DROP TRIGGER IF EXISTS check_medmaterials_availability//
CREATE TRIGGER check_medmaterials_availability BEFORE INSERT ON mydb.Orders
FOR EACH ROW
BEGIN
	DECLARE cur_nomenclature INT;
    DECLARE cur_count INT;
	DECLARE is_end INT DEFAULT 0;
   
	DECLARE curs CURSOR FOR
    SELECT Nomenclature_id AS `nomenclature`, `Count`
    FROM ConsumptionRates
    WHERE Service_id = NEW.Service_id;
    
     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET is_end = 1;
    
    OPEN curs;
    
    WHILE is_end = 0 DO
		FETCH curs INTO cur_nomenclature, cur_count;
        IF((SELECT COALESCE(SUM(`Count`), 0) FROM MedMaterials WHERE Nomenclature_id = cur_nomenclature) < cur_count)
        THEN 
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'INSERT CANCELLED! There is not enough med. materials!';
		END IF;
    END WHILE;
    
    CLOSE curs;
END//
DELIMITER ;

-- Для проверки берется Service_id = 4
-- Номенклатурные номера при этом будут браться 4, 7, 24
-- Для 4 нужно 1 единица
-- Для 7 нужно 2 единицы
-- Для 24 нужно 3 единицы

SELECT *
FROM ConsumptionRates
WHERE Service_id = 4;

SELECT Nomenclature_id, SUM(`Count`)
FROM MedMaterials
WHERE Nomenclature_id IN(4, 7, 24)
GROUP BY Nomenclature_id;

SELECT COALESCE(SUM(`Count`), 0)
FROM MedMaterials 
WHERE Nomenclature_id = 100;

-- Берем значение обращения равное 1 (Appeals) и даты в мае 2021 (чтобы в таблице сразу найти)
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 4, 10, '2021-05-01', 0);

-- Делаем количество материалов меньше необходимого.
-- Исходим из того, что материал встречается в таблице только 1 раз.
UPDATE MedMaterials
SET Count = 2
WHERE Nomenclature_id = 24;

INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 4, 10, '2021-05-02', 0);

-- Возвращаем исходное значение количества
UPDATE MedMaterials
SET Count = 100
WHERE Nomenclature_id = 24;

INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 4, 10, '2021-05-03', 0);

-- Удаляем материал из списка имеющихся в наличии
DELETE FROM MedMaterials
WHERE Nomenclature_id = 24;

INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 4, 10, '2021-05-04', 0);

-- Заново добавляем материал в список имеющихся
INSERT INTO MedMaterials
	(id_MedMaterials, Nomenclature_id, `Description`, Count, UnitCost)
VALUES
	(NULL, 24, NULL, 100, 90.00);
    
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 4, 10, '2021-05-05', 0);
    
-- В результате вставлено всего три записи, а не пять
SELECT * FROM Orders WHERE Appeal_id = 1 AND YEAR(DateExecution) = 2021 AND MONTH(DateExecution) = 5 ;

-- ХРАНИМАЯ ФУНКЦИЯ получает на вход номер обращения (Appeals) и 
-- возвращает стоимость всех заказов в рамках обращения.
DELIMITER //
DROP FUNCTION IF EXISTS fun_total_cost//
CREATE FUNCTION fun_total_cost (id_numb INT)
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
	RETURN (SELECT SUM(se.Cost)
    FROM Appeals AS ap JOIN Orders AS ord
    ON ap.id_Appeal = ord.Appeal_id
    JOIN Services AS se ON ord.Service_id = se.id_Service
    WHERE ap.id_Appeal = id_numb);
END//
DELIMITER ;

SELECT fun_total_cost(3);
SELECT fun_total_cost(13);

-- ХРАНИМАЯ ПРОЦЕДУРА, которая изменяет количество имеющегося материала.
-- На вход подается id имеющегося материала, количество, которое нужно вычесть.
-- В выходной параметр записывается наименование позиции согласно номенклатуре 
-- и текущее его количество.
-- Перед вычитанием проверяется достаточность имеющегося количества.
-- В случае, если после вычитания остается ноль имеющихся материалов, то позиция удаляется.
DELIMITER //
DROP PROCEDURE IF EXISTS proc_change_count//
CREATE PROCEDURE proc_change_count(IN id_medmat INT, IN subtract INT, OUT medmat_name VARCHAR(50), OUT new_count INT)
BEGIN
	DECLARE cur_count INT;
    SELECT `Count` FROM MedMaterials WHERE id_MedMaterials = id_medmat INTO cur_count;
	IF (COALESCE(cur_count, 0) < subtract)
    THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'UPDATE CANCELLED! There is not enough med. materials for subtracting!';
    END IF;
	
    IF (cur_count = subtract)
    THEN
		SELECT nom.Name 
		FROM MedMaterials AS mm JOIN Nomenclature AS nom 
		ON mm.Nomenclature_id = nom.id_Nomenclature
		WHERE id_MedMaterials = id_medmat
		INTO medmat_name;
		
        SET new_count = 0;
        
		DELETE FROM MedMaterials
        WHERE id_MedMaterials = id_medmat;
	ELSE
		UPDATE MedMaterials
		SET `Count` = cur_count - subtract
		WHERE id_MedMaterials = id_medmat;
    
		SELECT nom.Name, mm.`Count` 
		FROM MedMaterials AS mm JOIN Nomenclature AS nom 
		ON mm.Nomenclature_id = nom.id_Nomenclature
		WHERE id_MedMaterials = id_medmat
		INTO medmat_name, new_count;
	END IF;
END//
DELIMITER ;

SELECT id_MedMaterials, `Description`, `Count` FROM MedMaterials WHERE id_MedMaterials = 7;
CALL proc_change_count(7, 25, @medmat_name, @new_count);
SELECT id_MedMaterials, `Description`, `Count` FROM MedMaterials WHERE id_MedMaterials = 7;
SELECT @medmat_name, @new_count;
CALL proc_change_count(7, 125, @medmat_name, @new_count);
SELECT id_MedMaterials, `Description`, `Count` FROM MedMaterials WHERE id_MedMaterials = 7;
CALL proc_change_count(7, 75, @medmat_name, @new_count);
SELECT * FROM MedMaterials WHERE id_MedMaterials = 7;
SELECT @medmat_name, @new_count;