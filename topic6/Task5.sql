-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании
-- социальной сети.

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