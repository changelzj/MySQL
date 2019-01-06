-- 登录系统 
#mysql -h 主机 -P 端口 -u root -p   
#mysql -h 主机 -P 端口 -u root -p密码 
# 密码与p之间不得有空格，其他项之间可以有
	
	
# 常量
SELECT 6;

# 字符常量
SELECT 'a';
SELECT "aaa";

#表达式
SELECT 100*98;
#函数
SELECT VERSION();

SELECT DATABASE()

SELECT USER()
	
	
# 别名
SELECT 'A' AS B
SELECT 'A' B

select last_name as 姓, last_name as 名 FROM employees

# 别名有特殊字符，加双引号
select last_name AS "SELECT #" FROM employees;

#去重
# 查员工表涉及的部门编号，字段前加上DISTINCT
SELECT DISTINCT department_id FROM employees;


/*加号的作用是数学运算不能连接字符串
两个操作数都为数值，则进行运算，其中一方为字符型，则试图将字符转换为数值，
如果转换成功，继续运算，如果转换失败，则字符型的值转换为0
两个操作数，只要其中一方为null，结果为null

*/

SELECT NULL+10

SELECT last_name+first_name AS 姓名
FROM employees;

/*拼接*/
SELECT CONCAT('a','b','c') 

/*null和任何值拼接，结果都是null*/
SELECT CONCAT('a','b',NULL) 

SELECT CONCAT(last_name, first_name) AS 姓名 FROM employees AS 姓名

/*ifnull() 如果为空值*/
SELECT IFNULL(null,'default') as ifn


SELECT * FROM employees WHERE salary > 12000

SELECT * FROM employees WHERE department_id <> 90

SELECT * FROM employees WHERE salary >= 10000 AND salary <= 20000

SELECT * FROM employees WHERE department_id <90 OR department_id > 110 OR salary > 15000

SELECT * FROM employees WHERE NOT(department_id >= 90 AND department_id <= 110) OR salary > 15000

-- 百分号代表通配符 ，任意字符，也包含0个字符
-- 下划线_ 代表任意单个字符
SELECT * FROM employees WHERE last_name LIKE '%o%'

-- 查询第三个字母是n第五个字母是n
SELECT * FROM employees WHERE last_name like '__n_l%'

-- 查询第二个字符就是下划线的特殊情况，要进行转义或切换通配符，否则直接__%查询会把所有查出
SELECT * FROM employees WHERE last_name LIKE '_\_%'
SELECT * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$'

-- BETWEEN AND 可以提高简捷度，结果包含区间值，临界值的位置不能颠倒，否则零行
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120
SELECT * FROM employees WHERE salary NOT BETWEEN 8000 AND 17000

-- IN 值必须相同或兼容，不能使用通配符
SELECT * FROM employees WHERE job_id IN ('IT_PROG','AD_VP')

-- 查询NULL 用 IS / IS NOT 等于和不等于号不能判断空值
SELECT * FROM employees WHERE commission_pct IS NULL
SELECT * FROM employees WHERE commission_pct IS NOT NULL

-- 安全等于 可用来普通值也可以判断空值
SELECT * FROM employees WHERE commission_pct <=> NULL

-- 排序查询
-- 升序 升序
SELECT * FROM employees ORDER BY salary ASC /*ASC可以省略*/
-- 降序 降序
SELECT * FROM employees ORDER BY salary DESC
-- 条件排序
SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate ASC

-- 表达式排序
SELECT
	last_name,
	first_name,
	salary * 12 * ( 1+ IFNULL( commission_pct, 0 ) ) AS annual_salary 
FROM
	employees
ORDER BY annual_salary ASC

-- 按照姓名长度
SELECT
	LENGTH( CONCAT( last_name, first_name ) ) AS length,
	last_name,
	first_name ,
	salary
FROM
	employees
ORDER BY length


-- 多字段排序
SELECT * FROM employees ORDER BY salary ASC, employee_id DESC


