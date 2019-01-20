-- 库和表：数据定义语言 

-- 库操作
CREATE DATABASE book
CREATE DATABASE IF NOT EXISTS book

use book

-- 更改库字符集
ALTER DATABASE book CHARACTER SET utf8
ALTER DATABASE book CHARACTER SET gbk


DROP DATABASE book
DROP DATABASE IF EXISTS book

-- 表

CREATE TABLE book(
	id INT(10) ,
	`name` VARCHAR (30),
	price DOUBLE,
	authorId INT(10),
	publishDate DATETIME
)

DESC book

CREATE TABLE author(
	id INT,
	`name` VARCHAR(20)
)

-- 修改列名 类型
ALTER TABLE book CHANGE COLUMN publishDate pubDate datetime
-- 修改类约束 类型
ALTER TABLE book MODIFY COLUMN pubDate datetime
-- 添加新列
ALTER TABLE author ADD COLUMN last_name VARCHAR(20)
ALTER TABLE author ADD COLUMN first_name VARCHAR(20)

-- 删除列
ALTER TABLE author DROP COLUMN first_name

-- 修改表名
ALTER TABLE author RENAME TO `authors`

-- 删除
DROP TABLE IF EXISTS `authors`

-- 复制

-- 仅仅复制结构
CREATE TABLE 1_author LIKE `author`
-- 复制结构和数据
CREATE TABLE 12_author SELECT * FROM `author`
-- 条件复制
CREATE TABLE 12_author SELECT * FROM `author` WHERE id = 1
-- 复制部分列
CREATE TABLE 12_author SELECT `name` FROM `author` WHERE id = 1
-- 复制部分列，不要数据，使用恒不成立
CREATE TABLE 12_author SELECT `name` FROM `author` WHERE 2 = 1
CREATE TABLE 12_author SELECT `name` FROM `author` WHERE 0 /*0=false*/





# 数据类型划分

-- 整形 TINYINT SMALLINT MEDIUMINT INT(INTEGER) BIGINT
-- 小数：定点数，浮点数
-- 字符型：短文本char VARCHAR，长文本text
-- 日期
-- BLOB 长二进制数据

# 整形
-- 对于整形，长度由范围决定，设置的长度用来补零，但必须在建立字段时搭配zerofill，一旦zerofill，默认为无符号

-- 如果不设置无符号，默认是有符号，如果插入数值超出范围，系统会警告，默认插入临界值
-- 设置有无符号
create table user(
 age int UNSIGNED ,
 id int 
)


INSERT INTO `user` VALUES (-9,9)


/*
浮点型小数 float(m,d) double(m,d)  
定点型小数 DECIMAL(m,d) 	精度高，最大取值范围与double相同
m 整数部分和小数部分合起来的位数
d 小数点后保留位数
超出范围默认是临界值
*/

/* text
m指最大字符数
CHAR(m)，固定长度字符，开的空间与长度有关 ，耗费空间，效率高，可以省略m， m默认是1
VARCHAR(m) 可变长度的字符，开的空间与实际占用有关，节省空间，效率低，不能省略m



*/

-- 枚举型：enum('c','b') 掺入的值不在枚举内，默认是空，不区分大小写


-- SET 类型，一次可以插入多个值，不区分大小写

## 日期值，必须用单引号引起
/*
date 10000101-99991231
time 838:59:59
datetime 10000101-99991231
year 1901-2155
TIMESTAMP 19700101080001-2038年某一时刻，受时区影响，更能反应实际日期，与MySQL版本和sqlmode关系很大
*/

CREATE TABLE t_time(
f1 datetime,
f2 TIMESTAMP
)

INSERT INTO t_time VALUES(now(), now());
SELECT * from t_time

-- 获取时区
SHOW VARIABLES LIKE 'time_zone'

SET time_zone = '+9:00'
SET time_zone = '+8:00'



# 约束

