-- 1. JUMLAH MASING-MASING TIPE PEMBAYARAN
SELECT 
	opd.payment_type,
	COUNT(1) AS jumlah
FROM order_payments_dataset AS opd 
JOIN orders_dataset AS od on od.order_id = opd.order_id
GROUP BY 1
ORDER BY 2 DESC;

-- 2. DETAIL INFORMASI JUMLAH PENGGUNAAN MASING-MASING TIPE PEMBAYARAN SETIAP TAHUN
WITH tmp AS (
	SELECT 
		date_part('year', od.order_purchase_timestamp) AS tahun,
		opd.payment_type,
		COUNT(1) AS jumlah
	FROM order_payments_dataset AS opd 
	JOIN orders_dataset AS od ON od.order_id = opd.order_id
	GROUP BY 1, 2
) 
SELECT
	payment_type,
  	SUM(CASE WHEN tahun = '2016' THEN jumlah ELSE 0 END) AS tahun_2016,
  	SUM(CASE WHEN tahun = '2017' THEN jumlah ELSE 0 END) AS tahun_2017,
  	SUM(CASE WHEN tahun = '2018' THEN jumlah ELSE 0 END) AS tahun_2018
FROM tmp
GROUP BY 1