WITH total_transaksi_per_customer AS (
    SELECT 
        c.customer_name, 
        SUM(o.quantity*price) AS total_pengeluaran 
    FROM customers_lat c 
    LEFT JOIN orders_lat o 
        ON o.customer_id = c.customer_id 
    JOIN products_lat p 
        ON o.product_id = p.product_id 
    GROUP BY c.customer_id, c.customer_name
),

rata2_seluruh_transaksi AS (
    SELECT AVG(total_pengeluaran) AS rata2_pengeluaran_seluruh_customers
    FROM total_transaksi_per_customer
 ) 

SELECT * FROM total_transaksi_per_customer
CROSS JOIN rata2_seluruh_transaksi
WHERE total_pengeluaran > rata2_pengeluaran_seluruh_customers;
  
