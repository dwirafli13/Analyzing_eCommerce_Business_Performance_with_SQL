-- 1 RATA-RATA MONTHLY ACTIVE USER (MAU) PER TAHUN
WITH active AS(
	SELECT
		date_part('year',od.order_purchase_timestamp) AS tahun,
		date_part('month',od.order_purchase_timestamp) AS bulan,
		COUNT(DISTINCT cd.customer_unique_id) AS jumlah_customer
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
	GROUP BY 1, 2
	ORDER BY 1, 2
)
SELECT
	tahun,
	AVG(jumlah_customer) AS rata2_customer_aktif
FROM active
GROUP BY 1;

-- 2 TOTAL CUSTOMER BARU PER TAHUN
SELECT 
	date_part('year', od.order_purchase_timestamp) AS tahun,
	COUNT(DISTINCT cd.customer_unique_id) AS jumlah_customer_baru
FROM orders_dataset AS od
JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
GROUP BY 1
ORDER BY 1;

-- 3 JUMLAH CUSTOMER YANG MELAKUKAN REPEAT ORDER PER TAHUN
WITH repeat_order AS(
	SELECT
		date_part('year',od.order_purchase_timestamp) AS tahun,
		cd.customer_unique_id,
		COUNT(1) AS jumlah_order
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
	GROUP BY 1,2
	HAVING COUNT(1) > 1
	ORDER BY 1
)
SELECT
	tahun,
	COUNT(1) AS jumlah_customer
FROM repeat_order
GROUP BY 1;

-- 4 RATA-RATA FREKUENSI ORDER UNTUK SETIAP TAHUN
WITH orders AS(
	SELECT
		date_part('year',od.order_purchase_timestamp) AS tahun,
		cd.customer_unique_id,
		COUNT(1) AS jumlah_order
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
	GROUP BY 1,2
	ORDER BY 1
)
SELECT
	tahun,
	AVG(jumlah_order) AS rata2_jumlah_order
FROM orders
GROUP BY 1;