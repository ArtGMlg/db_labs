CREATE ROLE user_librarian
WITH
    LOGIN
    PASSWORD 'LibPass123!';

CREATE ROLE user_viewer
WITH
    LOGIN
    PASSWORD 'ViewPass123!';



-- Права библиотекаря

GRANT SELECT, INSERT, UPDATE
ON books
TO user_librarian;

GRANT SELECT, INSERT, UPDATE
ON authors
TO user_librarian;

GRANT SELECT, INSERT, UPDATE
ON purchases
TO user_librarian;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO user_librarian;



-- Права просмотрщика

GRANT SELECT
ON books
TO user_viewer;

GRANT SELECT
ON authors
TO user_viewer;

GRANT SELECT
ON purchases
TO user_viewer;