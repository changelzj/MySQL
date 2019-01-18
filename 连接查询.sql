SELECT * FROM beauty

select * from boys

-- 笛卡尔积：所有行全部连接，因缺少条件造成
select `name`,boyName from beauty, boys

-- 
select `name`,boyName from beauty, boys
WHERE beauty.boyfriend_id = boys.id

/*

连接查询的分类
	年代：sql92标准	sql99标准（推荐）
	功能：
		内连接 ：等值连接 非等值连接 自连接
		外连接 ：左外连接 右外连接 全外连接
		交叉连接

*/

-- 连接查询 sql92
-- 等值连接

-- 员工名和部门名
SELECT last_name, department_name FROM departments, employees
WHERE employees.department_id = departments.department_id

-- 有奖金的员工名，工种号和工种名
SELECT last_name, jobs.job_id, job_title FROM jobs, employees
WHERE employees.job_id = jobs.job_id
AND employees.commission_pct is not null

-- 每个城市的部门数量
SELECT COUNT(departments.department_id) , locations.city FROM locations, departments 
WHERE departments.location_id = locations.location_id
GROUP BY locations.city

SELECT job_title, COUNT(*) AS count FROM employees, jobs WHERE employees.job_id = jobs.job_id
GROUP BY jobs.job_id
ORDER BY count


SELECT last_name, department_name, city FROM employees AS emp, departments AS dept, locations AS loc
WHERE emp.department_id = dept.department_id AND dept.location_id = loc.location_id

-- 非等值连接
SELECT salary, employee_id ,grade_level from employees, job_grades AS grades
WHERE salary BETWEEN grades.lowest_sal AND grades.highest_sal


-- 自连接
-- 员工名和上级的名字

SELECT emp.last_name , emp.employee_id , emp.manager_id FROM employees emp , employees mang
WHERE emp.manager_id = mang.employee_id


-- 连接查询 sql99

SELECT job_title, last_name FROM employees emp
INNER JOIN jobs job ON job.job_id = emp.job_id

-- INNER省略
SELECT job_title, last_name FROM employees emp
 JOIN jobs job ON job.job_id = emp.job_id

--  非等值连接
SELECT salary, employee_id ,grade_level from employees
INNER JOIN job_grades AS grades 
ON salary BETWEEN grades.lowest_sal AND grades.highest_sal

select beauty.`name`, boys.boyName FROM beauty
INNER JOIN boys ON beauty.boyfriend_id = boys.id

-- 外连接 查一个表有一个表没有，主表都显示，副表和主表匹配的显示出来，没有匹配的用空填充
-- 左外连接:left join 左边是主表
select beauty.`name`, boys.boyName FROM beauty
LEFT OUTER JOIN boys ON beauty.boyfriend_id = boys.id

-- 右外连接，right join 右边的是主表

select beauty.`name`, boys.boyName FROM boys
RIGHT OUTER JOIN beauty ON beauty.boyfriend_id = boys.id

-- 没有员工的部门
select emp.last_name , dept.department_id FROM departments dept LEFT OUTER JOIN employees emp
ON dept.department_id = emp.department_id WHERE emp.employee_id is NULL


-- 交叉连接:笛卡尔积

SELECT beauty.*, boys.* FROM beauty
CROSS JOIN boys 






