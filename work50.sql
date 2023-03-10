CREATE DATABASE IF NOT EXISTS work50 CHARSET = utf8;
USE work50;

CREATE TABLE student
(
    s_id    INT,
    s_name  VARCHAR(8),
    s_brith DATE,
    s_sex   VARCHAR(4)
    );
INSERT INTO
    student
    VALUES
        (1, '赵雷', '1990-01-01', '男'),
        (2, '钱电', '1990-12-21', '男'),
        (3, '孙风', '1990-05-20', '男'),
        (4, '李云', '1990-08-06', '男'),
        (5, '周梅', '1991-12-01', '女'),
        (6, '吴兰', '1992-03-01', '女'),
        (7, '郑竹', '1989-07-01', '女'),
        (8, '王菊', '1990-01-20', '女');

CREATE TABLE course
(
    c_id   INT,
    c_name VARCHAR(8),
    t_id   INT
    );

INSERT INTO
    course
    VALUES
        (1, '语文', 2),
        (2, '数学', 1),
        (3, '英语', 3);

CREATE TABLE teacher
(
    t_id   INT,
    t_name VARCHAR(8)
    );

INSERT INTO
    teacher
    VALUES
        (1, '张三'),
        (2, '李四'),
        (3, '王五');

CREATE TABLE score
(
    s_id    INT,
    c_id    INT,
    s_score INT
    );

INSERT INTO
    score
    VALUES
        (1, 1, 80),
        (1, 2, 90),
        (1, 3, 99),
        (2, 1, 70),
        (2, 2, 60),
        (2, 3, 65),
        (3, 1, 80),
        (3, 2, 80),
        (3, 3, 80),
        (4, 1, 50),
        (4, 2, 30),
        (4, 3, 40),
        (5, 1, 76),
        (5, 2, 87),
        (6, 1, 31),
        (6, 3, 34),
        (7, 2, 89),
        (7, 3, 98);


# 1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数
SELECT
    st.*,
    sc1.s_score AS '课程1',
    sc2.s_score AS '课程2'
    FROM
        student st
            INNER JOIN (
            SELECT *
                FROM
                    score
                WHERE
                    c_id = 1
            ) AS sc1 ON st.s_id = sc1.s_id
            INNER JOIN (
            SELECT *
                FROM
                    score
                WHERE
                    c_id = 2
            ) AS sc2 ON st.s_id = sc2.s_id
    WHERE
        sc1.s_score > sc2.s_score;


# 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
SELECT
    st.*,
    sc1.s_score AS '课程1',
    sc2.s_score AS '课程2'
    FROM
        student st
            INNER JOIN (
            SELECT *
                FROM
                    score
                WHERE
                    c_id = 1
            ) AS sc1 ON st.s_id = sc1.s_id
            INNER JOIN (
            SELECT *
                FROM
                    score
                WHERE
                    c_id = 2
            ) AS sc2 ON st.s_id = sc2.s_id
    WHERE
        sc1.s_score < sc2.s_score;
# 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT
    st.s_id,
    st.s_name,
    round(scv.平均成绩, 2)
    FROM
        student AS st
            INNER JOIN
            (
                SELECT
                    score.s_id,
                    (avg(s_score)) AS '平均成绩'
                    FROM
                        score
                    GROUP BY
                        s_id
                    HAVING
                        floor(avg(s_score)) > 60
                ) AS scv
            ON st.s_id = scv.s_id;

SELECT
    score.s_id,
    floor(avg(s_score))

    FROM
        score
    GROUP BY
        s_id
    HAVING
        floor(avg(s_score)) > 60;


# 4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩(包括有成绩的和无成绩的)
SELECT
    st.s_id,
    st.s_name,
    scv.平均成绩
    FROM
        student AS st
            LEFT JOIN
            (
                SELECT
                    score.s_id,

                    floor(avg(s_score)) AS '平均成绩'
                    FROM
                        score
                    GROUP BY
                        s_id
                ) AS scv
            ON st.s_id = scv.s_id
    WHERE
         scv.平均成绩 < 60
      OR scv.平均成绩 IS NULL;

SELECT
    score.s_id,
    floor(avg(s_score)) AS '平均成绩'

    FROM
        score
    GROUP BY
        s_id
    HAVING
        floor(avg(s_score)) < 60;
# 5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
# s_id  s_name  count(course) sum(s_score)


SELECT
    st.s_id,
    st.s_name,
    suid.选课总数,
    ssc.所有课程总分数
    FROM
        student AS st
            LEFT JOIN
            (
                SELECT
                    sc.s_id,
                    count(sc.c_id) AS '选课总数'
                    FROM
                        score sc
                    GROUP BY sc.s_id
                ) AS suid
            ON st.s_id = suid.s_id
            LEFT JOIN (
            SELECT
                sc.s_id,
                sum(sc.s_score) AS '所有课程总分数'
                FROM
                    score sc
                GROUP BY
                    sc.s_id
            ) AS ssc
                      ON st.s_id = ssc.s_id
    OR
        ssc.所有课程总分数 IS NULL;

SELECT
    sc.s_id,
    count(sc.c_id)
    FROM
        score sc
    GROUP BY
        sc.s_id;
SELECT
    sc.s_id,
    sum(sc.s_score)
    FROM
        score sc
    GROUP BY
        sc.s_id;
# 6、查询"李"姓老师的数量
SELECT count(*) AS '"李"姓老师的数量'
    FROM
        teacher WHERE t_name LIKE '李%';
# 7、cha询学过"张三"老师授课的同学的信息

# 8、查询没学过"张三"老师授课的同学的信息
# 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
# 10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
# 11、查询没有学全所有课程的同学的信息
# 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息
# 13、查询和"01"号的同学学习的课程完全相同的其他同学的信息
# 14、查询没学过"张三"老师讲授的任一门课程的学生姓名
# 15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
# 16、检索"01"课程分数小于60，按分数降序排列的学生信息
# 17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
# 18、查询各科成绩最高分、最低分和平均分，以如下形式显示：
# 19、按各科成绩进行排序，并显示排名
# 20、查询学生的总成绩并进行排名
# 21、查询不同老师所教不同课程平均分从高到低显示
# 22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
# 23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
# 24、查询学生平均成绩及其名次
# 25、查询各科成绩前三名的记录
# 26、查询每门课程被选修的学生数
# 27、查询出只有两门课程的全部学生的学号和姓名
# 28、查询男生、女生人数
# 29、查询名字中含有"风"字的学生信息
# 30、查询同名同性学生名单，并统计同名人数
# 31、查询1990年出生的学生名单
# 32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
# 33、查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩
# 34、查询课程名称为"数学"，且分数低于60的学生姓名和分数
# 35、查询所有学生的课程及分数情况
# 36、查询任何一门课程成绩在70分以上的学生姓名、课程名称和分数
# 37、查询课程不及格的学生
# 38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名
# 39、求每门课程的学生人数
# 40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩
# 41、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩
# 42、查询每门课程成绩最好的前三名
# 43、统计每门课程的学生选修人数（超过5人的课程才统计）
# 44、检索至少选修两门课程的学生学号
# 45、查询选修了全部课程的学生信息
# 46、查询各学生的年龄(周岁)
# 47、查询本周过生日的学生
# 48、查询下周过生日的学生
# 49、查询本月过生日的学生
# 50、查询12月份过生日的学生
