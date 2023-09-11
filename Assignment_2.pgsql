-- Query 1 WITH SELECT , JOIN, WHERE 
SELECT
	*
FROM
	store s
	JOIN address ad ON s.address_id = ad.address_id
	JOIN staff sf ON sf.staff_id = s.manager_staff_id

--Query 2 With SUM, MAX, MIN, AVG, COUNT , STDDEV, VARIANCE
SELECT
	SUM(amount) AS total_income,
	MAX(amount) AS higest_payment,
	MIN(amount) AS lowest_payment,
	AVG(amount) AS average_payment,
	COUNT(payment_id) AS total_num_payment,
	STDDEV(amount) AS standard_diviation_amount,
	VARIANCE(amount) AS variance_amount
FROM
	payment;

--Query 3 With GROUP BY, ORDER BY, HAVING
SELECT
	customer_id,
	COUNT(rental_id) AS total_rental,
	MAX(rental_date)
FROM
	rental r
GROUP BY
	r.customer_id
HAVING
	COUNT(r.inventory_id) > 1
ORDER BY
	customer_id

--Query 4 With NOT IN , EXTRACT(DAY-YEAR), CORR
SELECT
	CONCAT(first_name, ' ', last_name) AS NAME,
	EXTRACT(
		YEAR
		FROM
			last_update
	) as Onboard_YEAR
FROM
	staff
WHERE
	store_id NOT IN (
		(
			SELECT
				store_id
			FROM
				store
			WHERE
				store_id = 3
				AND NOT NULL
		)
	)

--Query 5 CTE 
WITH
	non_active_user AS (
		SELECT
			customer_id
		FROM
			customer
		WHERE
			active = 0
	)
SELECT
	r.rental_id,
	c.first_name,
	c.last_name,
	r.rental_date
FROM
	rental r
	JOIN non_active_user n ON r.customer_id = n.customer_id
	JOIN customer c ON c.customer_id = n.customer_id;

--Query 6 CASE WHEN 
SELECT
	CONCAT(first_name, ' ', last_name) AS NAME,
	CASE
		WHEN COUNT(film_id) > 20 THEN 'Famous'
		WHEN COUNT(film_id) > 10 THEN 'Competent'
		ELSE 'Freshman'
	END AS Reputation,
	COUNT(film_id) AS total_film_act
FROM
	actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY
	a.actor_id
ORDER BY
	NAME