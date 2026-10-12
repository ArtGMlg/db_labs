WITH RECURSIVE fibonacci(n, a, b) AS (
  SELECT 1, 0, 1

  UNION ALL

  SELECT n + 1, b, a + b
  FROM fibonacci
  WHERE n < 10
)
SELECT n, a AS fibonacci_number
FROM fibonacci;

CREATE TABLE Employees (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  manager_id INT REFERENCES Employees(id)
);

INSERT INTO Employees VALUES
(1, 'Анна', NULL),
(2, 'Борис', 1),
(3, 'Виктор', 1),
(4, 'Галина', 2),
(5, 'Дмитрий', 2),
(6, 'Елена', 3);

WITH RECURSIVE employee_tree AS (
  SELECT
    id,
    name,
    manager_id,
    0 AS level
  FROM Employees
  WHERE id = 1

  UNION ALL

  SELECT
    e.id,
    e.name,
    e.manager_id,
    et.level + 1
  FROM Employees e
  JOIN employee_tree et
    ON e.manager_id = et.id
)
SELECT *
FROM employee_tree
ORDER BY level, id;

DROP TABLE Employees;

WITH RECURSIVE calendar AS (
  SELECT DATE '2026-10-01' AS day

  UNION ALL

  SELECT day + 1
  FROM calendar
  WHERE day < DATE '2026-10-31'
)
SELECT
  day,
  EXTRACT(ISODOW FROM day) AS weekday_number
FROM calendar
ORDER BY day;
