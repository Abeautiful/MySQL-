CREATE TABLE IF NOT EXISTS test03
(
    cid   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    cname VARCHAR(20),
    csex  CHAR(1) DEFAULT '略'
    );
INSERT INTO
    test03 (cname, csex)
VALUES ('张三','男');
/*删除主键约束*/
ALTER TABLE test03 DROP PRIMARY KEY ;
