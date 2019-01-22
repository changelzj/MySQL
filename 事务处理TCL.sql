

SHOW ENGINES

/*myisam memory存储引擎均不支持事务
A原子性：每个事务都是不可分割的单位，要么全部执行，要么全部失败
C一致性：使数据库从一个一致的状态切换到另一个一致性的状态
I隔离性：一个事务执行不受其他事务干扰（需要隔离级别控制）
D持久性：一个事务，一旦提交，就是永久性改变

隐式事务：INSERT UPDATE DELETE默认开启, SHOW VARIABLES LIKE '%autocommit%'

*/



/* 提交一个事务*/
SET autocommit = 0;  -- 必须,使用多个语句的事务，需要禁用隐式事务
START TRANSACTION; -- 可选
-- 只有增删改查可以有事务，ddl语句没有事务
UPDATE account SET money = money-20 WHERE id = 1; 
UPDATE account SET money = money+20 WHERE id = 2; 
-- 结束事务,应用程序外无法决定使用提交还是回滚,COMMIT,ROLLBACK只能手动选择一个

-- COMMIT;

ROLLBACK;




/*隔离级别
	运行多个事务，访问相同数据，如果不采取隔离机制，就会引发并发问题
	1脏读：读取到一个事务更新了但未提交的字段，若回滚，读到的数据就是无效的，一般指更新
	2幻读：一个事务读取后，另一个事务进行插入新行，再次读到的结果不一样，一般指添加删除
	3不可重复读：一个事务多次查询结果不一样，读取之后又更新，两次读到的数据不一样
	
	设置隔离级别避免并发问题
	Oracle支持 读已提交和串行化，默认第一提交
	MySQL支持 读未提交 读已提交 可重复读 串行化，默认可重复读
	
	读未提交：脏读
	读已提交：避免脏读，同一事务多次查询结果可能不一样，不能避免不可重复读和幻读
	可重复读：避免脏读，同一事务多次查询结果一样，避免不可重复读，但无法解决幻读
	串行化：拒绝其他事务同时的操作，能解决一切问题，但性能低下
*/

-- 查看当前隔离级别
SELECT @@tx_isolation

-- 设置隔离级别为读未提交
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- 回滚点

SET autocommit = 0;  -- 必须,使用多个语句的事务，需要禁用隐式事务
START TRANSACTION; -- 可选
-- 只有增删改查可以有事务，ddl语句没有事务
UPDATE account SET money = money-20 WHERE id = 1; 
SAVEPOINT a
UPDATE account SET money = money+20 WHERE id = 2; 
-- 结束事务,应用程序外无法决定使用提交还是回滚,COMMIT,ROLLBACK只能手动选择一个

-- COMMIT;

ROLLBACK TO a;

