-- Задание 1
SELECT city, age, count(*) from users
GROUP BY city, age
order by 1,3 desc;

-- Отдельно для "категорий"
SELECT city, 
       (CASE 
        WHEN age <21 THEN 'young'
        WHEN age >49 THEN 'old'
        ELSE 'adult' END) as category,
       count(*)
       from users
GROUP BY city, category
order by 1,3 desc;

--Задание 2
SELECT round(CAST (AVG (price) AS numeric), 2) AS avg_price, 
       category 
       FROM products
WHERE name LIKE 'Hair%' OR name LIKE 'Home%'
GROUP BY category;

--Задание 3
SELECT seller_id, 
       count(*) as total_categ,
       AVG (rating) as avg_rating, 
       SUM (revenue) as total_revenue,
       (CASE WHEN SUM (revenue)>50000 THEN 'rich' WHEN SUM (revenue)<50000 THEN 'poor' END ) as seller_type
       from sellers
WHERE category != 'Bedding'
GROUP BY seller_id HAVING COUNT (*) > 1
order by seller_id ASc;

--Задание 4
SELECT seller_id, 
       (date(now())-TO_DATE(min(date_reg), 'DD/MM/YYYY'))/30 as month_from_registration,
       (SELECT max(delivery_days)- MIN(delivery_days)  FROM sellers ) as max_delivery_difference
       from sellers
WHERE category != 'Bedding'
GROUP BY seller_id HAVING COUNT (*) > 1 AND SUM (revenue)<50000
order by seller_id ASc;

--Задание 5
SELECT seller_id, 
       STRING_AGG(category,'-' ORDER BY category) category_pair 
       FROM sellers
GROUP BY seller_id  
HAVING COUNT (*) = 2 AND SUM (revenue)>75000 AND extract('year' from TO_DATE(min(date_reg), 'DD/MM/YYYY')) = 2022;
