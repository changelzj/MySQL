-- 出现在其他语句中的查询语句就是子查询，也叫内查询



	-- 标量子查询：结果集一行一列
	-- 列子查询：结果集一列多行
	-- 行子查询：结果集一行多列
	-- 表子查询:只要是查询结果就构成
	
	/*
	select后面仅支持标量子查询，
	from后面支持表子查询，
	where having 支持标量和列子查询，也能支持行子查询
	EXISTS 后面支持表子查询
	
	1.子查询放在小括号内
	2.子查询一般放在条件右侧
	3.标量子查询一般配合单行操作符使用 < > = <>
	4.列子查询一般配合多行操作符 IN ANY SOME ALL
	*/
	
	
	# 标量子查询
	-- 工资大于107号员工的人
	SELECT last_name FROM employees WHERE salary > (
		SELECT salary FROM employees WHERE employee_id = 107
	)


-- 与141号相同工种，工资比143号大的人
SELECT employee_id, last_name, job_id, salary FROM employees 
WHERE job_id = (
	select job_id FROM employees WHERE employee_id = 141
)
AND salary > (
	SELECT salary FROM employees WHERE employee_id = 143
)

-- 工资最少
select * from employees	WHERE salary = (select MIN(salary) FROM employees )
	
-- 哪个部门最低工资大于50号部门的最低工资
SELECT job_id, MIN(salary) AS min FROM employees GROUP BY job_id
HAVING min > (
		SELECT MIN(salary) FROM employees WHERE department_id = 50
	)
	
# 列子查询 一列多行

-- location_id 是1400,1700的部门的员工
SELECT last_name, department_id FROM employees WHERE department_id IN (
	SELECT DISTINCT department_id FROM departments WHERE location_id IN (1400,1700)
) 

-- 比job_id 是 'IT_PROG'的任意一个员工工资少的其他工种的员工
SELECT * FROM employees WHERE salary < ANY(
	SELECT DISTINCT salary FROM employees WHERE job_id = 'IT_PROG'
)
AND job_id <> 'IT_PROG'


-- 比job_id 是 'IT_PROG'的所有的员工工资都少的其他工种的员工
SELECT * FROM employees WHERE salary < ALL(
	SELECT DISTINCT salary FROM employees WHERE job_id = 'IT_PROG'
)
AND job_id <> 'IT_PROG'


-- 查询编号最小，工资最高的人 行子查询
SELECT * FROM employees WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary) FROM employees
)


# SELECT 后的子查询
-- 每个部门员工个数
SELECT 
	dept.department_id AS deptId, 
	(SELECT COUNT(*) FROM employees WHERE department_id = dept.department_id) AS count
FROM departments dept

SELECT * FROM departments

-- 102号员工的部门名
SELECT 
	employees.employee_id, 
	employees.last_name,	(SELECT department_name FROM departments WHERE department_id = employees.department_id) AS deptName
FROM employees WHERE employee_id = 102


SELECT * from job_grades


# from后的子查询
-- 每个部门平均工资等级
SELECT 
	jg.grade_level AS lavel ,
	avg_dep.salary AS salary,
	avg_dep.deptId AS deptId
	
FROM job_grades jg
RIGHT JOIN 
(SELECT AVG(salary) AS salary, department_id AS deptId FROM employees GROUP BY department_id) avg_dep
ON avg_dep.salary BETWEEN jg.lowest_sal AND highest_sal


# EXISTS后子查询 ：相关子查询，布尔类型，看查询是否有值，括号内写查询语句
SELECT EXISTS(
	SELECT * FROM employees
)

SELECT EXISTS(
	SELECT * FROM employees WHERE salary = 251526
)

-- 查询有员工的部门

SELECT department_name FROM departments WHERE EXISTS (
	SELECT last_name, department_id FROM employees WHERE employees.department_id = departments.department_id
)

-- 没有配偶的男生
SELECT * FROM boys WHERE NOT EXISTS (
	SELECT * from beauty WHERE boyfriend_id = boys.id
)



