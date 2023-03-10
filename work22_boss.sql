CREATE DATABASE IF NOT EXISTS boss CHARSET = utf8;
USE boss;
CREATE TABLE bumen
(
    bumenid   INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    bumenname VARCHAR(20)
    );
CREATE TABLE yuangong
(
    ygid        INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ygname      CHAR(20),
    ygsex       ENUM('male','female'),
    ygage       INT,
    ygseniority INT,
    ygwage      DOUBLE(8,2),
    ygbumenid   INT
    );

INSERT INTO
    bumen
    VALUES
        (0, '人事部'),
        (0, '销售部'),
        (0, '开发部');

INSERT INTO
    yuangong
    VALUES
        (0, 'Tom', 'male', 25, 1, 4500, 1),
        (0, 'Jack', 'male', 28, 3, 6500, 1),
        (0, 'Rose', 'female', 24, 1, 8500, 2),
        (0, 'Alice', 'female', 24, 1, 8500, 2),
        (0, 'Alex', 'female', 26, 1, 8500, 2),
        (0, 'Tony', 'male', 30, 4, 12000, 2),
        (0, 'Lily', 'female', 35, 7, 25000, 2),
        (0, 'Lucy', 'female', 32, 4, 20000, 2),
        (0, 'Rose', 'female', 26, 2, 10000, 3),
        (0, 'Max', 'male', 28, 3, 15000, 3),
        (0, 'Jean', 'female', 22, 1, 10000, 3),
        (0, 'Kate', 'female', 23, 1, 10000, 3),
        (0, 'Karry', 'male', 42, 15, 50000, 3),
        (0, 'Finn', 'male', 35, 7, 30000, 3),
        (0, 'Kylo', 'male', 32, 6, 35000, 3),
        (0, 'Rose', 'female', 24, 1, 15000, 3);
SELECT database();
# 1. 将Tony的部门调整到开发部
# 2. 将工资低于10000的员工加薪1000
# 3. 删除工资大于30000 的员工

