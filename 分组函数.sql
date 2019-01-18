## 用作统计，又叫组函数，聚合函数，统计函数

-- 求和，忽略空值
SELECT SUM(salary) FROM employees;
-- 平均，忽略空值
SELECT AVG(salary) FROM employees


-- 最大最小值，忽略空值
SELECT MIN(salary) FROM employees
SELECT MAX(salary) FROM employees

SELECT MAX(last_name), MIN(last_name) FROM employees
SELECT MAX(hiredate), MIN(hiredate) FROM employees


-- count函数 计算非空的值的个数
/*
效率
myisam下 COUNT(*)效率最高
INNODB下 COUNT(*) COUNT(1) 效率差不多
COUNT(字段)效率最低
*/
SELECT COUNT(employees.commission_pct) FROM employees
SELECT COUNT(employees.employee_id) FROM employees

-- 可以用来查询总行数，某一列一个字段有值就统计上
SELECT COUNT(*) FROM employees
-- 加上常量值，相当于表中添加一列，可以用来查询总行数
SELECT COUNT(1) FROM employees




-- DISTINCT 去重后统计
SELECT count(salary) FROM employees
SELECT count(DISTINCT salary) FROM employees





-- 分组查询，和分组函数一同查询的字段要求是group by 后的字段

-- 每个部门的平均工资
SELECT  AVG(salary) , department_id FROM employees GROUP BY department_id
-- 工种最高工资
SELECT MAX(salary) salary, job_id FROM employees GROUP BY job_id

SELECT COUNT(*), location_id FROM departments GROUP BY location_id

-- 每个领导下有奖金的员工的最高工资（分组前的筛选）
SELECT MAX(salary), manager_id FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id

-- 哪个部门的员工数量大于2（分组后的筛选：HAVING）
SELECT COUNT(*) as count , department_id FROM employees GROUP BY department_id
HAVING count > 2


-- 每个工种有奖金的员工最高工资大于12000的工种编号和最高工资
SELECT MAX(salary) as max, job_id FROM employees 
WHERE  commission_pct is not null 
GROUP BY job_id
HAVING max > 12000

-- 领导编号大于102 的员工最低工资大于5000的 领导
SELECT min(salary) as min, manager_id FROM employees 
WHERE manager_id > 102
GROUP BY manager_id
HAVING min > 5000



-- 按表达式筛选
-- 按员工姓名长度分组，查员工个数大于5的姓名长度有几个
SELECT count(*) as count, LENGTH(last_name) len from employees 
GROUP BY len
HAVING count > 5



-- 多个字段分组
-- 每个部门每个工种的平均工资
SELECT AVG(salary) as salary, job_id, department_id FROM employees
GROUP BY job_id, department_id
ORDER BY salary DESC

-- 每个部门每个工种的平均工资中大于10000的
SELECT AVG(salary) as salary, job_id, department_id FROM employees
GROUP BY job_id, department_id
HAVING salary > 10000
ORDER BY salary DESC

-- 查各工种平均最大最小和总和
select 
	sum(salary) as sum,
	min(salary) as min,
	max(salary) as max,
	avg(salary) as avg,
	job_id 
FROM employees
	GROUP BY job_id
	ORDER BY job_id DESC







