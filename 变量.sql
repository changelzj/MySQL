## 变量

-- 系统变量：
	-- 全局变量：整个服务器有效
	-- 会话变量：一次连接

-- 自定义变量：
	-- 用户变量
	-- 局部变量
	
-- 查看所有会话变量
SHOW VARIABLES 

-- 所有全局变量
SHOW GLOBAL VARIABLES 

-- 查看部分全局变量的值
SHOW GLOBAL VARIABLES LIKE '%char%'

SHOW SESSION VARIABLES 


SHOW SESSION VARIABLES LIKE '%auto%'
SHOW GLOBAL VARIABLES LIKE '%auto%'


-- 查看系统变量名 
-- SELECT  @@varname：默认查会话变量
-- SELECT  @@session.varname：默认查会话变量
-- SELECT @@globle.varname 查询系统变量
SELECT @@auto_increment_increment

-- 为变量赋值
-- SET GLOBAL (如果是SESSION可以不写) varname = value
-- SET @@global varname = value
-- SET @@session varname = value



# 自定义变量

-- 用户变量针对当前连接有效，声明时必须初始化，可以不指定类型
-- 三种语法
SET @mycat = 'helloworld';
SET @car := 'car';
SELECT @cat := 'cat';

-- 更新:适用于声明的语法
-- 还可以查出一个值赋给变量
SELECT employees.email INTO @cat FROM employees WHERE employee_id = 100
-- 查询变量的值
SELECT @cat

-- 使用用户变量也需要@
SET @a = 1;
SET @b = 2;
SET @c = @a + @b;
SELECT @c


-- 局部变量，只能放在begin end 中第一句话

-- 声明
	-- DECLARE 变量名 类型 
	-- DECLARE 变量名 类型  DEFAULT 250
-- 赋值与用户变量相同

