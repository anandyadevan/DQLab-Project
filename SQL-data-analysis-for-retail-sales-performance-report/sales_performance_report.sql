#Chapter 1A
SELECT  YEAR(order_date) years, 
        SUM(sales) sales, 
        COUNT(order_id) number_of_order
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date);

#Chapter 1B
SELECT
	YEAR(order_date) years,
	product_sub_category,
	SUM(sales) sales
FROM dqlab_sales_store
WHERE YEAR(order_date) > 2010
AND order_status = 'Order Finished'
GROUP BY  YEAR(order_date), 
          product_sub_category
ORDER BY  YEAR(order_date) ASC, 
          SUM(sales) DESC;

#Chapter 2
SELECT  YEAR(order_date) years,
	      SUM(sales) sales,
	      SUM(discount_value) promotion_value,
	       ROUND((SUM(discount_value)/SUM(sales))*100,2) burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date);

#Chapter 3
SELECT  YEAR(order_date) years,
	      product_sub_category,
      	product_category,
	      SUM(sales) sales,
	      SUM(discount_value) promotion_value,
	      ROUND((SUM(discount_value)/SUM(sales))*100,2) burn_rate_percentage
FROM dqlab_sales_store
WHERE YEAR(order_date) = 2012 AND 
	    order_status = 'Order Finished'
GROUP BY  YEAR(order_date),
          product_sub_category,
          product_category
ORDER BY SUM(sales) DESC;

#Chapter 4
SELECT  YEAR(order_date) years,
	      COUNT(DISTINCT customer) number_of_customer
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date);
