-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщин?
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