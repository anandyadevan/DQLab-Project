#Cek Data
SELECT * FROM orders_1 LIMIT 5;
SELECT * FROM orders_2 LIMIT 5;
SELECT * FROM customer LIMIT 5;

#Chapter 1A
SELECT  SUM(quantity) total_penjualan, 
        SUM(quantity*priceEach) revenue
FROM orders_1
WHERE status = 'Shipped';

SELECT  SUM(quantity) total_penjualan,
	      SUM(quantity*priceEach) revenue
FROM orders_2
WHERE status = 'Shipped';

#Chapter 1B
SELECT  quarter, 
        SUM(quantity) total_penjualan, 
        SUM(quantity*priceEach) revenue
FROM (
  SELECT orderNumber, status, quantity, priceEach, "1" AS quarter
  FROM orders_1
  UNION
  SELECT orderNumber, status, quantity, priceEach, "2" AS quarter
  FROM orders_2) 
AS tabel_a
WHERE status = 'Shipped'
GROUP BY quarter;

#Chapter 2
SELECT  quarter, 
        COUNT(DISTINCT customerID) total_customers
FROM (
  SELECT customerID, createDate, QUARTER(CreateDate) quarter
  FROM customer
  WHERE createDate BETWEEN "2004-01-01" AND "2004-06-30") 
AS tabel_b
GROUP BY quarter;

#Chapter 3
SELECT  quarter, 
        COUNT(customerID) total_customers
FROM (
  SELECT customerID, createDate, QUARTER(CreateDate) quarter
  FROM customer
  WHERE createDate BETWEEN "2004-01-01" AND "2004-06-30") 
AS tabel_b
WHERE customerID IN (
    SELECT DISTINCT(customerID) FROM orders_1
    UNION
    SELECT DISTINCT(customerID) FROM orders_2) 
GROUP BY quarter;

#Chapter 4
SELECT * 
FROM (
  SELECT categoryID, 
         COUNT(DISTINCT orderNumber) total_order, 
         SUM(quantity) total_penjualan 
  FROM( 
    SELECT productCode, orderNumber, quantity, status, LEFT(productCode,3) categoryID 
    FROM orders_2
    WHERE status = 'Shipped') 
  AS tabel_c
  GROUP BY categoryID) 
AS c
ORDER BY total_order DESC;

#Chapter 5
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) AS total_customers 
FROM orders_1;

SELECT  "1" quarter, 
        COUNT(DISTINCT customerID)*100/25 AS Q2 
FROM orders_1
WHERE orders_1.customerID IN(
  SELECT DISTINCT customerID FROM orders_2
);
