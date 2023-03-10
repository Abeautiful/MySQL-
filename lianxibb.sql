CREATE DATABASE baobiao CHARSET = 'utf8';

USE baobiao;
/*2查询每个客户的 `ID`, `company name`, `contact name`, `contact title`, `city`, 和 `country`.
  并按照国家名字排序*/
SELECT
    customer_id,
    company_name,
    contact_name,
    contact_title,
    city,
    country
    FROM
        customers
    ORDER BY
        country;


/*3查询每一个商品的`
  product_name`，`category_name`，`quantity_per_unit`，`unit_price`，`units_in_stock`
  并且通过 `unit_price` 字段排序*/
SELECT
    p.product_name,
    c.category_name,
    p.quantity_per_unit,
    p.unit_price,
    units_in_stock
    FROM
        products p
            INNER JOIN categories c ON p.category_id = c.category_id
    ORDER BY
        p.unit_price;

# 4- 列出所有提供了4种以上不同商品的供应商列表
# - 所需字段：`supplier_id`, `company_name`, and `products_count` (提供的商品种类数量).
SELECT
    s.supplier_id,
    s.company_name,
    count(*) AS products_count
    FROM
        products p
            INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
    GROUP BY
        s.supplier_id, s.company_name
    HAVING
        products_count >= 4;

# 5提取订单编号为10250的订单详情，显示如下信息：
# - `product_name`, `quantity`, `unit_price` (`order_items` 表)`discount` ,`order_date`
# 按商品名字排序
#p  oi  oi
SELECT
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount,
    o.order_date
    FROM
        order_items oi
            INNER JOIN orders o ON oi.order_id = o.order_id
            INNER JOIN products p ON oi.product_id = p.product_id
    WHERE
        o.order_id = 10250
    ORDER BY
        product_name DESC;

# 6需求：提供订单编号为10248的相关信息，包括**product name**,
# **unit price** (在 `order_items` 表中),
# **quantity（数量）**,**company_name**（供应商公司名字 ，起别名 `supplier_name`).
SELECT
    p.product_name,
    oi.unit_price,
    oi.quantity,
    company_name AS supplier_name
    FROM
        order_items oi
            INNER JOIN products p ON oi.product_id = p.product_id
            INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
    WHERE
        oi.order_id = 10248
;

/*7 需求：提取每件商品的详细信息，包括
 商品名称（`product_name`）,
 供应商的公司名称  (`company_name`，在 `suppliers` 表中),
 类别名称 `category_name`, 商品单价`unit_price`,
 和每单位商品数量`quantity per unit`    */
SELECT
    p.product_name,
    s.company_name,
    c.category_name,
    p.unit_price,
    p.quantity_per_unit
    FROM
        products p
            INNER JOIN categories c ON p.category_id = c.category_id
            INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;


# 8统计2013年入职的员工数量，统计字段起别名 `number_of_employees
SELECT
    count(*) AS number_of_employees
    FROM
        employees e
    WHERE
          hire_date > '2013-01-01'
      AND hire_date < '2014-01-01';
# 9需求：统计每个供应商供应的商品种类数量
# - 结果返回供应商ID`supplier_id` ，公司名字`company_name` ，商品种类数量（起别名`products_count` )
# - 使用 `products` 和 `suppliers` 表.
SELECT
    s.supplier_id,
    s.company_name,
    count(*) AS products_count
    FROM
        suppliers s
            JOIN products p ON s.supplier_id = p.supplier_id
    GROUP BY
        s.supplier_id, company_name;



# 10- Northwind商店某些产品会不定期做打折促销
# - 每个商品的折扣都存储在 `order_items` 表的`discount` 列中
# - 例如，“ 0.20”折扣意味着客户支付原始价格的“ 1-0.2 = 0.8”
# - 在下面的代码中添加第二个名为`total_price_after_discount`的列，计算打折后的商品价格
SELECT
    sum(unit_price * quantity)                  AS total_price,
    sum(unit_price * quantity * (1 - discount)) AS total_price_after_discount
    FROM
        orders o
            JOIN order_items oi ON o.order_id = oi.order_id
    WHERE
        o.order_id = 10250;

