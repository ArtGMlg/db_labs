-- Триггер запрета создания записи о покупке с некорректной ценой
CREATE OR REPLACE FUNCTION fn_check_cost()
RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.cost <= 0 THEN
        RAISE EXCEPTION 'Цена книги должна быть больше 0';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_check_cost
BEFORE INSERT OR UPDATE
ON purchases
FOR EACH ROW
EXECUTE FUNCTION fn_check_cost();

-- Триггер запрета удаления автора пока у него есть книги
CREATE OR REPLACE FUNCTION fn_prevent_author_delete()
RETURNS TRIGGER
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM books b
        WHERE b.code_author = OLD.code_author
    ) THEN
        RAISE EXCEPTION
            'Нельзя удалить автора, у которого есть книги';
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_prevent_author_delete
BEFORE DELETE
ON authors
FOR EACH ROW
EXECUTE FUNCTION fn_prevent_author_delete();


-- Внесем запись с некорректной ценой
INSERT INTO purchases 
(Code_purchase, Code_book, Date_order, Code_delivery, Type_purchase, Cost, Amount)
VALUES
(7, 1, '2024-01-15 10:30:00', 1, B'1', 0, 10);

-- Попробуем удалить пока есть книги
DELETE FROM authors 
WHERE Code_author = 2;

