-- 1
CREATE OR REPLACE FUNCTION count_books()
RETURNS INT
LANGUAGE plpgsql
AS $$
begin
  return (
    select count(code_book) from books
  );
end;
$$;

SELECT * FROM count_books();

-- 2
CREATE OR REPLACE FUNCTION count_books_pages(count_pages INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COUNT(code_book)
        FROM books
        WHERE pages >= count_pages
    );
END;
$$;

SELECT * FROM count_books_pages(100);

-- 3
CREATE OR REPLACE FUNCTION count_books_title(count_pages int, title char(10))
RETURNS int
LANGUAGE plpgsql
AS $$
begin
  return (
    select count(code_book)
    from books
    where pages >= count_pages and title_book like title
  );
end;
$$;

SELECT * FROM count_books_title(100, 'П%');

-- 4
CREATE OR REPLACE FUNCTION count_books_itogo(
    count_pages INT,
    title_pattern CHAR(10)
)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COUNT(code_book)
        FROM books
        WHERE pages >= count_pages
        AND title_book LIKE title_pattern
    );
END;
$$;

SELECT count_books_itogo(100, 'П%');

-- 5
CREATE OR REPLACE FUNCTION checkname(param INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    author_name TEXT;
BEGIN
    SELECT name_author
    INTO author_name
    FROM authors
    WHERE code_author = param;

    IF author_name = 'Пушкин А.С.' THEN
        RETURN 1;
    ELSE
        RETURN 2;
    END IF;
END;
$$;

SELECT checkname(1);

-- 6
CREATE OR REPLACE PROCEDURE update_proc()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE purchases
    SET code_purchase = code_purchase * 2;
END;
$$;

CALL update_proc();

-- 7
CREATE OR REPLACE FUNCTION select_author(k char(30))
RETURNS TABLE (
  code_author int,
  name_author char(30),
  birthday timestamp
)
LANGUAGE plpgsql
AS $$
begin
  return query select * from authors a where a.name_author = k;
end;
$$;

SELECT * FROM select_author('Пушкин Александр Сегреевич');

-- 8
CREATE OR REPLACE PROCEDURE update_proc_w_param(p INT DEFAULT 2)
LANGUAGE SQL
AS $$
    UPDATE Purchases SET Code_purchase = Code_purchase * p;
$$;

CALL update_proc_w_param(4);

-- 9
CREATE OR REPLACE PROCEDURE count_purchases(
    d1 TIMESTAMP, 
    d2 TIMESTAMP,
    INOUT c INTEGER
)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT COALESCE(COUNT(Code_purchase), 0) INTO c
    FROM Purchases 
    WHERE Date_order BETWEEN d1 AND d2;
END;
$$;

CALL count_purchases('2024-01-01', '2024-12-31', NULL);