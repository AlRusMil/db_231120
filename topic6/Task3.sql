-- 3. Подсчитать количество лайков, которые получили 10 самых
-- молодых пользователей

-- Решил отобрать самых молодых пользователей, но старше 14 лет (для "чистоты эксперимента" :) )
SELECT id, 
	   CONCAT(firstname, ' ', lastname) AS 'name',
	   (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE users_id = users.id)
		AS age
FROM users
WHERE (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE users_id = users.id) > 14
ORDER BY age
LIMIT 10;

-- РЕЗУЛЬТИРУЮЩИЙ ЗАПРОС ПО ТРЕТЬЕМУ ЗАДАНИЮ
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
