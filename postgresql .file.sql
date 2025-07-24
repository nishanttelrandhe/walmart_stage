select * from walmart_stage;

select count (*) from  walmart_stage;

select 
   Payment_method,
   count (*)
from walmart_stage 
   group by Payment_method;
   

select
	count(DISTINCT branch) 
from walmart_stage;


select max(quantity) from walmart_stage;

select min(quantity) from walmart_stage;

--business problem

--Q.1 Find different payment method and number of transactions, number of qty sold

select 
   Payment_method,
   count (*) as no_payments,
   	sum(quantity) as no_qty_sold
from walmart_stage 
   group by Payment_method 

   
--Q.2 Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING

select * 
from
	(select 
		branch,
		category,
		avg(rating) as avg_rating,
		rank() over(partition by branch order by avg(rating) desc) as rank
	from walmart_stage
	group by 1, 2 
)
where rank = 1;


-- Q.3 Identify the busiest day for each branch based on the number of transactions

SELECT branch, day_name, no_transactions
FROM (
  SELECT
    branch,
    TO_CHAR(date::text::date, 'Day') AS day_name,
    COUNT(*) AS no_transactions,
    RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
  FROM walmart_stage
  GROUP BY branch, TO_CHAR(date::text::date, 'Day')
) AS ranked_days
WHERE rank = 1;

--Q.4 Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

select
	 payment_method,
	 sum(quantity) as no_qty_sold
from walmart_stage
group by payment_method

--Q.5 Determine the average, minimum, and maximum rating of category for each city. 
  --List the city, average_rating, min_rating, and max_rating.

 SELECT 
	city,
	category,
	min(rating) as min_rating,
	max(rating) as max_rating,
	avg(rating) as avg_rating
from walmart_stage
group by 1, 2

Q.6 -- Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.
select * from walmart_stage
SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart_stage
GROUP BY category
ORDER BY total_profit DESC;




SELECT 
    category,
    SUM(
        CAST(unit_price AS NUMERIC) *
        CAST(quantity AS NUMERIC) *
        CAST(profit_margin AS NUMERIC)
    ) AS total_profit
FROM walmart_stage
GROUP BY category
ORDER BY total_profit DESC;





-- Q.7 Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices


SELECT
	branch,
CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart_stage
GROUP BY 1, 2
ORDER BY 1, 3 DESC


-- Q.8 Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

WITH cte 
AS
(SELECT 
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart_stage
GROUP BY 1, 2
)
SELECT *
FROM cte
WHERE rank = 1
