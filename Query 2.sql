-- 1. REVENUE PER TAHUN
CREATE TABLE total_revenue_per_tahun AS(
	SELECT
		date_part('year', od.order_purchase_timestamp) AS tahun,
		SUM(revenue_per_tahun) AS revenue
	FROM(
		SELECT
			order_id,
			SUM(price+freight_value) AS revenue_per_tahun
		FROM order_items_dataset
		GROUP BY 1
	) rpt
	JOIN orders_dataset AS od ON rpt.order_id = od.order_id
	WHERE od.order_status = 'delivered'
	GROUP BY 1
);

-- 2. JUMLAH CANCEL ORDER PER TAHUN
CREATE TABLE total_cancel_per_tahun AS( 
	SELECT 
		date_part('year', order_purchase_timestamp) AS tahun,
		COUNT(1) AS jumlah_order_cancel
	FROM orders_dataset
	WHERE order_status = 'canceled'
	GROUP BY 1
	ORDER BY 1
);

-- 3. TOP KATEGORI YANG MENGHASILKAN REVENUE TERBESAR PER TAHUN
CREATE TABLE top_kategori_produk_by_revenue_per_tahun AS( 
	SELECT 
		tahun, 
		product_category_name, 
		revenue 
	FROM (
		SELECT 
			date_part('year', od.order_purchase_timestamp) AS tahun,
			pd.product_category_name,
			SUM(oid.price + oid.freight_value) AS revenue,
			RANK() OVER(PARTITION BY 
						date_part('year', od.order_purchase_timestamp) 
					ORDER BY 
						SUM(oid.price + oid.freight_value) DESC) AS rk
		FROM order_items_dataset AS oid
		JOIN orders_dataset AS od on od.order_id = oid.order_id
		JOIN product_dataset AS pd on pd.product_id = oid.product_id
		WHERE od.order_status = 'delivered'
		GROUP BY 1,2
		ORDER BY 1
	) sq
	WHERE rk = 1
);

-- 4. KATEGORI YANG MENGALAMI CANCEL ORDER TERBANYAK PER TAHUN
CREATE TABLE kategori_cancel_order_terbanyak_per_tahun AS( 
	SELECT 
		tahun, 
		product_category_name, 
		jumlah_cancel 
	FROM (
		SELECT 
			date_part('year', od.order_purchase_timestamp) AS tahun,
			pd.product_category_name,
			COUNT(1) AS jumlah_cancel,
			RANK() OVER(PARTITION BY 
						date_part('year', od.order_purchase_timestamp) 
					ORDER BY COUNT(1) DESC) AS rk
		FROM order_items_dataset AS oid
		JOIN orders_dataset AS od ON od.order_id = oid.order_id
		JOIN product_dataset AS pd on pd.product_id = oid.product_id
		WHERE od.order_status = 'canceled'
		GROUP BY 1,2
	) sq
	WHERE rk = 1
);

-- 5
SELECT 
	ta.tahun,
	ta.product_category_name AS top_kategori_produk_by_revenue,
	ta.revenue AS kategori_revenue,
	tb.revenue AS total_revenue_per_tahun,
	tc.product_category_name AS kategori_produk_paling_banyak_cancel,
	tc.jumlah_cancel AS jumlah_kategori_produk_cancel,
	td.jumlah_order_cancel AS jumlah_cancel_order_per_tahun
FROM top_kategori_produk_by_revenue_per_tahun AS ta
JOIN total_revenue_per_tahun AS tb ON ta.tahun = tb.tahun 
JOIN kategori_cancel_order_terbanyak_per_tahun AS tc ON ta.tahun = tc.tahun 
JOIN total_cancel_per_tahun AS td on td.tahun = ta.tahun