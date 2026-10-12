SELECT
  name_author,
  UPPER(name_author) AS upper_name,
  LOWER(name_author) AS lower_name
FROM Authors;

SELECT
  Title_book,
  LENGTH(RTRIM(Title_book)) AS title_length
FROM Books;

SELECT
  CONCAT(
    RTRIM(a.name_author),
    ' — ',
    RTRIM(b.Title_book)
  ) AS author_and_book
FROM Authors a
JOIN Books b
  ON a.Code_author = b.Code_author;

SELECT
  Title_book,
  REPLACE(Title_book, 'Наука', 'Science') AS new_title
FROM Books
WHERE Title_book LIKE '%Наука%';

SELECT
  Title_book,
  SUBSTRING(RTRIM(Title_book) FROM 1 FOR 5) AS short_title
FROM Books;

SELECT
  Publish,
  TRIM(Publish) AS cleaned_publish
FROM Publishing_house;

SELECT
  name_author,
  SPLIT_PART(TRIM(name_author), ' ', 1) AS surname,
  SPLIT_PART(TRIM(name_author), ' ', 2) AS first_name
FROM Authors;
