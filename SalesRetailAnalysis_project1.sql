select * from retail_sales;

select count(*) from retail_sales;

select * from retail_sales where
transaction_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

---Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales where sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales 
where category = 'Clothing' and quantity>=4 and sale_date between '2022-11-01' and '2022-11-30';

select * from retail_sales 
where category = 'Clothing' and quantity>=4 
and to_char(sale_date,'YYYY-MM')='2022-11';

---Write a SQL query to calculate the total sales (total_sale) for each category.:

select category,sum(total_sale) as net_sale,count(*) as total_order
from retail_sales
group by category;

---Write a SQL query to find the average age of customers 
--who purchased items from the 'Beauty' category.:

select round(avg(age),2) from retail_sales
where category='Beauty';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales
where total_sale>1000;


--Write a SQL query to find the total number of transactions (transaction_id) 
--made by each gender in each category.:

select category,gender,count(*) as tot_trans
from retail_sales
group by 1,2
order by 1;

---Write a SQL query to calculate the average sale for each month.
--Find out best selling month in each year:

select year,month,avg_sale from 
(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from
retail_sales
group by 1,2
)as t1
where rank =1

---**Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id,max(total_sale)
from retail_sales
group by 1
order by 2
limit 5;

---Write a SQL query to find the number of unique customers who 
--purchased items from each category.:

select category, count(distinct(customer_id)) from retail_sales
group by category;


--Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sales as
(
select *,
case when extract( hour from sale_time)<12 then 'Morning'
     when extract( hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening' 
end as Shift
from retail_sales)
select Shift,count(*) as total_orders from hourly_sales
group by Shift;



 






select * from retail_sales;