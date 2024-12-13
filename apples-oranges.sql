"""
Table: Sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date, fruit) is the primary key (combination of columns with unique values) of this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write a solution to report the difference between the number of apples and oranges sold each day.

Return the result table ordered by sale_date.

The result format is in the following example.

Input: 
Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
| 2020-05-01 | apples     | 10          |
| 2020-05-01 | oranges    | 8           |
| 2020-05-02 | apples     | 15          |
| 2020-05-02 | oranges    | 15          |
| 2020-05-03 | apples     | 20          |
| 2020-05-03 | oranges    | 0           |
| 2020-05-04 | apples     | 15          |
| 2020-05-04 | oranges    | 16          |
+------------+------------+-------------+
Output: 
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+

"""
  
-- method 1: using Self join
select 
    a.sale_date, a.sold_num - b.sold_num as diff
from 
    Sales a join Sales b 
on 
    a.sale_date = b.sale_date 
where 
    a.fruit = 'apples' and b.fruit = 'oranges'
order by a.sale_date


-- method 2: create two separate tables
select 
    a.sale_date, a.sold_num - b.sold_num as diff
from 
    (select sale_date, sold_num from Sales where fruit = 'apples') a
join
    (select sale_date, sold_num from Sales where fruit = 'oranges') b
on 
    a.sale_date = b.sale_date 

order by a.sale_date
  

-- method 3: with SUM(CASE WHEN)
select 
    sale_date,
    sum(
        case
            when fruit = 'apples' then sold_num
            when fruit = 'oranges' then sold_num*-1
            end
        ) as diff
from 
    Sales
group by 
    sale_date
order by 
    sale_date
