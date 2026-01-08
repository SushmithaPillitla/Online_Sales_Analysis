use online_sales
select top 5 * from sales;

1.How much revenue has the business generated overall?
select 
    SUM(total_revenue) as total_business_revenue
from sales;	

2.Which category contributes most to business income?
SELECT 
    product_category,
    SUM(total_revenue) AS category_revenue
FROM sales
GROUP BY product_category
ORDER BY category_revenue DESC;


3.Which products sell the highest quantity?
SELECT 
    product_name,
    SUM(units_sold) AS total_units_sold
FROM sales
GROUP BY product_name
ORDER BY total_units_sold DESC;

4.Which geographical region performs best?
SELECT 
    region,
    SUM(total_revenue) AS region_revenue
FROM sales
GROUP BY region
ORDER BY region_revenue DESC;

5.How does revenue change month by month?
SELECT 
    FORMAT(date,'yyyy-MM') AS month,
    SUM(total_revenue) AS monthly_revenue
FROM sales
GROUP BY FORMAT(date,'yyyy-MM')
ORDER BY month;

6.What payment option do customers prefer?
SELECT 
    payment_method,
    COUNT(*) AS transaction_count
FROM sales
GROUP BY payment_method
ORDER BY transaction_count DESC;
   
7.How much does a customer spend per transaction on average?
SELECT 
    AVG(total_revenue) AS avg_spend_per_transaction
FROM sales;

8.Which category has the highest demand? ## (demand == totalunit sold)
SELECT 
    product_category,
    SUM(units_sold) AS total_units_sold   
FROM sales
GROUP BY product_category
ORDER BY total_units_sold DESC;

9.Where do customers spend more per order?
SELECT 
    region,
    AVG(total_revenue) AS avg_order_value
FROM sales
GROUP BY region
ORDER BY avg_order_value DESC;

10.Top-performing products inside each category.(based on highest revenue)
SELECT *
FROM (
    SELECT 
        product_category,
        product_name,
        SUM(total_revenue) AS product_revenue,
        RANK() OVER (
            PARTITION BY product_category 
            ORDER BY SUM(total_revenue) DESC
        ) AS rank_in_category
    FROM sales
    GROUP BY product_category, product_name
) ranked_products
WHERE rank_in_category = 1;
