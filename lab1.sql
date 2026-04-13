DROP TABLE purchases;
DROP TABLE deliveries;
DROP TABLE books;
DROP TABLE publishing_house;
DROP TABLE authors;

CREATE TABLE IF NOT EXISTS authors (
  code_author int PRIMARY KEY,
  name_author char(30),
  birthday timestamp
);

CREATE TABLE IF NOT EXISTS Publishing_house(
  Code_publish INT PRIMARY KEY,
  Publish CHAR(30),
  City CHAR(20)
);

CREATE TABLE IF NOT EXISTS Books(
  Code_book INT PRIMARY KEY,
  Title_book CHAR(40),
  Code_author INT REFERENCES Authors(Code_author),
  Pages INT,
  Code_publish INT REFERENCES Publishing_house(Code_publish)
);

CREATE TABLE IF NOT EXISTS Deliveries(
  Code_delivery INT PRIMARY KEY,
  Name_delivery CHAR(30),
  Name_company CHAR(20),
  Address VARCHAR(100),
  Phone BIGINT,
  INN CHAR(13)
);

CREATE TABLE Purchases(
  Code_purchase INT PRIMARY KEY,
  Code_book INT REFERENCES Books(Code_book),
  Date_order timestamp,
  Code_delivery INT REFERENCES Deliveries(Code_delivery),
  Type_purchase BIT,
  Cost FLOAT,
  Amount INT
);

INSERT INTO Authors (Code_author, Name_author, Birthday) VALUES
(1, 'Толстой Лев Николаевич', '1828-09-09'),
(2, 'Достоевский Фёдор Михайлович', '1821-11-11'),
(3, 'Пушкин Александр Сегреевич', '1799-06-06'),
(4, 'Чехов Антон Павлович', '1860-01-29'),
(5, 'Гоголь Николай Васильевич', '1809-03-31');

INSERT INTO Publishing_house (Code_publish, Publish, City) VALUES
(1, 'Эксмо', 'Москва'),
(2, 'АСТ', 'Москва'),
(3, 'Просвещение', 'Москва'),
(4, 'Азбука', 'Санкт-Петербург'),
(5, 'Питер', 'Санкт-Петербург');

INSERT INTO Books (Code_book, Title_book, Code_author, Pages, Code_publish) VALUES
(1, 'Война и мир', 1, 1225, 1),
(2, 'Преступление и наказание', 2, 671, 2),
(3, 'Евгений Онегин', 3, 224, 4),
(4, 'Вишнёвый сад', 4, 96, 5),
(5, 'Мёртвые души', 5, 432, 3);

INSERT INTO Deliveries (Code_delivery, Name_delivery, Name_company, Address, Phone, INN) VALUES
(1, 'Быстрая доставка', 'ЛогистикПро', 'ул. Ленина, 10, Москва', 79991234567, '7701234567890'),
(2, 'КнигаЭкспресс', 'ЭкспрессЛайн', 'Невский пр., 25, Санкт-Петербург', 79876543210, '7809876543210'),
(3, 'СкороШип', 'СпидЛог', 'ул. Тверская, 5, Москва', 79771234567, '7712345678901'),
(4, 'ЧитайДоставка', 'БукЛогистик', 'ул. Арбат, 12, Москва', 79661234567, '7723456789012'),
(5, 'ЛитерПочта', 'ПочтаСервис', 'ул. Садовая, 7, Санкт-Петербург', 79551234567, '7734567890123'),
(6, 'СтандартДоставка', 'ОАО ЛогистикаПлюс', 'ул. Центральная, 15, Москва', 79001234567, '7745678901234'),
(7, 'ГородЭкспресс', 'ОАО ТрансКнига', 'ул. Победы, 8, Санкт-Петербург', 79111234567, '7812345678901'),
(8, 'РегионПоставка', 'ОАО Книжный Альянс', 'ул. Советская, 21, Казань', 79221234567, '1654321098765');


INSERT INTO Purchases 
(Code_purchase, Code_book, Date_order, Code_delivery, Type_purchase, Cost, Amount) 
VALUES
(1, 1, '2024-01-15 10:30:00', 1, B'1', 1200.50, 2),
(2, 2, '2024-02-10 14:00:00', 2, B'0', 950.00, 10),
(3, 3, '2024-03-05 09:15:00', 3, B'1', 500.75, 1),
(4, 4, '2024-04-20 16:45:00', 4, B'0', 300.00, 15),
(5, 5, '2024-05-12 11:20:00', 5, B'1', 800.30, 3);



