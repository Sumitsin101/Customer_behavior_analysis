Create database customer_behavior;
use customer_behavior;
select * from customer;

# Which customer segments generate the highest revenue?

## Gender

SELECT gender AS Gender, SUM(purchase_amount) AS Revenue
FROM customer
GROUP BY gender;

## top 5 Locations

SELECT location, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY location
ORDER BY revenue DESC
LIMIT 5;

## Age group

SELECT age_group , SUM(purchase_amount) AS Revenue
FROM customer
GROUP BY age_group
ORDER BY revenue DESC;

# Which product categories contribute the most to total sales?

SELECT category, SUM(purchase_amount) AS Revenue
FROM customer
GROUP BY category
ORDER BY revenue DESC;

# Top 5 most selling items

SELECT item_purchased, COUNT(*) AS count
FROM customer
GROUP BY item_purchased
ORDER BY count DESC
LIMIT 5;


## Top 5 items with rating lower than the avg rating

SELECT distinct(item_purchased), review_rating AS rating
FROM customer
WHERE review_rating < (SELECT 
            AVG(review_rating)
            FROM
            customer)
ORDER BY rating DESC
LIMIT 5;

# Do promo codes actually increase sales

SELECT promo_code as Discount_or_promo_code, count(*) as Total_customers,
AVG(purchase_amount) as AVG_revenue,SUM(purchase_amount) AS revenue
FROM customer
GROUP BY promo_code
ORDER BY revenue DESC;

# Which seasons drive the highest sales, and for which items?

select season, avg(purchase_amount) as AVG_revenue, sum(purchase_amount) as revenue from customer group by season order by revenue desc limit 5;
SELECT season, item_purchased,AVG(purchase_amount) as AVG_purchase_amount
,SUM(purchase_amount) AS Revenue
FROM customer
GROUP BY season , item_purchased
ORDER BY revenue DESC;

# Does subscription status lead to higher repeat purchases?

SELECT subscription_status, SUM(buy_freq) AS Frequency_of_purchase
FROM customer
GROUP BY subscription_status
ORDER BY Frequency_of_purchase DESC;

# Which shipping method is preferred and does it impact spending?

SELECT shipping_type,count(*) as Total_customers,
AVG(purchase_amount) as AVG_purchase_amount, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY shipping_type
ORDER BY AVG_purchase_amount DESC;

# What payment methods do customers prefer, and 
# which ones lead to higher purchase amounts?

Select payment_method, sum(purchase_amount) as revenue
from customer
group by payment_method
order by revenue desc;

# How do review ratings affect customer purchases?

SELECT review_rating, SUM(buy_freq) AS purchase_frequency
FROM customer
GROUP BY review_rating
ORDER BY purchase_frequency DESC
LIMIT 5;

# top 5 products having the highest percentage of sales with discount applied

SELECT item_purchased,ROUND(100 * SUM(CASE
                WHEN promo_code = 'Yes' THEN 1
                ELSE 0
            END) / COUNT(*), 1) AS percentage_of_sales
FROM customer
GROUP BY item_purchased
ORDER BY percentage_of_sales DESC
LIMIT 5;


