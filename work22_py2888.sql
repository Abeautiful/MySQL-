CREATE DATABASE py2888;
USE py2888;
CREATE TABLE IF NOT EXISTS worker
(
    id     INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name   VARCHAR(10),
    level  INT                            NOT NULL,
    dep_id VARCHAR(20)
    );
CREATE TABLE IF NOT EXISTS department
(
    id   INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(20),
    mid  INT
    );
INSERT INTO
    worker
    VALUES
        (1, '黄蓉', 80, 100),
        (2, '东邪', 95, 100),
        (3, '梅超风', 90, 100);

INSERT INTO
    worker(name, level, dep_id)
    VALUES
        ('尹志平', 67, 200),
        ('丘处机', 85, 200),
        ('周伯通', 93, 200);

INSERT INTO
    department (id, name)
    VALUES
        (100, '桃花岛'),
        (200, '全真教');
USE py2888;
INSERT INTO
    worker (name, level, dep_id)
    VALUES
        ('杨过', '99', '300');

# 7. 求出所有 职工中 能力值高于70的人的信息
SELECT *
    FROM
        worker
    WHERE
        level > 70;
# 8. 求出所有 职工中 能力值前三甲的人的信息
SELECT *
    FROM
        worker
    ORDER BY level DESC
    LIMIT 0,3;
# 9. 求出所有 职工的 平均能力值
SELECT avg(level)
    FROM
        worker;
# 10. 使用 SQL 语句将 东邪  设置为桃花岛组的主管

# 11. 使用 SQL 语句将 丘处机设置为全真教组的主管




# 1. 求出每个部门的  平均能力值

# 2. 求出部门平均值 > 40的所有部门及其相关平均能力值信息。
# 3. 使用连接求出所有 部门名称、主管姓名、主管能力值

