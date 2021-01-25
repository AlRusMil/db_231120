USE mydb;

DELETE FROM Positions LIMIT 1000;
ALTER TABLE Positions AUTO_INCREMENT=0;
INSERT INTO Positions
	(id_Position, Name, MedEducation, MinimumExperience, Salary) 
VALUES
	(NULL, 'Administrator', 0, 3, 120000.00),
	(NULL, 'Chief medical officer', 1, 5, 150000.00),
    (NULL, 'Deputy', 1, 5, 130000.00),
	(NULL, 'Therapist', 1, 5, 80000.00),
    (NULL, 'Diagnostic doctor', 1, 3, 100000.00),
    (NULL, 'Paramedic', 0, 0, 30000.00),
    (NULL, 'Nurse', 0, 0, 20000.00),
    (NULL, 'Cleaner', 0, 0, 15000.00);
   
DELETE FROM Employees LIMIT 1000;
ALTER TABLE Employees AUTO_INCREMENT=0;
INSERT INTO Employees
	(id_Employee, Surname, Name, LastName, Experience, Begin_at, Position_id, EducationInfo)
VALUES
	(NULL, 'Bibov', 'Maxim', 'Maximovich', 10, '2012-03-03', 1, NULL),
    (NULL, 'Diboev', 'Artur', 'Vladimirovich', 10, '2014-11-23', 2, '{"university": "MGMSU", "type": "specialist", "specialty": "cool medic"}'),
    (NULL, 'Klomov', 'Artem', 'Igorevich', 5, '2015-10-10', 3, '{"university": "MGMSU", "type": "specialist", "specialty": "medic medic"}'),
    (NULL, 'Kulov', "Nikolay", "Dmitrievich", 4, '2012-03-17', 4, '{"university": "KGMU", "type": "bachelor", "specialty": "some medic"}'),
    (NULL, 'Timoev', "Igor", "Viktorovich", 2, '2014-03-17', 4, '{"university": "KGMU", "type": "bachelor", "specialty": "some medic"}'),
    (NULL, 'Lordov', 'Mikhail', 'Mikhalovich', 5, '2015-02-14', 4, '{"university": "RNIMU", "type": "bachelor", "specialty": "some medic"}'),
    (NULL, 'Kritov', 'Konstantin', 'Maximovich', 10, '2017-09-24', 5, '{"university": "RNIMU", "type": "bachelor", "specialty": "some medic"}'),
    (NULL, 'Kutepov', 'Anton', 'Antonovich', 7, '2019-03-23', 5, '{"university": "RNIMU", "type": "bachelor", "specialty": "some medic"}'),
    (NULL, 'Kruglov', 'Igor', 'Mikhailovich', 4, '2018-04-25', 6, '{"university": "RNIMU", "type": "bachelor", "education form": "extramural studies", "specialty": "some medic"}'),
    (NULL, 'Kimov', 'Timur', 'Artemovich', 0, '2019-05-23', 6, NULL),
    (NULL, 'Mirzoev', 'Akim', 'Akimovich', 0, '2018-04-23', 6, NULL),
    (NULL, 'Gimroeva', 'Nina', 'Igorevna', 2, '2019-06-29', 7, NULL),
    (NULL, 'Tekueva', 'Kate', 'Mikhailovna', 0, '2019-08-30', 7, NULL),
    (NULL, 'Ivanova', 'Victoria', 'Markovna', 1, '2019-06-29', 7, NULL),
    (NULL, 'Kritova', 'Liza', 'Artemovna', 0, '2016-06-29', 7, NULL),
    (NULL, 'Artemova', 'Ann', 'Nikolaevna', 0, '2012-07-15', 8, NULL),
    (NULL, 'Sikova', 'Tamara', 'Petrovna', 0, '2013-09-20', 8, NULL),
    (NULL, 'Galova', 'Galina', 'Olegovna', 0, '2017-08-12', 8, NULL),
    (NULL, 'Tihomirov', "Vitaly", "Viktorovich", 7, '2017-03-17', 4, '{"university": "KGMU", "type": "specialist", "specialty": "mega medic"}'),
    (NULL, 'Runin', "Victor", "Viktorovich", 4, '2014-03-17', 4, '{"university": "KGMU", "type": "bachelor", "specialty": "some normal medic"}'),
    (NULL, 'Timohin', "Oleg", "Olegovich", 5, '2014-03-17', 4, '{"university": "KGMU", "type": "specialist", "specialty": "some usual medic"}');
  