# 11- 统计每个员工处理的订单总数
# - 结果包含员工ID`employee_id`，姓名`first_name` 和 `last_name`，处理的订单总数(别名 `orders_count`)
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    count(o.employee_id) AS orders_count
    FROM
        orders o
            JOIN employees e ON o.employee_id = e.employee_id
    GROUP BY
        e.employee_id;

# 12- 需求：计算每个客户的下订单数
# - 结果包含：用户id、用户公司名称、订单数量(`customer_id`, `company_name`,  `orders_count` )
SELECT
    c.customer_id,
    c.company_name,
    count(*) AS orders_count
    FROM
        customers c
            JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id, c.company_name;

# 13- 需求：统计2016年6月到2016年7月用户的总下单金额并按金额从高到低排序
# - 结果包含：顾客公司名称`company_name` 和总下单金额（折后实付金额）`total_paid`
# - 提示：
#   - 计算实际总付款金额： SUM(unit_price * quantity * (1 - discount))
#   - 日期过滤 `WHERE order_date >= '2016-06-01' AND order_date < '2016-08-01'`
SELECT
    c.company_name,
    SUM(unit_price * quantity * (1 - discount)) AS total_paid
    FROM
        customers c
            JOIN orders o ON c.customer_id = o.customer_id
            JOIN order_items oi ON o.order_id = oi.order_id
    WHERE
          order_date >= '2016-06-01'
      AND order_date < '2016-08-01'
    GROUP BY
        c.customer_id, c.company_name
    ORDER BY
        total_paid DESC;


/*14- 需求：统计客户总数和带有传真号码的客户数量
- 需要字段：`all_customers_count` 和 `customers_with_fax_count`*/
SELECT
    count(*)   AS all_customers_count,
    count(fax) AS customers_with_fax_count
    FROM
        customers;
/*需求：我们要在报表中显示每种产品的库存量，但我们不想简单地将“ units_in_stock”列放在报表中。
  报表中只需要一个总体级别，例如低，高：
  通过  `C` 列的值来判断库存的可用性
- 库存大于100 的可用性为高(high)
- 50到100的可用性为中等(moderate)
- 小于50的为低(low)
- 零库存 为 (none)*/
SELECT
    product_id,
    product_name,
    units_in_stock,
    CASE
        WHEN units_in_stock > 100 THEN 'high'
        WHEN units_in_stock > 50 THEN 'moderate'
        WHEN units_in_stock < 50 THEN 'low'
        WHEN units_in_stock = 0 THEN 'none' END AS availability
    FROM
        products;


# 16- 需求： 创建一个报表，统计员工的经验水平
# - 显示字段：`first_name`, `last_name`, `hire_date`, 和 `experience`
# - 经验字段（`experience` ）：
#   - `'junior'`  2014年1月1日以后雇用的员工
#   - `'middle'` 在2013年1月1日之后至2014年1月1日之前雇用的员工
#   - `'senior'` 2013年1月1日或之前雇用的员工

SELECT
    first_name,
    last_name,
    hire_date,
    CASE
        WHEN hire_date > '2014-01-01' THEN 'junior'
        WHEN hire_date > '2013-01-01' THEN 'middle'
        WHEN hire_date <= '2013-01-01' THEN 'senior'
        END AS experience
    FROM
        employees;

# 17- 我们的商店要针对北美地区的用户做促销活动：任何运送到北美地区（美国，加拿大) 的包裹免运费。
# - 创建报表，查询订单编号为10720~10730 活动后的运费价格
# 如果将其他地区的运费设置为10美元，那么可以用如下方式处理：
SELECT
    order_id,
    customer_id,
    ship_country,
    CASE
        WHEN ship_country = 'USA' OR ship_country = 'Canada' THEN 0.0
        ELSE 10.0
        END AS shipping_cost
    FROM
        orders
    WHERE
        order_id BETWEEN 10720 AND 10730;


