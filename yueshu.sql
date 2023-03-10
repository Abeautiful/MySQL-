CREATE DATABASE IF NOT EXISTS yueshu CHARSET = utf8;
USE yueshu;
CREATE TABLE ocr
(
    id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    sex  ENUM ('男','女'),
    age  INT

    );
INSERT INTO
    ocr (name, sex, age)
    VALUES
        ('张三', '男', 20);

SHOW TABLES;
DESC ocr;
ALTER TABLE ocr
    DROP PRIMARY KEY;
INSERT INTO
    ocr (name, sex, age)
    VALUES
        ('里斯', '男', 20);

ALTER TABLE ocr
    DROP PRIMARY KEY;
ALTER TABLE ocr
    CHANGE name name VARCHAR(20) NOT NULL;
/*非空约束*/
INSERT INTO
    ocr (id, name, sex, age)
    VALUES
        (12, '刘', '男', '22');


/*唯一约束 unique*/
CREATE TABLE feikong
(
    id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idcard INT UNIQUE,
    name   VARCHAR(20) UNIQUE,
    sex    ENUM ('男','女'),
    age    INT
    );
INSERT INTO
    feikong (id, idcard, name, sex, age)
    VALUES
        (NULL, 2021223, '阿布', '男', 23);
INSERT INTO
    feikong (id, idcard, name, sex, age)
    VALUES
        (NULL,2021224,'阿里','女',21);

/*默认约束*/
CREATE TABLE moren(
    id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idcard INT UNIQUE,
    name   VARCHAR(20) UNIQUE,
    sex    ENUM ('男','女'),
    age    INT,
    address VARCHAR(20) DEFAULT '北京'
                  );
DESC moren;
INSERT INTO
    moren (idcard, name, sex, age,address)
    VALUES
        (2021227,'阿妮','女',21,'南京');

