/*创建主从表*/
# 分类表
CREATE TABLE category
(
    cid   VARCHAR(32) PRIMARY KEY,
    cname VARCHAR(100)
    );

# 商品表（外键约束）
CREATE TABLE products
(
    pid         VARCHAR(32) PRIMARY KEY,
    name        VARCHAR(40),
    price       DOUBLE,
    category_id VARCHAR(32),
    CONSTRAINT FOREIGN KEY (category_id) REFERENCES category (cid)
    );
# 分类表插入数据
INSERT INTO
    category (cid, cname)
    VALUES
        ('c001', '服装');

#2 向商品表添加普通数据,没有外键数据，默认为null
INSERT INTO
    products (pid, name)
    VALUES
        ('p001', '商品名称');
#3 向商品表添加普通数据，含有外键信息(category表中存在这条数据)
INSERT INTO
    products (pid, name, category_id)
    VALUES
        ('p002', '商品名称2', 'c001');
#4 向商品表添加普通数据，含有外键信息(category表中不存在这条数据) -- 失败,异常
INSERT INTO
    products (pid, name, category_id)
    VALUES
        ('p003', '商品名称2', 'c999');
#5 删除指定分类(分类被商品使用) -- 执行异常
DELETE
    FROM
        category
    WHERE
        cid = 'c001';


# 创建hero表
CREATE TABLE hero
(
    hid       INT PRIMARY KEY,
    hname     VARCHAR(255),
    kongfu_id INT
    );
# 创建kongfu表
CREATE TABLE kongfu
(
    kid   INT PRIMARY KEY,
    kname VARCHAR(255)
    );
# 插入hero数据
INSERT INTO
    hero
    VALUES
        (1, '鸠摩智', 9),
        (3, '乔峰', 1),
        (4, '虚竹', 4),
        (5, '段誉', 12);
# 插入kongfu数据
INSERT INTO
    kongfu
    VALUES
        (1, '降龙十八掌'),
        (2, '乾坤大挪移'),
        (3, '猴子偷桃'),
        (4, '天山折梅手');
# 内连接
SELECT
    hname,
    kname
    FROM
        hero
            INNER JOIN kongfu ON hero.kongfu_id = kongfu.kid;
# 左连接
SELECT
    hname,
    kname
    FROM
        hero
            LEFT JOIN kongfu ON kongfu.kid = hero.kongfu_id;
# 左连接
SELECT
    hname,
    kname
    FROM
        kongfu
            LEFT JOIN hero ON  hero.kongfu_id = kongfu.kid ;
# 右连接
SELECT
    hname,
    kname
    FROM
        kongfu
            RIGHT JOIN hero ON kongfu.kid = hero.kongfu_id;