# 18- 需求：创建客户基本信息报表
# - 包含字段：
#   - 客户id `customer_id`
#   - 公司名字 `company_name`
#   - 所在国家 `country`
#   - 使用语言`language`
# - 使用语言`language` 的取值按如下规则
#   - Germany, Switzerland, and Austria 语言为德语 `'German'`
#   - UK, Canada, the USA, and Ireland 语言为英语 `'English'`
#   - 其他所有国家 `'Other'`
SELECT
    customer_id,
    company_name,
    country,
    CASE
        WHEN country IN ('Germany', 'Switzerland', 'Austria') THEN 'German'
        WHEN country IN ('UK', 'Canada', 'USA', 'Ireland') THEN 'English'
        ELSE 'Other'
        END AS language
    FROM
        customers;


/*19- 需求：创建报表将所有产品划分为素食和非素食两类
- 报表中包含如下字段：
  - 产品名字 `product_name`
  - 类别名称 `category_name`
  - 膳食类型 `diet_type`:
    - 非素食 `'Non-vegetarian'`  商品类别字段的值为 `'Meat/Poultry'` 和 `'Seafood'`.
    - 素食*/
SELECT
    product_name,
    category_name,
    CASE
        WHEN category_name IN ('Meat/Poultry', 'Seafood') THEN 'Non-vegetarian'
        ELSE 'vegetarian' END AS diet_type
    FROM
        products
            JOIN categories c ON products.category_id = c.category_id;

# 20- 需求：创建报表统计供应商来自那个大洲
# - 报表中包含两个字段：供应商来自哪个大洲（`supplier_continent` ）和 供应产品种类数量（`product_count`）
# - 供应商来自哪个大洲（`supplier_continent` ）包含如下取值：
#   - `'North America'` （供应商来自 `'USA'` 和 `'Canada'`.）
#   - `'Asia'` （供应商来自 `'Japan'` 和 `'Singapore'`)
#   - `'Other'` (其它国家)
SELECT
    CASE
        WHEN s.country IN ('USA', 'Canada') THEN 'North America'
        WHEN s.country IN ('Japan', 'Singapore') THEN 'Asia'
        ELSE 'Other' END AS supplier_continent,
    count(*)             AS product_count
    FROM
        products p
            JOIN suppliers s ON p.supplier_id = s.supplier_id
    GROUP BY
        supplier_continent;



# 21- 需求：创建一个简单的报表来统计员工的年龄情况
# - 报表中包含如下字段
#   - 年龄（ `age` ）：生日大于1980年1月1日 `'young'` ，其余`'old'`
#   - 员工数量 （ `employee_count`）
SELECT
    CASE
        WHEN e.birth_date > '1980-01-01' THEN 'young'
        ELSE 'old' END AS age,
    count(*)           AS employee_count
    FROM
        employees e
    GROUP BY
        age;

#22 需求：统计客户的contact_title 字段值为 ’Owner' 的客户数量
# - 查询结果有两个字段：`represented_by_owner` 和 `not_represented_by_owner
SELECT
    count(CASE WHEN contact_title = 'Owner' THEN customer_id END)  AS represented_by_owner,
    count(CASE WHEN contact_title != 'Owner' THEN customer_id END) AS not_represented_by_owner

    FROM
        customers;


/*23- 需求：Washington (WA) 是 Northwind的主要运营地区，
  统计有多少订单是由华盛顿地区的员工处理的，多少订单是有其它地区的员工处理的
- 结果字段： `orders_wa_employees` 和 `orders_not_wa_employees`*/
SELECT
    count(CASE WHEN region = 'WA' THEN e.employee_id END)  AS orders_wa_employees,
    count(CASE WHEN region != 'WA' THEN e.employee_id END) AS orders_not_wa_employees

    FROM
        orders o
            JOIN employees e ON o.employee_id = e.employee_id;

/*24- 需求：创建报表，统计不同类别产品的库存量，将库存量分成两类 >30 和 <=30 两档分别统计数量
- 报表包含三个字段
  - 类别名称  `category_name`,
  - 库存充足  `high_availability`
  - 库存紧张 `low_availability` */

SELECT
    c.category_name,
    count(CASE WHEN units_in_stock > 30 THEN c.category_id END)  AS high_availability,
    count(CASE WHEN units_in_stock <= 30 THEN c.category_id END) AS low_availability
    FROM
        products p
            INNER JOIN categories c ON p.category_id = c.category_id
    GROUP BY
        c.category_id;

