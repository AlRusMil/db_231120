use shop

db.catalogs.insert({"name": ["процессор", "материнская плата", "видеокарта", "жесткий диск", "оперативная память"]})

db.products.insert({"name": "Intel Core i3-8100", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
					"price": 7890.00, "catalog": "процессор", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "Intel Core i5-7400", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
					"price": 12700.00, "catalog": "процессор", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "AMD FX-8320E", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
					"price": 4780.00, "catalog": "процессор", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "AMD FX-8320", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
					"price": 7120.00, "catalog": "процессор", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "ASUS ROG MAXIMUS X HERO", "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
					"price": 19310.00, "catalog": "материнская плата", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "Gigabyte H310M S2H", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
					"price": 4790.00, "catalog": "материнская плата", "created_at": new Date(), "updated_at": new Date()})
db.products.insert({"name": "MSI B250M GAMING PRO", "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX",
					"price": 5060.00, "catalog": "материнская плата", "created_at": new Date(), "updated_at": new Date()})
                    
db
show collections
db.catalogs.find().pretty()
db.products.count()
db.products.findOne()
db.products.find({catalog: "материнская плата"})
db.products.find({"name": /ASUS/})
db.products.find({price: {$gt: 16000.00}})
db.products.find({created_at: {$lt: ISODate("2021-01-19")}})
db.products.find({created_at: {$gt: ISODate("2021-01-19")}})
