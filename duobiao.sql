CREATE DATABASE duobiao CHARSET = utf8;
USE duobiao;
CREATE TABLE category
(
    cid   VARCHAR(32) PRIMARY KEY,
    cname VARCHAR(50)
    );
CREATE TABLE products
(
    pid         VARCHAR(32) PRIMARY KEY,
    pname       VARCHAR(50),
    price       INT,
    flag        VARCHAR(2), #是否上架标记为：1表示上架、0表示下架
    category_id VARCHAR(32),
    CONSTRAINT products_fk FOREIGN KEY (category_id) REFERENCES category (cid)
    );
# 分类
INSERT INTO
    category(cid, cname)
    VALUES
        ('c001', '家电');
INSERT INTO
    category(cid, cname)
    VALUES
        ('c002', '服饰');
INSERT INTO
    category(cid, cname)
    VALUES
        ('c003', '化妆品');
INSERT INTO
    category(cid, cname)
    VALUES
        ('c004', '奢侈品');
# 商品
INSERT INTO
    products(pid, pname, price, flag, category_id)
    VALUES
        ('p001', '联想', 5000, '1', 'c001');
INSERT INTO
    products(pid, pname, price, flag, category_id)
    VALUES
        ('p002', '海尔', 3000, '1', 'c001');
INSERT INTO
    products(pid, pname, price, flag, category_id)
    VALUES
        ('p003', '雷神', 5000, '1', 'c001');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p004', 'JACK JONES', 800, '1', 'c002');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p005', '真维斯', 200, '1', 'c002');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p006', '花花公子', 440, '1', 'c002');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p007', '劲霸', 2000, '1', 'c002');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p008', '香奈儿', 800, '1', 'c003');
INSERT INTO
    products (pid, pname, price, flag, category_id)
    VALUES
        ('p009', '相宜本草', 200, '1', 'c003');

# 1.查询哪些分类的商品已经上架
# 内连接
SELECT DISTINCT
    c.cname
    FROM
        category c
            INNER JOIN products p ON c.cid = p.category_id
    WHERE
        p.flag = '1';

# 2.查询所有分类商品的个数
# 左连接
SELECT
    count(category_id),
    cname
    FROM
        category c
            LEFT JOIN products p ON c.cid = p.category_id
    GROUP BY
        cname;

# 查询“化妆品”分类上架商品详情
SELECT *
    FROM
        products p
    WHERE
            p.category_id = (
            SELECT
                c.cid
                FROM
                    category c
                WHERE
                    cname = '化妆品'
            );
# 作为另一张表
SELECT *
    FROM
        products p,
        (
            SELECT *
                FROM
                    category
                WHERE
                    cname = '化妆品'
            ) c
    WHERE
        p.category_id = c.cid;

# 查询“化妆品”和“家电”两个分类上架商品详情
SELECT *
    FROM
        products p
    WHERE
            p.category_id IN (
            SELECT
                c.cid
                FROM
                    category c
                WHERE
                     cname = '化妆品'
                  OR cname = '家电'
            );




