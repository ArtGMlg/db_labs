-- 1
SELECT 
    Name_delivery,
    INN,
    Phone,
    Address,
    Code_delivery
FROM Deliveries;

-- 2
SELECT 
    b.Title_book,
    b.Pages,
    a.Name_author
FROM Books b
JOIN Authors a 
    ON b.Code_author = a.Code_author;

-- 3
SELECT 
    Name_company,
    Phone,
    INN
FROM Deliveries
WHERE Name_company LIKE 'ОАО%';

-- 4
SELECT
  ph.publish
FROM publishing_house ph
WHERE ph.city NOT LIKE '%Москва%';

-- 5
SELECT
  b.title_book
FROM books b
JOIN publishing_house ph
  ON b.code_publish = ph.code_publish 
WHERE ph.publish NOT LIKE '%Питер%';

-- 6
SELECT
  a.name_author 
FROM authors a 
WHERE a.birthday BETWEEN '1840-01-01' AND '1860-06-01';

-- 7
SELECT 
  b.title_book,
  b.pages 
FROM books b
WHERE b.pages BETWEEN 200 AND 300;

-- 8
SELECT Name_author
FROM Authors
WHERE Name_author ~ '^[В-Г]';

-- 9
SELECT 
  b.title_book,
  p.amount
FROM books b
JOIN purchases p
  ON p.code_book = b.code_book
WHERE p.code_delivery IN (3,7,9,11);

-- 10
SELECT
  b.title_book
FROM books b
JOIN publishing_house ph
  ON ph.code_publish = b.code_publish
WHERE ph.publish IN ('Питер', 'Альфа', 'Наука');

-- 11
SELECT
  a.name_author 
FROM authors a
WHERE a.name_author LIKE 'К%';

-- 12
SELECT
  d.name_company
FROM deliveries d
WHERE d.name_company LIKE '%ский';

-- 13
SELECT 
  ph.publish
FROM publishing_house ph
WHERE ph.publish LIKE '%софт%';

-- 14
SELECT 
  p.code_delivery,
  p.date_order,
  b.title_book
FROM purchases p
JOIN books b
  ON b.code_book = p.code_book
WHERE p.amount > 100 OR p."cost" BETWEEN 200 AND 500;

-- 15
SELECT
  ph.publish
FROM publishing_house ph
JOIN books b 
  ON b.code_publish = ph.code_publish 
WHERE b.title_book LIKE 'Труды%' AND ph.city = 'Новосибирск';

-- 16
SELECT 
  d.name_company,
  b.title_book 
FROM (purchases p JOIN deliveries d ON p.code_delivery = d.code_delivery) JOIN books b ON p.code_book = b.code_book
WHERE p.date_order BETWEEN '2002-01-01' AND '2003-12-31';

-- 17
SELECT 
  d.name_company
FROM deliveries d
JOIN purchases p 
  ON d.code_delivery = p.code_delivery
JOIN books b
  ON p.code_book = b.code_book
JOIN publishing_house ph
  ON b.code_publish = ph.code_publish
WHERE ph.publish = 'Питер';

-- 18
SELECT
  b.title_book,
  (b.pages / p."cost") AS "page cost"
FROM purchases p
JOIN books b 
  ON b.code_book = p.code_book;

-- 19 
SELECT
  a.name_author,
  EXTRACT(YEAR FROM AGE(a.birthday)) AS age
FROM authors a;


