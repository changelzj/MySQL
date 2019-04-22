



## 存储过程

-- 使用存储过程，减少编译次数和连接数据库次数，提高效率

/*

CREATE PROCEDURE 存储过程名(参数模式 参数名 参数类型,参数模式 参数名 参数类型,...) 
BEGIN （语句只有一条 begin end 可省略）
	合法有效的SQL语句;（分号）
	合法有效的SQL语句;
END

参数模式:
	IN :可以作为输入，需要调用者传入值
	OUT ：可以作为输出，可以作为返回值
	INOUT：既可以传入值，又可以返回值
	
调用存储过程：
CALL name(var, var)
*/



-- no args
delimiter $
CREATE PROCEDURE pr1()
BEGIN
	INSERT INTO book(`name`, price, author) VALUES('012',23.56,'lzj');
	INSERT INTO book(`name`, price, author) VALUES('45',23.56,'lzj');
	INSERT INTO book(`name`, price, author) VALUES('12',23.56,'lzj');
	INSERT INTO book(`name`, price, author) VALUES('87',23.56,'lzj');
	INSERT INTO book(`name`, price, author) VALUES('32',23.56,'lzj');
END $

CALL pr1()



-- IN
delimiter $
CREATE procedure pr2(IN bid INT)
BEGIN
	SELECT * FROM beauty WHERE boyfriend_id = bid;
END $

CALL pr2(12)


delimiter $
CREATE PROCEDURE pr3(IN username VARCHAR(20), IN `password` VARCHAR(20))
BEGIN
	DECLARE res INT;
	SELECT COUNT(*) INTO res FROM admin 
	WHERE admin.username = username AND admin.`password` = `password`;
	SELECT res;
END $

CALL pr3('john','8888')

-- OUT
delimiter $
CREATE PROCEDURE pr4(IN girl INT, OUT boy INT)
BEGIN
	SELECT beauty.boyfriend_id INTO boy FROM beauty WHERE beauty.id = girl;
END $


CALL pr4(1, @boy);
SELECT @boy;

-- 两个out的存储过程
delimiter $
CREATE PROCEDURE pr5(IN girlid INT, OUT boyid INT, OUT girlname VARCHAR(20))
BEGIN
	SELECT 
		beauty.boyfriend_id,  beauty.`name` 
	INTO 
		boyid, girlname
	FROM beauty WHERE beauty.id = girlid;
END $
-- --
CALL pr5(2, @boyid, @girlname);
SELECT  @boyid;
SELECT @girlname;


-- INOUT
delimiter $
CREATE PROCEDURE pr6(INOUT a INT, INOUT b INT) 
BEGIN
	SET a = a*2;
	SET b = b*2;
END $

SET @i = 2;
SET @j = 4;
call pr6(@i, @j);
SELECT @i;
SELECT @j;

## 删除(只能同时删除一个

DROP PROCEDURE pr2

## 查看

show CREATE PROCEDURE pr3



