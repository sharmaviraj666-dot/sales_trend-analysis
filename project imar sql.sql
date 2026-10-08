create database viraj;
use viraj;
show tables;
select * from clean_snitch;
desc clean_snitch;

SELECT
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Units_Sold) AS total_units_sold,
    ROUND(SUM(`sales_amount.1`), 2) AS total_sales,
    ROUND(
        SUM(`sales_amount.1`) /
        NULLIF(COUNT(DISTINCT Order_ID), 0),
        2
    ) AS average_order_value
FROM clean_snitch;

############  profit bt product category ##############
SELECT
    Product_Category,
    ROUND(SUM(`sales_amount.1`), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM clean_snitch
GROUP BY Product_Category
ORDER BY total_profit DESC;

################ sales by city ####################

SELECT
    City,
    ROUND(SUM(`sales_amount.1`), 2) AS total_sales
FROM clean_snitch
GROUP BY City
ORDER BY total_sales DESC
LIMIT 10;

##################### Repeat customers ###################

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT Customer_Name
    FROM clean_snitch
    GROUP BY Customer_Name
    HAVING COUNT(DISTINCT Order_ID) > 1
) AS customer_orders;


############## profit margin #############3

SELECT
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(`sales_amount.1`), 0) * 100,
        2
    ) AS profit_margin_pct
FROM clean_snitch;