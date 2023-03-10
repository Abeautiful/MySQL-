CREATE DATABASE IF NOT EXISTS bigdata CHARSET = 'utf8';
SELECT database();
SHOW DATABASES;
USE bigdata;
SELECT database();


/*数据表操作*/
CREATE TABLE ocr
(
    id      VARCHAR(20) PRIMARY KEY NOT NULL,
    name    VARCHAR(20),
    kecheng VARCHAR(20)
    );
SHOW TABLES;
SHOW DATABASES;
USE bigdata;
SHOW TABLES;
CREATE TABLE IF NOT EXISTS category
(
    uid   INT UNSIGNED PRIMARY KEY NOT NULL,
    uname VARCHAR(20)
    );
SHOW TABLES;
DESC ocr;
DESC category;
SHOW CREATE TABLE category;
SHOW TABLES;
DESC category;
CREATE DATABASE test01;
USE test01;
CREATE TABLE IF NOT EXISTS luxun
(
    cid   VARCHAR(20) PRIMARY KEY NOT NULL,
    cname VARCHAR(20)
    );
SHOW TABLES;
DESC luxun;
SHOW CREATE TABLE luxun;
DROP TABLE luxun;
DROP TABLE IF EXISTS luxun;


/*修改数据表结构*/
USE bigdata;
DESC category;
ALTER TABLE category
    ADD uketang VARCHAR(30);
ALTER TABLE category
    CHANGE uketang usex VARCHAR(30);
ALTER TABLE category
    DROP usex;
RENAME TABLE category TO categoty1;
RENAME TABLE categoty1 TO category;
DESC category;

/*插入表记录*/
INSERT INTO
    category (uid, uname, usex)
    VALUES
        ('001', 'youron', '男');
INSERT INTO
    category (uid, uname, usex)
    VALUES
        ('002', 'nanshen', '男');

INSERT INTO
    category (uid, uname, usex)
    VALUES
        ('003', 'nvshen', '女');
INSERT INTO
    category (uname,usex)
    VALUES
        ('shenshi', '男'),
        ('baiyueguang', '女');

/*更新表数据*/
UPDATE category
SET
    uname='女神'
    WHERE
        uid = '003';
INSERT INTO
    category (uid,uname, usex)
    VALUES
        (5,'神圣', '男');

DELETE
    FROM
        category
    WHERE
        uid = '006';
DELETE FROM category;
TRUNCATE category;




