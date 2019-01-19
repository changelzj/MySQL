
# 插入 修改 删除

-- 支持一次性插入多行，支持子查询
INSERT INTO beauty(id,`name`,sex,borndate,phone,photo,boyfriend_id) 
VALUES (13, 'fbb', '女', '1997-01-01', '', NULL, 2);

-- 多行
INSERT INTO beauty(id,`name`,sex,borndate,phone,photo,boyfriend_id) 
VALUES 
(17, '杨紫', '女', '1997-01-01', '', NULL, 2),
(18, '蒋欣', '女', '1997-01-01', '', NULL, 2);

-- 子查询
INSERT INTO beauty(id, `name`, phone)
SELECT 26, "赵丽颖", "454" ;


-- 不支持一次插入多行
INSERT INTO beauty 
SET 
	id = 14,
	`name` = '刘涛',
	phone = '135'

	-- 修改多表记录

UPDATE boys boy
INNER JOIN beauty bea ON bea.boyfriend_id = boy.id
SET bea.phone = "12344555"
WHERE boy.id = 1


UPDATE beauty 
LEFT JOIN boys ON boys.id = beauty.boyfriend_id
SET beauty.phone = "cn666"
WHERE beauty.boyfriend_id is NULL

-- 删除，有返回值，自增长从上个记录开始，支持事务回滚
DELETE FROM beauty WHERE id = 27

-- 删谁delete后面就写谁
DELETE beauty
FROM beauty INNER JOIN boys ON beauty.boyfriend_id = boys.id
WHERE boys.id = 1

DELETE beauty, boys
FROM beauty INNER JOIN boys ON beauty.boyfriend_id = boys.id
WHERE boys.id = 3

-- 清空整个表,没有返回值，自增长从1开始，不支持事务回滚
TRUNCATE TABLE beautyy
