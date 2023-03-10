CREATE DATABASE IF NOT EXISTS chaxun CHARSET = utf8;
USE chaxun;
CREATE TABLE product
(
    pid         INT PRIMARY KEY,
    pname       VARCHAR(20),
    price       DOUBLE,
    category_id VARCHAR(32)
    );
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (1, '联想', 5000, 'c001');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (2, '海尔', 3000, 'c001');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (3, '雷神', 5000, 'c001');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (4, '杰克琼斯', 800, 'c002');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (5, '真维斯', 200, 'c002');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (6, '花花公子', 440, 'c002');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (7, '劲霸', 2000, 'c002');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (8, '香奈儿', 800, 'c003');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (9, '相宜本草', 200, 'c003');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (10, '面霸', 5, 'c003');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (11, '好想你枣', 56, 'c004');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (12, '香飘飘奶茶', 1, 'c005');
INSERT INTO
    product(pid, pname, price, category_id)
    VALUES
        (13, '海澜之家', 1, 'c002');

/*去重查询*/
SELECT DISTINCT
    category_id
    FROM
        product;


/*查询商品名和商品价格*/
SELECT *
    FROM
        product;
SELECT
    pname,
    price
    FROM
        product;
SELECT
    pname AS name,
    price AS pe
    FROM
        product;
SELECT
    pname      AS name,
    price + 10 AS pe
    FROM
        product;

/*比较查询*/
# 查询商品名称为“花花公子”的商品所有信息：
SELECT *
    FROM
        product
    WHERE
        pname = '花花公子';
# 查询价格为800商品
SELECT *
    FROM
        product p
    WHERE
        p.price = 800;
# 查询价格不是800的所有商品
SELECT *
    FROM
        product
    WHERE
        price != 800;
SELECT *
    FROM
        product
    WHERE
        price <> 800;
# 查询商品价格大于60元的所有商品信息
SELECT *
    FROM
        product
    WHERE
        price > 60;
# 查询商品价格小于等于800元的所有商品信息
SELECT *
    FROM
        product
    WHERE
        price <= 800;

# 范围查询！
# 查询商品价格在200到1000之间所有商品
SELECT *
    FROM
        product
    WHERE
        price BETWEEN 200 AND 1000;
# 查询商品价格是200或800的所有商品
SELECT *
    FROM
        product
    WHERE
        price IN (200, 800);

# 将查询的结果保存到product1
CREATE TABLE product1
(
    pid         INT PRIMARY KEY,
    pname       VARCHAR(20),
    price       DOUBLE,
    category_id VARCHAR(32)
    );
INSERT INTO
    product1
SELECT *
    FROM
        product
    WHERE
        price BETWEEN 100 AND 500;
# 查询类别为c001或c003的所有商品
SELECT *
    FROM
        product
    WHERE
        category_id IN ('c001', 'c003');


# 逻辑查询！
# 查询商品价格在200到1000之间所有商品
SELECT *
    FROM
        product
    WHERE
          price > 200
      AND price < 1000;
# 查询商品价格是200或800的所有商品
SELECT *
    FROM
        product
    WHERE
         price = 200
      OR price = 800;
# 查询价格不是800的所有商品
SELECT *
    FROM
        product
    WHERE
        NOT (price = 800);
/*模糊查询*/
# # 查询以'香'开头的所有商品
SELECT *
    FROM
        product
    WHERE
        pname LIKE '香%';
# 查询第二个字为'想'的所有商品
SELECT *
    FROM
        product
    WHERE
        pname LIKE '_想%';

/*非空查询*/
# # 查询没有分类的商品
SELECT *
    FROM
        product
    WHERE
        category_id IS NULL;
# 查询有分类的商品
SELECT *
    FROM
        product
    WHERE
        category_id IS NOT NULL;


/*排序查询*/
# 1.使用价格排序(降序)
SELECT *
    FROM
        product
    ORDER BY
        price DESC;
# 2.在价格排序(降序)的基础上，以分类排序(降序)
SELECT *
    FROM
        product
    ORDER BY
        price DESC,
        category_id DESC;


/*聚合查询*/
# 1、查询商品的总条数
SELECT
    count(*)
    FROM
        product;
# 2、查询价格大于200商品的总条数
SELECT
    count(*)
    FROM
        product
    WHERE
        price > 200;
# 3、查询分类为'c001'的所有商品的总和
SELECT
    sum(price)
    FROM
        product
    WHERE
        category_id = 'c001';
# 4、查询分类为'c002'所有商品的平均价格
SELECT
    avg(price)
    FROM
        product
    WHERE
        category_id = 'c002';
# 5、查询商品的最大价格和最小价格
SELECT
    max(price),
    min(price)
    FROM
        product;

/*分组查询*/
# #1 统计各个分类商品的个数
SELECT
    category_id,
    count(*)
    FROM
        product
    GROUP BY
        category_id;
#2 统计各个分类商品的个数,且只显示个数大于1的信息
SELECT
    category_id,
    count(*)
    FROM
        product
    GROUP BY
        category_id
    HAVING
        count(*) > 1;

/*分页查询*/
SELECT *
    FROM
        product
LIMIT 5,3;
