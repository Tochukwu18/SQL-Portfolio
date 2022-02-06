'proof that table successfully imported'
show tables in portfolio

'checking all columns in dataset and creating indexes to help retrieve data from table faster'
select * from supermarket;
create index i_quantity on supermarket (quantity)
create index i_price on supermarket (price)

'checking for distinct values in categorical columns'
select distinct(Branch) from supermarket
select distinct(City) from supermarket
select distinct(Customer type) from supermarket
select distinct(Gender) from supermarket
select distinct(Product line) from supermarket

'using select distinct (invoice), we discovered it has 1000 rows which is same as the total rows on dataset meaning it is a primary key column'
SELECT distinct(invoice)FROM supermarket;

'following this discovery, we changed the data type and then made it a primary key'
alter table supermarket modify column invoice varchar (50);
alter table supermarket add primary key (invoice)

'grouping rows by categorical columns'
SELECT 
    city,
    COUNT(*) AS 'City Count',
    ROUND(SUM(Price), 1) AS 'Total Price',
    SUM(Quantity) AS 'Total Quantity',
    ROUND(AVG(Total), 1) AS 'Average Total',
    ROUND(SUM(cogs), 1) AS 'Total cogs',
    ROUND(SUM(gross_income), 1) AS 'Total Gross Income',
    ROUND(AVG(Rating), 1) AS 'average rating'
FROM
    supermarket
GROUP BY city;
SELECT 
    Customer_type,
    COUNT(*) AS 'City Count',
    ROUND(SUM(Price), 1) AS 'Total Price',
    SUM(Quantity) AS 'Total Quantity',
    ROUND(AVG(Total), 1) AS 'Average Total',
    ROUND(SUM(cogs), 1) AS 'Total cogs',
    ROUND(SUM(gross_income), 1) AS 'Total Gross Income',
    ROUND(AVG(Rating), 1) AS 'average rating'
FROM
    supermarket
GROUP BY Customer_type;
SELECT 
    branch,
    COUNT(*) AS 'City Count',
    ROUND(SUM(Price), 1) AS 'Total Price',
    SUM(Quantity) AS 'Total Quantity',
    ROUND(AVG(Total), 1) AS 'Average Total',
    ROUND(SUM(cogs), 1) AS 'Total cogs',
    ROUND(SUM(gross_income), 1) AS 'Total Gross Income',
    ROUND(AVG(Rating), 1) AS 'average rating'
FROM
    supermarket
GROUP BY branch;
SELECT 
    gender,
    COUNT(*) AS 'City Count',
    ROUND(SUM(Price), 1) AS 'Total Price',
    SUM(Quantity) AS 'Total Quantity',
    ROUND(AVG(Total), 1) AS 'Average Total',
    ROUND(SUM(cogs), 1) AS 'Total cogs',
    ROUND(SUM(gross_income), 1) AS 'Total Gross Income',
    ROUND(AVG(Rating), 1) AS 'average rating'
FROM
    supermarket
GROUP BY gender;
SELECT 
    product,
    COUNT(*) AS 'City Count',
    ROUND(SUM(Price), 1) AS 'Total Price',
    SUM(Quantity) AS 'Total Quantity',
    ROUND(AVG(Total), 1) AS 'Average Total',
    ROUND(SUM(cogs), 1) AS 'Total cogs',
    ROUND(SUM(gross_income), 1) AS 'Total Gross Income',
    ROUND(AVG(Rating), 1) AS 'average rating'
FROM
    supermarket
GROUP BY product;

'Total column is obtained by multiplying the price, quantity and gross income percentage'
SELECT 
    city,
    Price,
    Quantity,
    Total,
    ROUND((Price * Quantity * 1.04761904762), 2) AS 'Total Sales'
FROM
    supermarket;
    
'Classifying sales into high and low purchase';
SELECT DISTINCT
    Branch,
    City,
    Customer_type,
    Gender,
    Product,
    Quantity,
    Price,
    CASE
        WHEN quantity >= 7 AND Price >= 50 THEN 'High Purchase'
        ELSE 'Low Purchase'
    END AS 'Type of Purchase'
FROM
    supermarket;
    
'creating view for rolling sales and quantity in the city of mandalay, yangon and'
create view Mandalay_sales as 
SELECT 
    Branch,City,Customer_type,Gender,Product,Price,Quantity,Date, round(sum(Price) over (partition by city order by Date),2) as 'rolling sales',round(sum(Quantity) over (partition by city order by Date),2) as 'rolling Quantity'
FROM
    supermarket where City='Mandalay';

create view Yangon_sales as     
SELECT 
    Branch,City,Customer_type,Gender,Product,Price,Quantity,Date, round(sum(Price) over (partition by city order by Date),2) as 'rolling sales',round(sum(Quantity) over (partition by city order by Date),2) as 'rolling Quantity'
FROM
    supermarket where City='Yangon';

create view Naypyitaw_sales as
SELECT 
    Branch,City,Customer_type,Gender,Product,Price,Quantity,Date, round(sum(Price) over (partition by city order by Date),2) as 'rolling sales',round(sum(Quantity) over (partition by city order by Date),2) as 'rolling Quantity'
FROM
    supermarket where city like 'n%';