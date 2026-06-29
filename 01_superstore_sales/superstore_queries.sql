create database superstore
use superstore;
select count(*)
from sales;
select * 
from sales
limit 5;
select 
round(sum(Sales)) AS total_sales,
round(sum(Profit)) AS total_profit
from sales;
select Category,
round(sum(Sales), 2) as total_sales,
round(sum(Profit),2) as total_profit
from sales
group by Category
order by total_sales desc;
select Region,
round(sum(Sales)) as total_sales,
round(sum(Profit)) as total_profit
from sales
group by Region
order by total_profit desc;
select
YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
round(sum(Sales)) as total_sales
from sales
group by order_year
order by total_sales;
select `Sub-Category`,
round(sum(Sales),2) as total_sales
from sales
group by `Sub-Category`
order by total_sales desc
limit 5;
select `Customer Name`,
round(sum(Sales),2)	as total_sales,
rank() over(order by sum(Sales) desc) as  sales_rank
from sales
group by `Customer Name`
order by sales_rank
limit 5;