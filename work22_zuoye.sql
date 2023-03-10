CREATE TABLE IF NOT EXISTS classes
(
    id   VARCHAR(10) PRIMARY KEY NOT NULL,
    name VARCHAR(20)
    );
USE zuoye;
CREATE TABLE IF NOT EXISTS students
(
    studentNo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name      VARCHAR(10),
    sex       VARCHAR(1),
    hometown  VARCHAR(10),
    age       VARCHAR(10),
    class_id  VARCHAR(10),
    card      VARCHAR(30)
    );

/*插入数据*/
INSERT INTO
    students
    VALUES
        (1, '王昭君', '女', '北京', '20', '1', '340322199001247654'),
        (2, '诸葛亮', '男', '上海', '18', '2', '340322199002242354'),
        (3, '张飞', '男', '南京', '24', '3', '340322199003247654'),
        (4, '白起', '男', '安徽', '22', '4', '340322199005247654'),
        (5, '大乔', '女', '天津', '19', '3', '340322199004247654'),
        (6, '孙尚香', '女', '河北', '18', '1', '340322199006247654'),
        (7, '百里玄策', '男', '山西', '20', '2', '340322199007247654'),
        (8, '小乔', '女', '河南', '15', '3', 'null'),
        (9, '百里守约', '男', '湖南', '21', '1', ''),
        (10, '妲己', '女', '广东', '26', '2', '340322199607247654'),
        (11, '李白', '男', '北京', '30', '4', '340322199005267754'),
        (12, '孙膑', '男', '新疆', '26', '3', '340322199000297655');


/*查询全部学生信息，并按照“性别”排序*/
SELECT *
    FROM
        students
    ORDER BY
        sex;

/*查询现有学生都来自于哪些不同的省份*/
SELECT
    hometown
    FROM
        students
    GROUP BY
        hometown;
# 5、查询所有男生，并按年龄升序排序
SELECT *
    FROM
        students
    ORDER BY
        age ASC;
# 6、统计共有多少个学生
SELECT
    count(*)
    FROM
        students;
# 7、统计年龄大于20岁的学生有多少个
SELECT
    count(*)
    FROM
        students
    WHERE
        age > 20;
# 8、统计男生的平均年龄
SELECT
    avg(age)
    FROM
        students
    WHERE
        sex = '男';
# 9、查询1班学生中的最大年龄是多少
SELECT
    max(age)
    FROM
        students
    WHERE
        class_id = '1';
# 10、统计2班男女生各有多少人
SELECT
    class_id,
    sex,
    count(*)
    FROM
        students
    WHERE
        class_id = 2
    GROUP BY
        sex;
# 11、统计每个班级中每种性别的学生人数，并按照班级升序排序
SELECT
    class_id,
    sex,
    count(*)
    FROM
        students
    GROUP BY
        class_id, sex
    ORDER BY
        class_id;
# 12、查询年龄最小的学生的全部信息
SELECT *
    FROM
        students
    ORDER BY
        age
    LIMIT 1;


# 1. 查询学生"百里守约"的基本信息
SELECT *
    FROM
        students
    WHERE
        name = '百里守约';
# 2. 查询学生"百里守约"或”百里玄策”的基本信息
SELECT *
    FROM
        students
    WHERE
         name = '百里守约'
      OR name = '百里玄策';
# 3. 查询姓"张"学生的姓名，年龄，班级
SELECT *
    FROM
        students
    WHERE
        name LIKE '张%';
# 4. 查询姓名中含有"约"字的学生的基本信息
SELECT *
    FROM
        students
    WHERE
        name LIKE '%约%';
# 5. 查询姓名长度为三个字，姓“孙”的学生的学号，姓名，年龄，班级，身份证号
SELECT
    studentNo,
    name,
    age,
    class_id,
    card
    FROM
        students
    WHERE
        name LIKE '孙__';
# 6. 查询姓"百"或者姓”孙”的学生的基本信息
SELECT *
    FROM
        students
    WHERE
         name LIKE '百%'
      OR name LIKE '孙%';
# 7. 查询姓"百"并且家乡是"山西"的学生信息
SELECT *
    FROM
        students
    WHERE
        name LIKE '百%'
    HAVING
        hometown = '山西';
# 8. 查询家乡不是"北京"、"新疆"、"山东"、"上海"的学生的信息
SELECT *
    FROM
        students
    WHERE

          NOT (hometown = '北京')
      AND NOT (hometown = '新疆')
      AND NOT (hometown = '⼭东')
      AND NOT (hometown = '上海');
# 9. 查询姓"孙"，但是家乡不是"河北"的学生信息
SELECT *
    FROM
        students
    WHERE
          name LIKE '孙%'
      AND NOT (hometown = '河北');
# 10. 查询家乡不是"北京"、"新疆"、"山东"、"上海"的学生的信息
SELECT *
    FROM
        students
    WHERE
            hometown
            NOT IN ('新疆', '北京', '上海', '⼭东');
