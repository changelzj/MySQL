## 函数 
/*
单行函数：做处理 
分组函数：做统计
*/

/**/
-- 字节数
SELECT LENGTH('1234哈哈') AS len -- 字节数

-- 查看客户端字符集
SHOW VARIABLES LIKE '%char%'

-- 字符串连接 大写 小写
SELECT CONCAT('a','b','c') 

SELECT UPPER('ASddfDSU')

SELECT LOWER('ASddfDSU')

-- 索引从1开始，从某一位开始的截取 字符长度
SELECT SUBSTR('helloworld', 6)

-- 从某一索引开始，截取某段长度 字符长度
SELECT SUBSTR('helloworld',1,3)

SELECT CONCAT(  UPPER( SUBSTR(last_name, 1, 1) )    ) FROM employees

-- 返回起始索引 如果找不到返回0
SELECT INSTR('helloworld','or')

-- 去前后空格
SELECT TRIM('  vdfsv  scs  ')

-- 去掉首尾的o
SELECT TRIM('o' FROM 'ooooooooooooooooooheoooolloooooooooooooooooooooooooooooooo')

-- 指定字符左填充到指定长度，如果超过，右边的被截断
SELECT LPAD('hello',10,'*')
SELECT LPAD('hellohellohtllohello',10,'*')

-- 指定字符右填充到指定长度，如果超过，右边的被截断
SELECT RPAD('hello',10,'*')
SELECT RPAD('hellohellohtllohello',10,'*')

-- 替换
SELECT REPLACE('王老八夜里打酱油和酱油','酱油','酒')

/*数学函数*/

-- ROUND(x) 四舍五入
SELECT ROUND(1.65)
SELECT ROUND(1.4)
SELECT ROUND(-1.65)
SELECT ROUND(-1.4)

-- ROUND(x, y) 小数保留
SELECT ROUND(1.6545, 2)
SELECT ROUND(1.4578, 2)

-- 上取整，返回大于等于参数的最小整数
SELECT CEIL(1.025)
SELECT CEIL(1.00)
SELECT CEIL(-1.025)
SELECT CEIL(-1.00)

-- 下取整，返回小于等于参数的最大整数
SELECT FLOOR(1.021)
SELECT FLOOR(9.6)
SELECT FLOOR(-9.6)

-- 截断
SELECT TRUNCATE(1.65,1)

-- %:余数
SELECT MOD(-11,3)
SELECT MOD(11,3)

/*日期函数*/
-- 日期时间
SELECT NOW()

SELECT CURRENT_TIME()
SELECT YEAR(NOW())
SELECT YEAR('1996-08-14')

SELECT MONTH(NOW())
SELECT MONTHNAME(NOW())

-- 字符通过指定格式转换成日期
SELECT STR_TO_DATE('14-8-1996','%d-%m-%Y')
SELECT STR_TO_DATE('14-8-96','%d-%m-%y')

SELECT * FROM employees WHERE hiredate = '1992-4-3'
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y')

SELECT DATE_FORMAT(NOW(),'%y-%m-%d')
SELECT DATE_FORMAT(NOW(),'%Y-%m-%d')
SELECT DATE_FORMAT(NOW(),'%c-%d %Y')

SELECT last_name, DATE_FORMAT(hiredate,'%y年/%m月 %d日') AS hiredate FROM employees

/*流程控制函数*/

SELECT IF(1=1,1,0)
SELECT IF(1=41,1,0)

SELECT last_name, commission_pct, IF(commission_pct IS NOT NULL, '有奖金', '没奖金') FROM employees 
ORDER BY commission_pct DESC

/*case结构1 类似switch 适合判断等值运算*/
SELECT
	last_name,
	department_id,
	salary,
CASE
		department_id 
		WHEN 30 THEN
		salary * 1.2 
		WHEN 40 THEN
		salary * 1.5 ELSE salary 
	END AS new_salary 
FROM
	employees

/*case结构1 类似多重if 适合判断范围运算*/

SELECT
	last_name,
	department_id,
	salary,
	CASE 
		WHEN salary > 20000 THEN 'A'
		WHEN salary > 15000 THEN 'B'
		WHEN salary > 10000 THEN 'C'
	ELSE
		'D'
END AS 工资级别 
FROM employees;