/* 六大约束
NOT NULL 非空约束
DEFAULT 保证有默认值
PRIMARY KEY 保证一个字段的值的唯一性和非空
UNIQUE 唯一约束，可以为空
CHECK 检查约束 MySQL不支持
FOREIGN KEY 外键，限制两个表的关系，该字段值必须来自于主表关联列的值

表级约束：除了非空和默认，其他都支持
列级约束：6大约束语法上都支持，但外键约束没有效果
*/

CREATE TABLE stuinfo(
	id int PRIMARY KEY ,
	stuname VARCHAR(20) NOT NULL,
	gender CHAR (1) CHECK(gender='男' OR gender='女'), /*mysql无效*/
	seat INT UNIQUE,
	age  INT UNSIGNED DEFAULT 18,
	majarId INT
)


CREATE TABLE majar(
	 id int PRIMARY KEY,
	`name` CHAR(15) 
)

DESC stuinfo
-- 查看索引：主键 外键 唯一
SHOW INDEX FROM stuinfo 


drop table if EXISTS stuinfo;

-- 表级约束语法（名字可以不起，mysql中，主键改名无效）
CREATE TABLE stuinfo(
	id int ,
	stuname VARCHAR(20) ,
	gender CHAR (1) ,
	seat INT ,
	age  INT UNSIGNED ,
	majarId INT,
	CONSTRAINT pk/*mysql中，主键改名无效*/ PRIMARY KEY (id),
	CONSTRAINT uq UNIQUE (seat),
	CONSTRAINT fk_majar FOREIGN KEY (majarId) REFERENCES majar(id)
)

show create table stuinfo

/* 主键和唯一的对比

都可以保证唯一

主键不能为空，每个表只能有1个，可以两个列自合一起

唯一允许为空，一个表可以有多个，不能多个为空，可以两个列自合一起

*/

/* 外键
从表设置外键关系
数据类型一致或兼容
主表被关联列必须是一个key,一般是主键或唯一
插入数据时，先插入主表在插入从表，删除数据，先删除从表，再删除主表
*/


CREATE TABLE stuinfo(
	id int ,
	stuname VARCHAR(20) ,
	gender CHAR (1) ,
	seat INT ,
	age  INT UNSIGNED ,
	majarId INT
)
DESC stuinfo

-- 修改表时添加约束

-- 设置空和非空
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NOT NULL
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NULL

ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18

-- 添加主键
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY
-- 支持表级约束的也可以这样
ALTER TABLE stuinfo ADD PRIMARY KEY (id)

-- 添加唯一
ALTER TABLE stuinfo ADD UNIQUE (seat)

-- 添加外键
ALTER TABLE stuinfo ADD FOREIGN KEY (majarId) REFERENCES majar(id)

-- 添加外键 名字
ALTER TABLE stuinfo ADD CONSTRAINT fk_majar FOREIGN KEY (majarId) REFERENCES majar(id)



# 删除约束
-- 删除非空
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NULL
-- 不添加条件，就会删除默认约束
ALTER TABLE stuinfo MODIFY COLUMN age 
-- 删除主键
ALTER TABLE stuinfo DROP PRIMARY KEY

-- 先查到，在删除唯一约束
SHOW INDEX FROM stuinfo 

ALTER TABLE stuinfo DROP INDEX seat

-- 删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk_majar


## 标识列：限制某个字段，又叫自增长列，默认从1开始
/*
标识列 必须是一个key，同一张表标识列只能有一个，只能是数值类型

*/

CREATE TABLE stuinfo(
	id int PRIMARY KEY auto_increment,
	stuname VARCHAR(20) ,
	gender CHAR (1) ,
	seat INT ,
	age  INT UNSIGNED ,
	majarId INT
)
DESC stuinfo
DROP TABLE stuinfo

show VARIABLES like '%auto_increment%'
-- 步长auto_increment_increment  起始值auto_increment_offset
-- mysql 可以设置步长，但是不能设置起始值

-- 设置删除标识列
ALTER TABLE stuinfo MODIFY COLUMN id int PRIMARY KEY auto_increment

ALTER TABLE stuinfo MODIFY COLUMN id int  









