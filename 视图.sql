## 视图：基于查询的虚拟表
-- 始于mysql 5.1 ，通过普通表动态生成的数据，适用于复杂查询，在使用时动态生成，只保存了SQL逻辑
-- 适用于多个地方用到同一个SQL，且SQL复杂
-- 可以隐藏列定义，保护数据，不会暴漏原始表
-- 创建
CREATE VIEW empjobdept AS 
SELECT employees.last_name AS lastname,employees.employee_id AS eid,
departments.department_name AS deptname,
jobs.job_title AS jobtitle
FROM employees 
LEFT JOIN departments ON departments.department_id = employees.department_id
LEFT JOIN jobs ON jobs.job_id = employees.job_id

-- 使用视图
SELECT * from empjobdept

CREATE VIEW deptavg AS
SELECT 
avg(salary) AS avg,
department_id AS deptId
FROM employees 
GROUP BY department_id

SELECT deptavg.deptId,grad.grade_level AS lev from deptavg
JOIN job_grades grad ON deptavg.avg BETWEEN grad.lowest_sal AND grad.highest_sal

select * from job_grades

-- 修改视图

-- 存在就修改，不存在就创建
CREATE OR REPLACE VIEW AS 查询语句

ALTER VIEW 视图名 AS 查询语句


-- 删除试图
DROP VIEW 视图名，视图名....

-- 查看视图
DESC empjobdept
show create view empjobdept


/*
视图支持更新修改和删除，而且会影响到原始表
不能编辑视图的情况：
包含分组函数 GROUP BY HAVING 去重 联合 子查询等语句
from不能更改的视图
常量视图
WHERE字句子查询引用了from字句中的表时
*/


/*
视图和表的对比
创建语法不同
视图数据不占用物理空间，只保存逻辑
*/


