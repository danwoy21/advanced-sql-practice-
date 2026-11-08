-- Menampilkan produk termahal tiap kategori 
-- Produk dgn harga yang sama ditampilkan keduanya (atau lebih) 

WITH ranked_products AS (
SELECT p.category, p.product_name, p.price,
RANK() OVER (PARTITION BY p.category ORDER BY p.price DESC) AS rnk
FROM products_lat p
)
SELECT * FROM ranked_products
WHERE rnk = 1;


-- Tidak perlu join, yowes langsung aja pake windows funtion (lebih natural) 
-- Karena Lateral lebih dekat dgn JOIN 