/*25 将23的SQL修改成用 SUM（） 函数实现
  Washington (WA) 是 Northwind的主要运营地区，
  统计有多少订单是由华盛顿地区的员工处理的，多少订单是有其它地区的员工处理的
- 结果字段： `orders_wa_employees` 和 `orders_not_wa_employees`
  */
SELECT
    sum(CASE WHEN region = 'WA' THEN 1 END)  AS orders_wa_employees,
    sum(CASE WHEN region != 'WA' THEN 1 END) AS orders_not_wa_employees
    FROM
        employees e
            JOIN orders o ON e.employee_id = o.employee_id;
/*26- 需求：创建报表统计运输到法国的的订单中，打折和未打折订单的总数量
- 结果包含两个字段：`full_price` （原价）和 `discounted_price`（打折）
  */
SELECT
    count(CASE WHEN oi.discount = 0 THEN 1 END)  AS full_price,
    count(CASE WHEN oi.discount != 0 THEN 1 END) AS discounted_price
    FROM
        orders o
            JOIN order_items oi ON o.order_id = oi.order_id
    WHERE
        ship_country = 'France';


/*27- 需求：输出报表，统计不同供应商供应商品的总库存量，以及高价值商品的库存量（单价超过40定义为高价值）
- 结果显示四列：
- 供应商ID `supplier_id`
- 供应商公司名 `company_name`
- 由该供应商提供的总库存 `all_units`
- 由该供应商提供的高价值商品库存 `expensive_units`
  */
SELECT
    s.supplier_id,
    s.company_name,
    sum(p.units_in_stock)                                           AS all_units,
    sum(CASE WHEN p.unit_price > 40 THEN units_in_stock ELSE 0 END) AS expensive_units
    FROM
        products p
            JOIN suppliers s ON p.supplier_id = s.supplier_id
    GROUP BY
        s.supplier_id, s.company_name;


/*28- 需求：创建报表来为每种商品添加价格标签，贵、中等、便宜
- 结果包含如下字段：`product_id`, `product_name`, `unit_price`, 和 `price_level`
- 价格等级`price_level`的取值说明：
  - `'expensive'`  单价高于100的产品
  - `'average'`  单价高于40但不超过100的产品
  - `'cheap'`  其他产品
  */
SELECT
    product_id,
    product_name,
    unit_price,
    CASE
        WHEN unit_price > 100 THEN 'expensive'
        WHEN unit_price > 40 THEN 'average'
        ELSE 'cheap' END AS price_level
    FROM
        products p;

/*29- 需求：制作报表统计所有订单的总价（不计任何折扣）对它们进行分类。
- 包含一下字段：
  - `order_id`
  - `total_price`（折扣前）
  - `price_group`
- 字段 price_group 取值说明：
  - 'high'总价超过2000美元
  - `'average'`，总价在$ 600到$ 2,000之间，包括两端
  - `'low'` 总价低于$ 600
  */
SELECT
    o.order_id,
    sum(oi.unit_price * quantity) AS total_price,
    CASE
        WHEN sum(oi.unit_price * quantity) > 2000 THEN 'high'
        WHEN sum(oi.unit_price * quantity) >= 600 THEN 'average'
        ELSE 'low' END            AS price_group
    FROM
        orders o
            JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY
        o.order_id;

/*30- 需求：统计所有订单的运费，将运费高低分为三档
- 报表中包含三个字段
  - `low_freight` `freight`值小于“ 40.0”的订单数
  - `avg_freight`  `freight`值大于或等于“ 40.0”但小于“ 80.0”的订单数
  - `high_freight `  `freight`值大于或等于“ 80.0”的订单数
  */

SELECT
    count(CASE
              WHEN freight < 40.0 THEN order_id END)                      AS low_freight,
    count(CASE WHEN freight >= 40.0 AND freight < 80.0 THEN order_id END) AS avg_freight,
    count(CASE WHEN freight >= 80.0 THEN order_id END)                    AS high_freight
    FROM
        orders;
