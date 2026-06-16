CREATE OR REPLACE TABLE `final-project-493903.robotic.joined_robotic_data`
AS
SELECT
  o.order_id,
  o.date AS order_date,
  o.quantity,
  -- Data Pelanggan
  c.customer_id,
  TRIM(CONCAT(COALESCE(c.first_name, ''), ' ', COALESCE(c.last_name, '')))
    AS customer_name,
  c.customer_email,
  c.customer_phone,
  c.customer_address,
  c.customer_city,
  c.customer_state,
  c.customer_zip,
  -- Data Produk
  p.prod_number,
  COALESCE(p.prod_name, 'Unknown Product') AS product_name,
  p.price,
  -- Data Kategori
  pc.category_id,
  COALESCE(pc.category_name, 'Unknown Category') AS category_name,
  pc.category_abbreviation,
  -- Kalkulasi
  (o.quantity * p.price) AS total_revenue
FROM `final-project-493903.robotic.orders` AS o
LEFT JOIN `final-project-493903.robotic.customers` AS c
  ON o.customer_id = c.customer_id
LEFT JOIN `final-project-493903.robotic.products` AS p
  ON o.prod_number = p.prod_number
LEFT JOIN `final-project-493903.robotic.product_category` AS pc
  ON p.category = pc.category_id
WHERE o.quantity > 0;

