SELECT
  Code_book,
  Title_book,
  Code_author,
  Pages,
  ROW_NUMBER() OVER (
    PARTITION BY Code_author
    ORDER BY Pages
  ) AS book_number
FROM Books;

SELECT
  a.Code_author,
  a.name_author,
  SUM(b.Pages) AS total_pages,
  RANK() OVER (
    ORDER BY SUM(b.Pages) DESC
  ) AS author_rank
FROM Authors a
JOIN Books b
  ON a.Code_author = b.Code_author
GROUP BY a.Code_author, a.name_author;

SELECT
  Code_purchase,
  Date_order,
  Cost,
  Amount,
  Cost * Amount AS purchase_total,
  SUM(Cost * Amount) OVER (
    ORDER BY Date_order, Code_purchase
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_total
FROM Purchases;

SELECT
  Code_purchase,
  Date_order,
  Cost,
  LAG(Cost) OVER (
    ORDER BY Date_order, Code_purchase
  ) AS previous_cost,
  Cost - LAG(Cost) OVER (
    ORDER BY Date_order, Code_purchase
  ) AS cost_difference
FROM Purchases;

SELECT
  b.Code_book,
  b.Title_book,
  p.Publish,
  b.Pages,
  AVG(b.Pages) OVER (
    PARTITION BY b.Code_publish
  ) AS avg_pages,
  b.Pages - AVG(b.Pages) OVER (
    PARTITION BY b.Code_publish
  ) AS difference_from_average
FROM Books b
JOIN Publishing_house p
  ON b.Code_publish = p.Code_publish;
