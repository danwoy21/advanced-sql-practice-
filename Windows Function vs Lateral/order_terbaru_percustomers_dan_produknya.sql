tampilkan seluruh customer beserta informasi transaksi terakhirnya.

Ketentuan:
- Tampilkan nama customer.
- Tampilkan order ID terakhir.
- Tampilkan nama produk.
- Tampilkan tanggal transaksi.
- Customer tanpa transaksi tetap ditampilkan. -> LEFT JOIN 

SELECT c.customer_name, latest.order_id, latest.product_name, latest.order_date 
FROM customers c 
LEFT JOIN LATERAL (
    SELECT 
        o.order_id, p.product_name, o.order_date 
    FROM orders o 
    JOIN products p 
        ON o.product_id = p.product_id 
    WHERE o.customer_id = c.customer_id 
    ORDER BY o.order_date DESC, o.order_id DESC 
    LIMIT 1 
    ) AS latest ON TRUE; 

-- lateral itu bekerja per-baris, dari tabel kiri customers (id 1) -> lalu mencari id 1 di tabel kanan orders, 
-- lalu sql mengambil data orders milik id 1 tsb 
-- cara kerja tsb, lateral itu otomatis meng-grouping data berdasarkan customers 

-- di windows grouping itu pakai PARTITION BY 
-- di lateral grouping itu pakai cara kerja lateral itu sendiri (ambil data perbaris dari tabel kiri ke table kanan) -> WHERE o.customer_id = c.customer_id

