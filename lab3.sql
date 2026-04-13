-- 1
SELECT 
  b.code_book,
  b.title_book,
  b.pages
FROM books b
ORDER BY b.title_book ASC, b.pages DESC;

-- 2
SELECT
  d.name_company,
  b.title_book 
FROM purchases p
JOIN deliveries d
  ON p.code_delivery = d.code_delivery
JOIN books b
  ON p.code_book = b.code_book
WHERE p.date_order BETWEEN '2002-01-01' AND '2003-12-31';

-- 3
SELECT
  b.title_book,
  SUM(p."cost"  * p.amount) AS total
FROM purchases p 
JOIN books b 
  ON b.code_book = p.code_book
GROUP BY b.title_book;

-- 4
SELECT
  SUM(p."cost") AS total_sum
FROM purchases p 
JOIN deliveries d 
  ON d.code_delivery = p.code_delivery 
WHERE d.name_company = 'СпидЛог';

-- 5
SELECT 
  AVG(p."cost") AS avg_cost,
  AVG(p.amount ) AS avg_amount
FROM purchases p 
JOIN books b 
  ON b.code_book = p.code_book
JOIN authors a 
  ON b.code_author = a.code_author
WHERE a.name_author LIKE '%Пушкин%';

-- 6
SELECT
  b.title_book
FROM books b
WHERE b.pages > (
  SELECT AVG(b2.pages ) FROM books b2
);

-- 7
SELECT
  a.name_author 
FROM authors a
WHERE age(a.birthday) < (
  SELECT avg(age(a2.birthday)) FROM authors a2
);

-- 8
SELECT
  b.title_book
FROM books b
WHERE b.pages = (
  SELECT MIN(b2.pages ) FROM books b2
);

-- 9
SELECT 
  b.title_book 
FROM books b 
WHERE b.code_book IN (SELECT p.code_book FROM purchases p );

-- 10
SELECT
  a.name_author 
FROM authors a 
WHERE a.code_author NOT IN (SELECT b.code_author FROM books b);