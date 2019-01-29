# 函数

-- 和存储过程的区别：返回值，函数只能有一个返回，而且必须有返回

-- 存储过程适合批量插入，更新
-- 函数适合处理数据后，得到一个结果，适合查询

/* 基本语法
CREATE FUNCTION 名(参数列表) RETURNS 返回类型
BEGIN
  函数体
	(必须有return 语句)
	(函数体只有一句话，可以省略BEGIN END)
END


-- 调用函数
SELECT fun();
*/

delimiter $
CREATE FUNCTION fun1() RETURNS INT
BEGIN
	DECLARE count INT DEFAULT 0;
	
	SELECT COUNT(*) INTO count 
	FROM myemployees.employees;
	
	RETURN count;
END $

SELECT fun1();


-- 
CREATE FUNCTION getPriceFromId(empId INT) RETURNS DOUBLE
BEGIN
	DECLARE price DOUBLE DEFAULT 0.0;
	SELECT employees.price INTO price FROM employees WHERE employee_id = empId;
	RETURN price;
END

-- 查看函数
SHOW CREATE FUNCTION getPriceFromId

DROP FUNCTION getPriceFromId


-- 循环结构
/*
三种循环：
WHILE :

标签:WHILE 条件 DO
	循环体
END WHILE 标签;

LOOP:

标签: LOOP
	循环体;

	IF 退出条件 THEN
		LEAVE 标签; 
	END IF; 
	
END LOOP 标签;



	
REPEAT:

标签:REPEAT
	循环体
UNTIL 结束条件 END REPEAT 标签;



	
循环控制语句：

ITERATE(继续，结束本次继续下次)

LEAVE (break,跳出所在循环)


*/




delimiter $
CREATE PROCEDURE batch(num INT)
BEGIN 
	DECLARE i INT DEFAULT 1;
	WHILE i <= num DO
		INSERT INTO `user` (age, username, `password`) VALUES (i, CONCAT('user',i), CONCAT('1101@',i));
		SET i = i + 1;
	END WHILE;
END $



CALL batch(10000)





