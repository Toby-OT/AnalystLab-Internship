-- Query 1: View all customers
SELECT * FROM customer;

-- Query 2: Select specific customer columns (name and country)
SELECT first_name, last_name, country 
FROM customer;

-- Query 3: Filter customers by country (Canada)
SELECT first_name, last_name, country 
FROM customer
WHERE country = 'Canada';

-- Query 4: Filter by country and sort alphabetically by last name
SELECT first_name, last_name, country 
FROM customer
WHERE country = 'Canada'
ORDER BY last_name ASC;

-- Query 5: Filter tracks priced above 0.99, sorted by price descending
SELECT name, unit_price
FROM track
WHERE unit_price > 0.99
ORDER BY unit_price DESC;

-- Query 6: Count total number of invoices
SELECT COUNT(*) FROM invoice;

-- Query 7: Total sales revenue grouped by billing country
SELECT billing_country, SUM(total) AS total_sales
FROM invoice
GROUP BY billing_country
ORDER BY total_sales DESC;

-- Query 8: Countries with more than 5 invoices
SELECT billing_country, COUNT(*) AS invoice_count
FROM invoice
GROUP BY billing_country
HAVING COUNT(*) > 5
ORDER BY invoice_count DESC;

-- Query 9: Join invoices with customer names, sorted by highest invoice total
SELECT i.invoice_id, c.first_name, c.last_name, i.total
FROM invoice i
INNER JOIN customer c ON i.customer_id = c.customer_id
ORDER BY i.total DESC
LIMIT 10;

-- Query 10: Join invoice lines, invoices, customers, and tracks to see what each customer bought
SELECT c.first_name, c.last_name, t.name AS track_name, il.unit_price
FROM invoice_line il
JOIN invoice i ON il.invoice_id = i.invoice_id
JOIN customer c ON i.customer_id = c.customer_id
JOIN track t ON il.track_id = t.track_id
LIMIT 10;

-- Query 11: Left join to show all customers, including those with no invoices
SELECT c.first_name, c.last_name, i.invoice_id
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
ORDER BY i.invoice_id;

-- Query 12: Find invoices above the average invoice total (using a subquery)
SELECT invoice_id, customer_id, total
FROM invoice
WHERE total > (SELECT AVG(total) FROM invoice)
ORDER BY total DESC;

-- Query 13: Total spent per customer, using a subquery to join with customer names
SELECT c.first_name, c.last_name, sub.total_spent
FROM customer c
JOIN (
    SELECT customer_id, SUM(total) AS total_spent
    FROM invoice
    GROUP BY customer_id
) sub ON c.customer_id = sub.customer_id
ORDER BY sub.total_spent DESC
LIMIT 10;

-- Query 14: Customers who purchased Rock tracks
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
    SELECT i.customer_id
    FROM invoice i
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name = 'Rock');

-- Query 15; Assign a row number to tracks within each album, ordered by price descending
SELECT album_id, name, unit_price,
ROW_NUMBER() OVER (PARTITION BY album_id ORDER BY unit_price DESC) AS row_num
FROM track;

-- Query 16; Rank customers by total amount spent
SELECT c.first_name, c.last_name,SUM(i.total) AS total_spent,
	RANK() OVER (ORDER BY SUM(i.total) DESC) AS spend_rank
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY spend_rank;

-- Query 17; Running total of invoice amounts per country, ordered by date
SELECT billing_country, invoice_date, total,
	SUM(total) OVER (PARTITION BY billing_country ORDER BY invoice_date) AS running_total
	FROM invoice
	ORDER BY billing_country, invoice_date;

-- Query 18; Top 10 tracks by total revenue generated
SELECT t.name AS track_name, SUM(il.unit_price * il.quantity) AS revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
GROUP BY t.name
ORDER BY revenue DESC
LIMIT 10;

-- Query 19; Top 10 customers by total amount spent
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Query 20; Total revenue per year
SELECT EXTRACT(YEAR FROM invoice_date) AS year, SUM(total) AS yearly_revenue
FROM invoice
GROUP BY EXTRACT(YEAR FROM invoice_date)
ORDER BY year;

-- Query 21; Average invoice amount per customer
SELECT c.first_name, c.last_name, AVG(i.total) AS avg_order_value, COUNT(i.invoice_id) AS num_orders
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY avg_order_value DESC
LIMIT 10;

-- Query 22; Total revenue by product line
SELECT productline, SUM(sales) AS total_revenue
FROM sales 
GROUP BY productline
ORDER BY total_revenue DESC;

-- Query 23; Total revenue per year
SELECT year_id, SUM(sales) AS yearly_revenue
FROM sales
GROUP BY year_id
ORDER BY year_id;

-- Query 24; Top 10 customers by total sales
SELECT customername, SUM(sales) AS total_spent
FROM sales
GROUP BY customername
ORDER BY total_spent DESC
LIMIT 10;

-- Query 25; Count of orders by deal size category
SELECT dealsize, COUNT(*) AS order_count, SUM(sales) AS total_revenue
FROM sales
GROUP BY dealsize
ORDER BY  tOtal_revenue DESC;

-- Query 26; Total sales by country
SELECT country, SUM(sales) AS total_sales
FROM sales
GROUP BY country
ORDER BY total_sales DESC
LIMIT 10;

-- Query 27; Add an index to speed up lookups on customer_id in invoice table
CREATE INDEX idx_invoice_customer_id ON invoice(customer_id);

-- Query 28; Add an index on billing_country for faster country-based filtering
CREATE INDEX idx_invoice_billing_country ON invoice(billing_country);