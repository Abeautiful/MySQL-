CREATE DATABASE jinyong CHARSET = utf8;
USE jinyong;

CREATE TABLE IF NOT EXISTS book
(
    id       INT PRIMARY KEY NOT NULL,
    name     VARCHAR(10),
    pub_date TIME,
    price    DOUBLE

    );

INSERT INTO
    book
    VALUES
        ('1', '射雕英雄传', '1970-05-01 00:00:00', '36.60'),
        ('2', '天龙八部', '1986-07-24 00:00:00', '50.20'),
        ('3', '笑傲江湖', '1995-12-24 00:00:00', '40.00'),
        ('4', '雪山飞狐', '1987-11-11 00:00:00', '29.00');

USE jinyong;
CREATE TABLE IF NOT EXISTS heroes
(
    id      INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name    VARCHAR(10) DEFAULT '',
    age     INT         DEFAULT 0,
    gender  VARCHAR(10),
    skill   VARCHAR(10),
    book_id INT                                     NOT NULL
    );

INSERT INTO
    heroes (name, age, gender, skill, book_id)
    VALUES
        ('郭靖', 30, '男', '降龙十八掌', 1),
        ('黄蓉', 30, '女', '打狗棍法', 1),
        ('黄药师', 60, '男', '弹指神通', 1),
        ('欧阳锋', 65, '男', '蛤蟆功', 1),
        ('梅超风', 40, '女', '九阴白骨爪', 1),
        ('乔峰', 33, '男', '降龙十八掌', 2),
        ('段誉', 25, '男', '六脉神剑', 2),
        ('虚竹', 27, '男', '天山六阳掌', 2),
        ('王语嫣', 18, '女', '神仙姐姐', 2),
        ('令狐冲', 32, '男', '独孤九剑', 3),
        ('任盈盈', 24, '女', '弹琴', 3),
        ('岳不群', 50, default, '华山剑法', 3),
        ('东方不败', 99, '中性', '葵花宝典', 3),
        ('胡斐', 26, '男', '胡家刀法', 4),
        ('苗若兰', 16, '女', '黄衣', 4),
        ('程灵素', 20, '女', '医术', 4),
        ('袁紫衣', 22, '女', '六合拳', 4);


/*修改book表pub_date字段类型为date类型*/
ALTER TABLE book
    CHANGE pub_date pub_date DATE;
ALTER TABLE book
    CHANGE price price DECIMAL(5, 2) NOT NULL;
# 4、查询所有的英雄信息以及对应的书名
SELECT
    h.*,
    b.name
    FROM
        heroes h
            INNER JOIN book b ON h.book_id = b.id;
# 5、查询80年代出版的书中所有的女性英雄信息以及对应的书的信息
SELECT *
    FROM
        heroes h
            INNER JOIN book b ON h.book_id = b.id
            AND b.pub_date > '1980'
            AND h.gender = '女'
            AND b.pub_date < '1990';
# 6、查出会"降龙十八掌"的英雄名字以及对应的书名
SELECT
    h.name AS '英雄',
    b.name AS '书名'
    FROM
        heroes h
            INNER JOIN book b ON h.book_id = b.id AND h.skill = '降龙十八掌';
# 7、查询每本书中英雄年龄的平均值
SELECT
    floor(avg(h.age)),
    b.name
    FROM
        heroes h
            INNER JOIN book b ON h.book_id = b.id
    GROUP BY
        b.name;
# 8、查询每本书中年纪最大的英雄
SELECT
    h.name AS '英雄',
    h.age,
    b.name AS '书名'

    FROM
        heroes h
            INNER JOIN (
            SELECT
                max(age) AS mage,
                book_id  AS bd
                FROM
                    heroes
                GROUP BY book_id
            ) AS m #每本书最大年龄的表
                       ON h.age = m.mage
            INNER JOIN
            book b
            ON m.bd = b.id;
# 各组的最大年龄
SELECT
    max(age) AS mage,
    book_id  AS bd
    FROM
        heroes
    GROUP BY
        book_id;