Customer dengan pembelian di atas rata-rata

Tampilkan transaksi customer yang nilai pembeliannya lebih tinggi daripada rata-rata nilai seluruh transaksi.

WITH nilai_transaksi_customers AS (
    SELECT
        c.customer_name, 
        p.product_name, 
        (o.quantity * p.price) AS nilai_transaksi
    FROM customers c 
        JOIN ON orders o 
            ON o.customer_id = c.customer_id
        JOIN ON products p 
            ON o.product_id = p.product_id 
),

rata_rata AS (
    SELECT AVG(nilai_transaksi) AS rata2_seluruh_transaksi
    FROM nilai_transaksi_customers
    ) 

SELECT ntc.customer_name, ntc.product_name, ntc.nilai_transaksi 
FROM nilai_transaksi_customers ntc
CROSS JOIN rata_rata rt 
WHERE ntc.nilai_transaksi > rt.rata2_seluruh_transaksi;
      
    


