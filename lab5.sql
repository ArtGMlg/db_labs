DROP VIEW Purchase_Info;

CREATE VIEW Purchase_Info AS
SELECT 
    p.Code_purchase AS "Код издательства",
    b.Title_book AS "Название книги",
    a.Name_author AS "Имя автора",
    ph.Publish AS "Издательство",
    p.Date_order AS "Дата заказа",
    d.Name_delivery AS "Служба доставки",
    p.Cost AS "Стоимость",
    p.Amount AS "Количество",
    (p.Cost * p.Amount) AS "Итоговая стоимость"
FROM Purchases p
JOIN Books b ON p.Code_book = b.Code_book
JOIN Authors a ON b.Code_author = a.Code_author
JOIN Publishing_house ph ON b.Code_publish = ph.Code_publish
JOIN Deliveries d ON p.Code_delivery = d.Code_delivery;

SELECT * FROM Purchase_Info;