DELETE FROM Services LIMIT 1000;
ALTER TABLE Services AUTO_INCREMENT=0;
INSERT INTO Services
	(id_Service, `Name`, Cost, `Duration(days)`, `Description`)
VALUES
	(NULL, 'Консультация терапевта', 1000.00, 2, 'Некоторое описание'),
    (NULL, 'Общий анализ крови', 1500.00, 1, NULL),
    (NULL, 'Общий анализ мочи', 1200.00, 1, NULL),
    (NULL, 'Кровь на антитела', 2500.00, 3, 'Некоторое описание анализа крови'),
    (NULL, 'Гормональный анализ крови', 1300.00, 1, NULL),
    (NULL, 'УЗИ сердца', 3000.00, 2, NULL),
    (NULL, 'УЗИ нижних вен', 2000.00, 2, NULL),
    (NULL, 'КТ органов грудной полости', 4000.00, 2, 'Некоторое описание КТ'),
    (NULL, 'МРТ головного мозка', 5000.00, 2, 'Некоторое описание для МРТ'),
    (NULL, 'УЗИ органов брюшной полости', 2000.00, 3, 'Некоторое описание');

DELETE FROM Admissions LIMIT 1000;
ALTER TABLE Admissions AUTO_INCREMENT=0;
INSERT INTO Admissions
	(Employee_id, Service_id, Begin_at)
VALUES
	(4, 1, '2018-02-02'),
    (5, 1, '2019-03-04'),
    (6, 1, '2020-01-01'),
    (7, 6, '2019-02-03'),
    (7, 7, '2014-04-05'),
    (7, 10, '2016-01-01'),
    (8, 8, '2019-03-03'),
    (8, 9, '2017-02-02'),
    (9, 2,'2019-01-01'),
    (9, 3,'2019-01-01'),
    (10, 3,'2017-01-01'),
    (10, 4,'2018-01-01'),
    (10, 5,'2019-01-01'),
    (11, 2,'2016-01-01'),
    (11, 3,'2016-01-01'),
    (11, 4,'2016-01-01'),
	(11, 5,'2016-01-01'),
    (19, 1, '2018-01-03'),
    (20, 1, '2019-03-03'),
    (21, 1, '2013-06-06');
   
DELETE FROM Clients LIMIT 1000;
ALTER TABLE Clients AUTO_INCREMENT=0;
INSERT INTO Clients
	(id_Client, Surname, Name, LastName, DateBirth, Phone, OMS, Document)
VALUES
	(NULL, 'Ivanov', 'Ivan', 'Ivanovich', '1989-03-13', 79281234567, 1234567891234567, '{"name": "passport", "seria": "8123", "number": "123456"}'),
    (NULL, 'Philipov', 'Dmitriy', 'Alexeevich', '1978-04-23', 79657483940, 1304958473625345, '{"name": "passport", "seria": "4566", "number": "177756"}'),
    (NULL, 'Andreev', 'Andrei', 'Andreevich', '1988-04-05', 79881334337, 4589767891234567, '{"name": "passport", "seria": "7123", "number": "553456"}'),
    (NULL, 'Dumov', 'Mikhail', 'Vasilyevich', '1967-10-24', 79641276527, 1234567308744567, '{"name": "passport", "seria": "7723", "number": "989456"}'),
    (NULL, 'Krotov', 'Konstantin', 'Konstantinovich', '2005-03-12', 79871498567, 9384756009821145, '{"name": "birth certification", "seria": "II-ET", "number": "456798"}'),
    (NULL, 'Kugotov', 'Alex', 'Konstantinovich', '2008-03-22', 79882398567, 4576756059821145, '{"name": "birth certification", "seria": "IV-EE", "number": "493798"}'),
    (NULL, 'Kimov', 'Kim', 'Kimovich', '2000-02-02', 79381654547, 1029485761234567, '{"name": "passport", "seria": "3423", "number": "443456"}'),
    (NULL, 'Bergman', 'Roman', 'Romanovich', '1993-03-09', 79261434567, 5694567891234567, '{"name": "military certificate", "seria": "AA", "number": "345656"}'),
    (NULL, 'Litvinov', 'Igor', 'Igorevich', '1989-08-28', 79381234999, 3948767891234567, '{"name": "passport", "seria": "7777", "number": "444444"}'),
    (NULL, 'Ledov', 'Artem', 'Petrovich', '1980-09-12', 79883049512, 6664567891234567, '{"name": "passport", "seria": "1111", "number": "453322"}'),
    (NULL, 'Romanov', 'Evgeniy', 'Valerievich', '1990-03-03', 79883037592, 4343433123456709, JSON_OBJECT("name", "military certificate", "seria", "AB", "number", "980099")),
    (NULL, 'Petrov', 'Petr', 'Petrovich', '1975-05-16', 79644324567, 2345879076543764, '{"name": "passport", "seria": "7375", "number": "123456"}');

