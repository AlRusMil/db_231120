redis-cli

SET ivan1922@mail.ru Ivan.Ivanov
SET pp@gmail.com Petr.Petrov
SET greatkate@yahoo.com Kate.Kozlova
SET denchikkkk@hotmail.com Denis.Pavlov 
SET petyapetya@hotmail.com Petya.Petrov

GET ivan1922@mail.ru
GET greatkate@yahoo.com

KEYS petya*
GET petyapetya@hotmail.com

GET somebody@somewhere.net

SELECT 1

SADD Igor.Malkov igmal@mail.ru

SADD Pavel.Petrov ppetrov@gmail.com
SADD Pavel.Petrov pavelp111@yahoo.cpom

SADD Ivan.Ivanov ii@rambler.ru iviv@ya.ru
SADD Ivan.Ivanov vanya@hotmail.com
SADD Ivan.Ivanov iviv@ya.ru

SMEMBERS Igor.Malkov

KEYS Pavel*
SMEMBERS Pavel.Petrov

KEYS Ivan*
TYPE Ivan.Ivanov
SISMEMBER Ivan.Ivanov ii@rambler.ru
SISMEMBER Ivan.Ivanov iiii@rambler.ru
SISMEMBER Ivan.Ivanov vanya@hotmail.com
SMEMBERS Ivan.Ivanov