# 11. 查询全部学生信息，并按照“性别”排序
SELECT *
    FROM
        students
    ORDER BY
        sex;
# 12. 查询所有男生，并按年龄升序排序
SELECT *
    FROM
        students
    WHERE
        sex = '男'
    ORDER BY
        age ASC;
# 13. 统计共有多少个学生
SELECT
    count(*)
    FROM
        students;
# 14. 统计年龄大于20岁的学生有多少个
SELECT
    count(*)
    FROM
        students
    WHERE
        age > 20;
# 15. 统计男生的平均年龄
SELECT
    avg(age)
    FROM
        students
    WHERE
        sex = '男';
# 16. 查询1班学生中的最大年龄是多少
SELECT
    max(age)
    FROM
        students
    WHERE
        class_id = 1;
# 17. 统计2班男女生各有多少人
SELECT
    count(*),
    class_id,
    sex
    FROM
        students
    WHERE
        class_id = 2
    GROUP BY
        sex;
# 18. 查询年龄最小的学生的全部信息
SELECT *
    FROM
        students
    ORDER BY
        age
    LIMIT 1;


# 10拓展题
CREATE TABLE Student
(
    Id         INT(10) UNIQUE PRIMARY KEY NOT NULL COMMENT '学号',
    Name       VARCHAR(20)                NOT NULL COMMENT '姓名',
    Sex        VARCHAR(4) COMMENT '性别',
    Brith      YEAR COMMENT '出生年份',
    Department VARCHAR(20)                NOT NULL COMMENT '院系',
    Address    VARCHAR(50) COMMENT '家庭住址'
    );

CREATE TABLE Score
(
    Id     INT(10) UNIQUE PRIMARY KEY NOT NULL COMMENT '编号',
    Stu_id INT(10)                    NOT NULL COMMENT '学号',
    C_name VARCHAR(20) COMMENT '课程名',
    Grade  INT(10) COMMENT '分数'
    );

INSERT INTO
    Student (Id, Name, Sex, Brith, Department, Address)
    VALUES
        (901, '张老大', '男', 1985, '计算机系', '北京市海淀区'),
        (902, '张老二', '男', 1986, '中文系', '北京市昌平区'),
        (903, '张三', '女', 1990, '中文系', '湖南省永州市'),
        (904, '李四', '男', 1990, '英语系', '辽宁省阜新市'),
        (905, '王五', '女', 1991, '英语系', '福建省厦门市'),
        (906, '王六', '男', 1988, '计算机系', '湖南省衡阳市');

INSERT INTO
    Score(Id, Stu_id, C_name, Grade)
    VALUES
        (1, 901, '英语', 80),
        (2, 902, '计算机', 65),
        (3, 902, '中文', 88),
        (4, 903, '中文', 95),
        (5, 904, '计算机', 70),
        (6, 904, '英语', 92),
        (7, 905, '英语', 94),
        (8, 906, '计算机', 90);
INSERT INTO
    Score (Id, Stu_id, C_name, Grade)
    VALUES
        (9, 901, '计算机', NULL),
        (10, 901, '中文', NULL),
        (11, 902, '英语', NULL);
# 1. 查询student表的所有记录
SHOW CREATE TABLE Student;
SELECT *
    FROM
        Student;
# 2. 查询student表的第2条到4条记录
SELECT *
    FROM
        Student
    LIMIT 1,3;
# 3. 从student表查询所有学生的学号（id）、姓名（name）和院系（department）的信息
SELECT
    id,
    name,
    Department
    FROM
        Student
    LIMIT 10;
# 4. 从student表中查询计算机系和英语系的学生的信息（写出两种答案）
SELECT *
    FROM
        Student
    WHERE
        Department IN ('计算机系', '英语系');
SELECT *
    FROM
        Student
    WHERE
         Department = '计算机系'
      OR Department = '英语系';
SELECT *
    FROM
        Student
    WHERE
         Department LIKE '计%'
      OR Department LIKE '英%';

# 5. 从student表中查询年龄18~29岁的学生信息（写出两种答案）
SELECT *
    FROM
        Student
    WHERE
        2023 - Brith BETWEEN 18 AND 29;
SELECT *
    FROM
        Student
    WHERE
          2023 - Brith > 18
      AND 2023 - Brith < 29;
# 6. 从student表中查询每个院系有多少人
SELECT
    count(*),
    Department
    FROM
        Student
    GROUP BY
        Department;
# 7. 从score表中查询每个科目的最高分
SELECT
    max(Grade),
    C_name
    FROM
        Score
    GROUP BY
        C_name;
# 8. 计算每个考试科目的平均成绩
SELECT
    C_name,
    avg(Grade)
    FROM
        Score
    GROUP BY
        C_name;
# 9. 将计算机考试成绩按从高到低进行排序
SELECT
    *
    FROM
        Score
    WHERE
        C_name = '计算机'
    ORDER BY
        Grade
        DESC;