DELETE FROM Appeals LIMIT 1000;
ALTER TABLE Appeals AUTO_INCREMENT=0;
INSERT INTO Appeals
	(id_Appeal, Client_id, Employee_id, Created_at, Status)
VALUES
	(NULL, 1, 4, '2020-06-15', 'executed'),
    (NULL, 2, 4, '2020-07-12', 'executed'),
    (NULL, 3, 5, '2020-07-14', 'executed'),
    (NULL, 4, 6, '2020-07-28', 'executed'),
    (NULL, 5, 6, '2020-08-13', 'executed'),
    (NULL, 6, 20, '2020-08-17', 'executed'),
    (NULL, 7, 4, '2020-08-19', 'executed'),
    (NULL, 8, 5, '2020-08-24', 'executed'),
    (NULL, 9, 5, '2020-08-29', 'executed'),
    (NULL, 10, 4, '2020-09-09', 'processing'),
    (NULL, 11, 4, '2020-09-17', 'processing'),
    (NULL, 3, 6, '2020-09-20', 'processing'),
    (NULL, 3, 19, '2020-09-27', 'processing'),
    (NULL, 4, 20, '2020-10-15', 'processing'),
    (NULL, 6, 21, '2020-10-23', 'paid'),
    (NULL, 7, 21, '2020-10-31', 'booking'),
    (NULL, 2, 6, '2020-11-12', 'paid'),
    (NULL, 9, 6, '2020-11-30', 'paid'),
    (NULL, 8, 5, '2020-11-30', 'booking'),
    (NULL, 1, 4, '2020-12-03', 'booking');

DELETE FROM Orders LIMIT 1000;
ALTER TABLE Orders AUTO_INCREMENT=0;
INSERT INTO Orders
	(id_Order, Appeal_id, Service_id, Employee_id, DateExecution, ExecutionStatus)
VALUES
	(NULL, 1, 2, 9, '2020-06-16', 1),
    (NULL, 2, 2, 9, '2020-07-15', 1),
    (NULL, 3, 2, 11, '2020-07-19', 1),
    (NULL, 4, 3, 10, '2020-07-31', 1),
    (NULL, 5, 3, 10, '2020-08-13', 1),
    (NULL, 6, 4, 10, '2020-08-18', 1),
    (NULL, 6, 5, 11, '2020-08-20', 1),
    (NULL, 7, 5, 10, '2020-08-19', 1),
    (NULL, 7, 6, 7, '2020-08-21', 1),
    (NULL, 8, 8, 8, '2020-08-27', 1),
    (NULL, 9, 2, 11, '2020-09-02', 1),
    (NULL, 9, 3, 10, '2020-09-04', 1),
    (NULL, 9, 4, 11, '2020-09-04', 1),
	(NULL, 9, 5, 10, '2020-09-05', 1),
	(NULL, 10, 9, 8, '2020-12-30', 0),
    (NULL, 11, 10, 7, '2020-12-25', 0),
    (NULL, 12, 6, 7, '2020-12-27', 0),
    (NULL, 13, 4, 11, '2020-10-22', 1),
    (NULL, 13, 8, 8, '2020-11-13', 1),
    (NULL, 13, 2, 9, '2020-12-15', 0),
    (NULL, 13, 3, 11, '2020-12-23', 0),
    (NULL, 14, 6, 7, '2021-01-11', 0),
    (NULL, 15, 7, 7, '2021-01-23', 0),
    (NULL, 16, 9, 8, NULL, 0),
    (NULL, 16, 10, 7, NULL, 0),
    (NULL, 17, 1, 4, '2020-12-23', 0),
    (NULL, 18, 1, 5, '2020-12-25', 0),
    (NULL, 18, 2, 9, '2020-12-26', 0),
    (NULL, 18, 3, 9, '2021-01-15', 0),
    (NULL, 19, 9, 8, NULL, 0),
    (NULL, 20, 1, 21, NULL, 0),
    (NULL, 20, 5, 10, NULL, 0);

