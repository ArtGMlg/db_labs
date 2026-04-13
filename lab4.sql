-- 1
UPDATE books b SET pages = 300
WHERE b.code_author = 56 AND b.title_book = 'Мемуары';

-- 2
UPDATE purchases p SET "cost" = p."cost" * 1.2
WHERE p.date_order >= CURRENT_DATE - INTERVAL '1 month';

-- 3
INSERT INTO books (code_book, code_author, title_book, pages, code_publish)
VALUES ((SELECT max(b.code_book) FROM books b) + 1, 1, 'Наука. Техника. Инновации', 100, 2);

-- 4
INSERT INTO publishing_house (Code_publish, Publish, City)
VALUES ((SELECT max(ph.code_publish) FROM publishing_house ph) + 1, 'Наука', 'Москва');

-- 5
DELETE FROM purchases WHERE amount = 0;

-- 6
DELETE FROM deliveries WHERE inn IS NULL;