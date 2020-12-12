USE vk;

-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные
-- корректировки и/или улучшения.

-- Количество медиа у каждого пользователя
-- Добавил имя пользователя для наглядности
SELECT
	users_id,
    (SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE id = media.users_id)
		AS name,
    COUNT(*) AS media_count
FROM media
GROUP BY users_id
ORDER BY media_count DESC;

-- Медиа друзей пользователя (id = 7)
-- Заменил два условия одним с использованием IF
SELECT * 
FROM media
WHERE
	users_id IN (SELECT IF(from_users_id = 7, to_users_id, from_users_id) 
				 FROM friend_requests WHERE (status = 1) 
                 AND (from_users_id = 7 OR to_users_id = 7));

