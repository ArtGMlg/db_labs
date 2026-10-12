SELECT *
FROM Authors
WHERE name_author ~ '^П';

SELECT *
FROM Books
WHERE Title_book ~* 'наука';

SELECT *
FROM Publishing_house
WHERE RTRIM(Publish) ~ 'ие$';

SELECT *
FROM Deliveries
WHERE INN ~ '^([0-9]{10}|[0-9]{12})$';

SELECT *
FROM Books
WHERE Title_book ~ '[0-9]';
