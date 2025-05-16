create database Superstore;
use Superstore;

SELECT *
FROM superstoresales
LIMIT 5;

# What are total sales and total profits of each year?

DESCRIBE superstoresales;
SELECT 
    COALESCE(DATE_FORMAT(MIN(`Order Date`), '%Y-01-01 00:00:00'), '0000-01-01 00:00:00') AS year,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM 
    superstoresales
GROUP BY 
    YEAR(`Order Date`)
ORDER BY 
    year ASC;


#  What are the total profits and total sales per quarter?
SELECT
    YEAR(`Order Date`) AS year,
    CASE
        WHEN MONTH(`Order Date`) IN (1, 2, 3) THEN 'Q1'
        WHEN MONTH(`Order Date`) IN (4, 5, 6) THEN 'Q2'
        WHEN MONTH(`Order Date`) IN (7, 8, 9) THEN 'Q3'
        ELSE 'Q4'
    END AS quarter,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM
    superstoresales
GROUP BY
    year, quarter
ORDER BY
    year, quarter;

# What region generates the highest sales and profits ? 
SELECT 
    region, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profits
FROM 
    superstoresales
GROUP BY 
    region
ORDER BY 
    total_profits DESC;

SELECT 
    region, 
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM 
    superstoresales
GROUP BY 
    region
ORDER BY 
    profit_margin DESC;

# What state and city brings in the highest sales and profits ?
SELECT 
    State, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profits, 
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_mar
FROM 
    superstoresales
GROUP BY 
    State
ORDER BY 
    Total_Profits DESC
LIMIT 10;


# Let’s observe our bottom 10 States:
SELECT 
    State, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profits
FROM 
    superstoresales
GROUP BY 
    State
ORDER BY 
    Total_Profits ASC
LIMIT 10;

#Cities
SELECT 
    City, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profits, 
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_marg
FROM 
    superstoresales
GROUP BY 
    City
ORDER BY 
    Total_Profits DESC
LIMIT 10;



# The relationship between discount and sales and the total discount per category

SELECT 
    Discount, 
    AVG(Sales) AS Avg_Sales
FROM 
    superstoresales
GROUP BY 
    Discount
ORDER BY 
    Discount;
# Let’s observe the total discount per product category
SELECT 
    Category, 
    SUM(Discount) AS Total_Discount
FROM 
    superstoresales
GROUP BY 
    Category
ORDER BY 
    Total_Discount DESC;

# Most discounted subcategories (product type)
SELECT 
    Category, 
    `Sub-Category`, 
    SUM(Discount) AS Total_Discount
FROM 
    superstoresales
GROUP BY 
    Category, `Sub-Category`
ORDER BY 
    Total_Discount DESC;

# What category generates the highest sales and profits in each region and state ?
SELECT 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit, 
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM 
    superstoresales
GROUP BY 
    Category
ORDER BY 
    Total_Profit DESC;

# Highest total sales and profits per Category in each region
SELECT 
    Region, 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    Region, Category
ORDER BY 
    Total_Profit DESC;
# Top Highest total sales and profits per Category in each state
SELECT 
    State, 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    State, Category
ORDER BY 
    Total_Profit DESC;

#Top Lowest total sales and profits per Category in each state
SELECT 
    State, 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    State, Category
ORDER BY 
    Total_Profit ASC;

# What subcategory generates the highest sales and profits in each region and state ?

SELECT 
    `Sub-Category` AS SubCategory,
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit, 
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM 
    superstoresales
GROUP BY 
    `Sub-Category`
ORDER BY 
    Total_Profit DESC;
# Top 15 Subcategories with the highest total sales and total profits in each region
SELECT 
    Region, 
    `Sub-Category` AS SubCategory, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    Region, `Sub-Category`
ORDER BY 
    Total_Profit DESC;
# Top 15 Highest total sales and profits per Subcategory in each state
SELECT 
    State, 
    `Sub-Category` AS SubCategory, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    State, `Sub-Category`
ORDER BY 
    Total_Profit DESC;
# Top 15 Highest total sales and profits per Subcategory in each state
SELECT 
    State, 
    `Sub-Category` AS SubCategory, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    superstoresales
GROUP BY 
    State, `Sub-Category`
ORDER BY 
    Total_Profit ASC;

# What are the names of the products that are the most and least profitable to us?
SELECT 
    `Product Name` AS productname, 
    SUM(Sales) AS total_sales, 
    SUM(Profit) AS total_profit
FROM 
    superstoresales
GROUP BY 
    `Product Name`
ORDER BY 
    total_profit DESC;

# Top 15 less profitable products

SELECT 
    `Product Name` AS productname, 
    SUM(Sales) AS total_sales, 
    SUM(Profit) AS total_profit
FROM 
    superstoresales
GROUP BY 
    `Product Name`
ORDER BY 
    total_profit ASC;
    
# What segment makes the most of our profits and sales ?
SELECT 
    Segment, 
    SUM(Sales) AS total_sales, 
    SUM(Profit) AS total_profit
FROM 
    superstoresales
GROUP BY 
    Segment
ORDER BY 
    total_profit DESC;

#  How many customers do we have (unique customer IDs) in total and how much per region and state?
SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstoresales;

# Total customers per region
SELECT 
    Region, 
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM 
    superstoresales
GROUP BY 
    Region
ORDER BY 
    total_customers DESC;

# Top 15 states with the most customers
SELECT 
    State, 
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM 
    superstoresales
GROUP BY 
    State
ORDER BY 
    total_customers ASC;



# Customer rewards program

SELECT 
    `Customer ID` AS customerid,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM 
    superstoresales
GROUP BY 
    `Customer ID`
ORDER BY 
    total_sales DESC
LIMIT 15;


# Average shipping time per class and in total
SELECT ROUND(AVG(DATEDIFF(`Ship Date`, `Order Date`)), 1) AS avg_shipping_time
FROM superstoresales;


# Average shipping time by shipping mode
SELECT 
    `Ship Mode` AS shipmode, 
    ROUND(AVG(DATEDIFF(`Ship Date`, `Order Date`)), 1) AS avg_shipping_time
FROM 
    superstoresales
GROUP BY 
    `Ship Mode`
ORDER BY 
    avg_shipping_time;