DELETE FROM Nomenclature LIMIT 1000;
ALTER TABLE Nomenclature AUTO_INCREMENT=0;
INSERT INTO Nomenclature
	(id_Nomenclature, `Name`, `Description`, `Type`)
VALUES
	(NULL, 'Компьютерный томограф', NULL, 'equipment'),
    (NULL, 'Аппарат МРТ', NULL, 'equipment'),
    (NULL, 'Аппарат УЗИ', NULL, 'equipment'),
    (NULL, 'Пробирка', 'Некоторое описание', 'consumable'),
    (NULL, 'Шприц 5мл', NULL, 'consumable'),
    (NULL, 'Шприц 10мл', NULL, 'consumable'),
    (NULL, 'Шприц 20мл', NULL, 'consumable'),
    (NULL, 'Физ. растовр', 'Раствор для капельниц в дополнение к действующим препаратам', 'medicine'),
    (NULL, 'Раствор глюкозы 5%', NULL, 'medicine'),
    (NULL, 'Лидокаин', 'Средство для анестезии', 'medicine'),
    (NULL, 'Спирт медицинский', NULL, 'consumable'),
    (NULL, 'Эфедрин', 'Препарат для обезболевания', 'medicine'),
    (NULL, 'Ксарелта', 'Кроверазжижающий препарат', 'medicine'),
    (NULL, 'Имодиум', 'Препарат при диареи', 'medicine'),
    (NULL, 'Омез', 'Препарат против гастрита', 'medicine'),
    (NULL, 'Арбидол', 'Противовирусный препарат', 'medicine'),
    (NULL, 'Кетарол', 'Обезболивающие средство', 'medicine'),
    (NULL, 'Йод', NULL, 'medicine'),
    (NULL, 'Бинт медицинский', NULL, 'consumable'),
    (NULL, 'Вата', NULL, 'consumable'),
    (NULL, 'Аскорбиновая кислота', NULL, 'medicine'),
    (NULL, 'Система', 'Система для капельницы', 'consumable'),
    (NULL, 'Реагент для инфекционных заболеваний', NULL, 'reagent'),
    (NULL, 'Реагент для гемотестов', NULL, 'reagent'),
    (NULL, 'Реагент для ПЦР', NULL, 'reagent');

DELETE FROM Requests LIMIT 1000;
ALTER TABLE Requests AUTO_INCREMENT=0;
INSERT INTO Requests
	(id_Request, DateOfOrder, DateOfExecution, Status)
VALUES
	(NULL, '2019-10-03', '2020-06-10', 'executed'),
    (NULL, '2020-10-30', '2021-02-12', 'sent'),
    (NULL, '2019-11-03', '2020-01-14', 'executed'),
    (NULL, '2018-09-16', '2020-03-14', 'executed'),
    (NULL, '2020-11-05', '2021-01-30', 'sent'),
    (NULL, '2020-12-24', '2021-03-15', 'preparation'),
    (NULL, '2020-12-28', '2021-06-20', 'preparation');

DELETE FROM RequestDetails LIMIT 1000;
ALTER TABLE RequestDetails AUTO_INCREMENT=0;
INSERT INTO RequestDetails
	(Request_id, Nomenclature_id, count, UnitCost)
VALUES
	(1, 1, 1, 2500000.00),
    (1, 3, 2, 500000.00),
    (3, 2, 1, 4000000.00),
    (4, 3, 1, 550000.00),
    (2, 8, 10, 50.00),
    (2, 10, 3, 550.00),
    (5, 4, 30, 60.00),
    (6, 5, 100, 10.00),
    (6, 6, 100, 10.00),
    (7, 9, 30, 40.00);

