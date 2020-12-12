USE vk;

-- Задание №1 (см. файл Task1.sql)
-- Особо идей не появилось к тому, что было в файле из вебинара.
-- Немного изменил пару запросов.

-- Задание №2

-- УТОЧНЕНИЕ!!!
-- В БД нет пользователей, у которых есть друзья, с которыми они переписывались.
-- Выбрал пользователя с id = 42, так как, если убрать условие того, что должны быть друзья,
-- то есть мы ищем не друзей (убрать проверку status = 1), а тех к кому или от кого были запросы 
-- на добавление в друзья, то найдется такой собеседник (см. предпоследний запрос в Task2.sql).

SET @id = 42;
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

-- Задание №3
-- УТОЧНЕНИЕ!!!
-- Решил отобрать самых молодых пользователей, но старше 14 лет (для "чистоты эксперимента" :) )
SELECT id, 
	   CONCAT(firstname, ' ', lastname) AS 'name',
	   (SELECT COUNT(*) FROM likes 
	    WHERE messages_id IN(SELECT id FROM messages WHERE from_users_id = users.id)) +
       (SELECT COUNT(*) FROM likes 
        WHERE media_id in (SELECT id FROM media WHERE users_id = users.id)) +
       (SELECT COUNT(*) FROM likes 
        WHERE posts_id in (SELECT id FROM posts WHERE users_id = users.id))
		AS recieved_likes
FROM users
WHERE (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE users_id = users.id) > 14
ORDER BY (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE users_id = users.id)
LIMIT 10;

-- Задание №4
SELECT 
    IF((SELECT gender FROM profiles WHERE profiles.users_id = likes.users_id) = 'm', 
        'Мужской', 'Женский') 
			AS gender
FROM 
	likes
GROUP BY
	gender
ORDER BY
	COUNT(*) DESC
LIMIT 1;

-- Задание №5
-- Не стал отдельно проверять администраторов в группе, так как по логике, если пользователь
-- является администратором, то он автоматически состоит в группе.
SELECT id,
	   CONCAT(firstname, ' ', lastname) AS 'name',
       -- (SELECT COUNT(*) FROM communities WHERE admin_id = users.id) +
       (SELECT COUNT(*) FROM friend_requests WHERE from_users_id = users.id) +
       (SELECT COUNT(*) FROM likes WHERE users_id = users.id) +
       (SELECT COUNT(*) FROM media WHERE users_id = users.id) +
       (SELECT COUNT(*) FROM messages WHERE from_users_id = users.id) +
       (SELECT COUNT(*) FROM posts WHERE users_id = users.id) +
       (SELECT COUNT(*) FROM users_communities WHERE users_id = users.id)
			AS activity
FROM users
ORDER BY activity
LIMIT 10;