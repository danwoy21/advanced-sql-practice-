Tampilkan maksimal dua transaksi terbaru dari setiap customer.

Ketentuan:
- Tampilkan nama customer.
- Tampilkan order ID.
- Tampilkan tanggal transaksi.
- Jika customer hanya memiliki satu transaksi, tampilkan satu transaksi.
- Customer tanpa transaksi tidak perlu ditampilkan. -> inner join



-- Versi Lateral (natural): 
SELECT c.customer_name, latest.order_id, latest.order_date
    FROM customers_lat c
INNER JOIN LATERAL (
    SELECT order_id, order_date
        FROM orders_lat o
    WHERE o.customer_id = c.customer_id
    ORDER BY o.order_date DESC, o.order_id DESC
    LIMIT 2
    ) AS latest ON TRUE;


-- versi windows function (ranking):
WITH ranked_orders AS ( 
    SELECT 
          c.customer_name, 
          o.order_id, 
          o.order_date, 
          ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS rn
    FROM customers_lat c 
    INNER JOIN orders_lat o 
          ON c.customer_id = o.customer_id 
    ) 
SELECT * FROM ranked_orders 
WHERE rn <= 2; 
            

