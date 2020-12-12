USE vk;

-- 2. Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, который больше
-- всех общался с нашим пользователм.

-- Узнал пользователей с самым большим количеством друзей
-- id: 26, 72, 42, 39, 15, 57, 12, 17, 10, 11
SELECT 
	id,
    firstname,
    lastname,
    (SELECT COUNT(*) FROM friend_requests 
     WHERE (status = 1) AND (from_users_id = users.id OR to_users_id = users.id))
		AS friend_number
FROM users
ORDER BY friend_number DESC
LIMIT 10;

-- Взял пользователя - id = 42
SET @id = 42;

-- Получил список id друзей
SELECT IF(from_users_id = @id, to_users_id, from_users_id) AS friends
FROM friend_requests 
WHERE (status = 1) AND (from_users_id = @id OR to_users_id = @id);

-- Получил список id пользователей с которыми переписывался выбранный пользователь
SELECT IF(from_users_id = @id, to_users_id, from_users_id) AS interlocators
FROM messages 
WHERE from_users_id = @id OR to_users_id = @id;

-- Список друзей, выбранного пользователя, которые с ним переписывались
SELECT CONCAT(firstname, ' ', lastname) AS 'user name'
FROM users
WHERE id IN(
	SELECT IF(from_users_id = @id, to_users_id, from_users_id) 
	FROM friend_requests 
	WHERE (status = 1) AND (from_users_id = @id OR to_users_id = @id))
AND
	id IN(
    SELECT IF(from_users_id = @id, to_users_id, from_users_id) AS interlocators
	FROM messages 
	WHERE from_users_id = @id OR to_users_id = @id
    );

-- Список пользователей с указанием количества собеедников из числа тех с кем есть
-- запросы на добавление в друзья (без учета статуса запроса)
SELECT id,
       CONCAT(firstname, ' ', lastname) AS 'name',
       (SELECT COUNT(*)
		FROM users
		WHERE id IN(SELECT IF(from_users_id = main_users.id, to_users_id, from_users_id) 
					FROM friend_requests 
					WHERE  (from_users_id = main_users.id OR to_users_id = main_users.id))
		AND
			id IN(SELECT IF(from_users_id = main_users.id, to_users_id, from_users_id) AS interlocators
			      FROM messages 
	              WHERE from_users_id = main_users.id OR to_users_id = main_users.id)
		) AS friend_message
FROM users AS main_users
ORDER BY friend_message DESC;

-- РЕЗУЛЬТИРУЮЩИЙ ЗАПРОС ПО ВТОРОМУ ЗАДАНИЮ
SELECT 
	CONCAT(firstname, ' ', lastname) AS 'user name',
    (SELECT COUNT(*) 
     FROM messages 
     WHERE 
		(from_users_id = users.id AND to_users_id = @id) 
        OR 
        (from_users_id = @id AND to_users_id = users.id)) AS messages_count
FROM 
	users
WHERE id IN(
	SELECT IF(from_users_id = @id, to_users_id, from_users_id) 
	FROM friend_requests 
	WHERE (status = 1) AND (from_users_id = @id OR to_users_id = @id))
HAVING messages_count > 0
ORDER BY 
	messages_count  DESC
LIMIT 1;