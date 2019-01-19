
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