DELETE FROM Equipments LIMIT 1000;
ALTER TABLE Equipments AUTO_INCREMENT=0;
INSERT INTO Equipments
	(id_Equipment, Producer, SN, DateRelease, LifeTime, Cost, Request_id, Nomenclature_id)
VALUES
	(NULL, 'Dyson', '1234232', '2020-06-01', 5, 2500000.00, 1, 1),
    (NULL, 'BD', '34234234', '2020-03-23', 10, 4000000.00, 3, 2),
    (NULL, 'MedCorp', '23131242', '2019-12-30', 3, 500000.00, 1, 3),
    (NULL, 'MedCorp', '123333232', '2020-12-29', 3, 500000.00, 1, 3),
    (NULL, 'MedProf', '48767', '2021-05-24', 4, 550000.00, 4, 3);

DELETE FROM MedMaterials LIMIT 1000;
ALTER TABLE MedMaterials AUTO_INCREMENT=0;
INSERT INTO MedMaterials
	(id_MedMaterials, Nomenclature_id, `Description`, Count, UnitCost)
VALUES
	(NULL, 4, "Пробирки для взятия крови из вены. Содержит доп описание, например, фирма произволителя", 100, 10.00),
    (NULL, 4, "Пробирки для взятия крови из вены. Содержит доп описание, например, фирма произволителя", 50, 25.00),
    (NULL, 5, "Шприц 5мл. Альматек.", 80, 25.00),
    (NULL, 6, "Шприцы 10мл. Альмавит", 200, 30.00),
    (NULL, 8, "Физ раствор для проведения капельниц. Стандартного размера в пакетах", 200, 20.00),
    (NULL, 8, "Физ раствор для капельниц. В банках объемом 0,5л", 150, 30.00),
    (NULL, 9, "Глюкоза", 100, 10.00),
    (NULL, 10, "Лидокаин объемом 0,5л", 100, 50.00),
    (NULL, 11, "Спирт объемом 1л", 100, 500.00),
    (NULL, 11, "Спирт объемом 0,5л", 200, 270.00),
    (NULL, 12, "Дозировка 50мг", 50, 100.00),
    (NULL, 12, "Дозировка 25мг", 100, 60.00),
    (NULL, 13, "Дозировка 25 мг", 100, 1200.00),
    (NULL, 4, "Пробирки для взятия крови из вены. Содержит доп описание, например, фирма произволителя", 100, 10.00),
    (NULL, 14, NULL, 100, 350.00),
    (NULL, 15, "ПРотиводиарейного средство. Фирма Зиртек", 200, 350.00),
    (NULL, 16, "Арбидол обычный. Российский", 500, 110.00),
    (NULL, 16, "Арбидол усиленный", 300, 330.00),
    (NULL, 17, NULL, 200, 1110.00),
    (NULL, 18, NULL, 200, 210.00),
    (NULL, 19, NULL, 500, 20.00),
    (NULL, 20, NULL, 1000, 5.00),
    (NULL, 21, "Аскорбинка в таблетках для рассасывания", 200, 25.00),
    (NULL, 21, "Аскорбинка шипучая", 150, 30.00),
    (NULL, 22, NULL, 500, 50.00),
    (NULL, 23, NULL, 80, 70.00),
    (NULL, 24, NULL, 100, 90.00),
    (NULL, 23, NULL, 100, 75.00),
    (NULL, 25, NULL, 150, 85.00),
    (NULL, 17, "Английский", 50, 2150.00),
    (NULL, 25, NULL, 200, 90.00),
    (NULL, 7, 'Шприцы для инъекций', 20, 50.00);

DELETE FROM ConsumptionRates LIMIT 1000;
ALTER TABLE ConsumptionRates AUTO_INCREMENT=0;
INSERT INTO ConsumptionRates
	(Service_id, Nomenclature_id, Count)
VALUES
	(6, 3, 1),
    (7, 3, 1),
    (8, 1, 1),
    (9, 2, 1),
    (10, 3, 1),
    (2, 4, 3),
    (2, 6, 1),
    (4, 4, 1),
    (4, 7, 2),
    (4, 24, 3),
    (5, 4, 2),
    (5, 5, 1),
    (5, 24, 1);