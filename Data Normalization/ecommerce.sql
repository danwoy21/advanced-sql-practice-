UNF (Unnormalized Form):
-- Wide format table
CREATE TABLE transactions (
    order_id INT, 
    customer_name VARCHAR, 
    customer_email VARCHAR,
    product_1 VARCHAR(50), 
    product_2 VARCHAR(50), 
    product_3 VARCHAR(50),
    order_date DATE
);

INSERT INTO transactions VALUES
(1, 'Andi', 'andi@gmail.com', 'Laptop', 'Mouse', 'Keyboard', '2026-11-01'),
(2, 'Budi', 'budi@gmail.com', 'Laptop', 'Headset', NULL, '2026-11-02');
    

1NF (First Normal Form):
-- Transforming wide into long format table 
CREATE TABLE transactions_1nf (
    order_id INT, 
    customer_name VARCHAR(50),
    customer_email VARCHAR(100),
    product_name VARCHAR(50), 
    order_date DATE
);

INSERT INTO transactions_1nf VALUES
(1, 'Andi', 'andi@gmail.com', 'Laptop', '2026-11-01'),
(1, 'Andi', 'andi@gmail.com', 'Mouse', '2026-11-01'),
(1, 'Andi', 'andi@gmail.com', 'Keyboard', '2026-11-01'),
(2, 'Budi', 'budi@gmail.com', 'Laptop', '2026-11-02'),
(2, 'Budi', 'budi@gmail.com', 'Headset', '2026-11-02');
  

2NF:
-- Unnormalized 2nf:
CREATE TABLE order_details (
    order_id INT, 
    product_id INT, 
    customer_name VARCHAR, -- bergantung pada order_id -> partial dependecy (harus dihindari)
    product_name VARCHAR, -- bergantung pada product_id -> partial dependecy (harus dihindari)
    quantity INT -- bergantung pada (order_id, product_id) (syarat 2nf, non-key bergantung pada composite key)
);

-- Normalized 2NF:
-- Decompose into 3 tables (orders, products, order_details) 
CREATE TABLE orders (
    order_id INT PRIMARY KEY, 
    customer_name VARCHAR
);

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY, 
    product_name VARCHAR
);

CREATE TABLE order_details (
    order_id INT,
    product_id VARCHAR(10),  
    quantity INT,

    PRIMARY KEY (order_id, product_id),
  
    FOREIGN KEY (order_id) REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id)
); -- memenuhi 2nf karena kolom non-key (quantity) bergantung pada composite key (order_id, product_id)
-- tidak ada lagi kolom non-key yg hanya bergantung pada sebagian key dalam composite key
    
