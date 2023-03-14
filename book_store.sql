-- book_store 데이터베이스(스키마) 생성
CREATE DATABASE book_store DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;

USE book_store;

-- authors 테이블 생성
CREATE TABLE authors
(
	author_id INT PRIMARY KEY, 
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50)
);
DESC authors;
SELECT * FROM authors;

-- books 테이블 생성
CREATE TABLE books
(
	book_id INT PRIMARY KEY, 
	title VARCHAR(100),
	author_id INT,
	publication_date DATE,
    FOREIGN KEY(author_id) REFERENCES authors(author_id) ON UPDATE CASCADE ON DELETE CASCADE
);
DESC books;
SELECT * FROM books;

-- orders 테이블 생성
CREATE TABLE orders
(
	order_id INT PRIMARY KEY, 
	book_id INT,
    customer_name varchar(50),
	order_date DATE,
    FOREIGN KEY(book_id) REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE
);
DESC orders;
SELECT * FROM orders;

-- authors 데이터 채우기 
INSERT INTO authors VALUES 
	('1', 'J.K.', 'Rowling', 'jkrowling@gmail.com'),
	('2', 'George R.R.', 'Martin', 'grmartin@yahoo.com'),
    ('3', 'Stephen', 'King', 'sking@hotmail.com');
DESC authors;
SELECT * FROM authors;

-- books 데이터 채우기 
INSERT INTO books VALUES 
	('1', 'Harry Potter and the Philosopher''s Stone', '1', '1997-06-26'),
	('2', 'A Game of Thrones', '2', '1996-08-006'),
    ('3', 'The Shining', '3', '1977-01-28');
DESC books;
SELECT * FROM books;

-- orders 데이터 채우기 
INSERT INTO orders VALUES 
	('1', '1', 'John Smith','2022-02-15'),
	('2', '2', 'Jane Doe','2022-02-16'),
    ('3', '3', 'Bob Jhonson','2022-02-17');
DESC orders;
SELECT * FROM orders;


-- 문제 
-- 1. author_id가 1인 작성자의 이메일을 jkrowling@yahoo.com으로 업데이트하는 SQL 문을 작성합니다.
UPDATE authors SET email = 'jkrowling@yahoo.com' WHERE author_id = '1';
SELECT * FROM authors;

-- 2. books 테이블에서 book_id 2인 책을 삭제하는 SQL 문을 작성합니다.
DELETE FROM books WHERE book_id = '2';
SELECT * FROM books;

-- 3. 다음 세부 정보가 포함된 새 책을 삽입하는 SQL 문을 작성합니다.
-- 책 ID: 4
-- 제목: 스탠드
-- 저자 ID: 3
-- 발행일자 : 1978-01-01
INSERT INTO books VALUES 
    ('4', 'Stand', '3', '1978-01-28');
SELECT * FROM books;

-- 4. book_id 1인 책의 출판 날짜를 1997-06-30으로 업데이트하는 SQL 문을 작성하십시오.
UPDATE books SET publication_date = '1977-06-30' WHERE book_id = '1';
SELECT * FROM books;

-- 5. 2022-02-17 이전에 접수된 모든 주문을 삭제하는 SQL 문을 작성합니다.
DELETE FROM orders WHERE order_date < '2022-02-17';
SELECT * FROM orders;

-- 6. 다음 세부 정보와 함께 새 주문을 삽입하는 SQL 문을 작성합니다.
-- 주문 ID: 4
-- 책 ID: 1
-- 고객 이름: 사라 존슨
-- 주문일자 : 2022-02-18
INSERT INTO orders VALUES ('4', '1', 'Sara Jhonson', '2022-02-18');
SELECT * FROM orders;

-- 7. order_id가 1인 주문의 고객 이름을 Jack Smith로 업데이트하는 SQL 문을 작성합니다.
UPDATE orders SET customer_name = 'Jack Smith' WHERE order_id = '3';
SELECT * FROM orders;

-- 8. 다음 세부 정보와 함께 새 작성자를 삽입하는 SQL 문을 작성합니다.
-- 저자 ID: 4
-- 이름: 아가사
-- 성: 크리스티
-- 이메일: agatha.christie@example.com
INSERT INTO authors VALUES ('4', 'Agatha', 'Christie', 'agatha.christie@example.com');
SELECT * FROM authors;

-- 9. author_id 2인 작성자의 성을 Martinez로 업데이트하는 SQL 문을 작성합니다.
UPDATE authors SET first_name = 'Martinez' WHERE author_id = '2';
SELECT * FROM authors;

-- 10. author_id 3인 저자가 쓴 모든 책을 삭제하는 SQL 문을 작성합니다.
DELETE FROM authors WHERE author_id = '3';
SELECT * FROM authors;

DROP TABLE authors;
DROP TABLE books;
DROP TABLE orders;

-- ------------------------------------------------------------------------------
-- < 추가 실습 >
-- 11. Stephen King이 쓴 모든 책의 제목과 발행일을 표시합니다.
-- JOIN문 사용
SELECT title, publication_date
    FROM books INNER JOIN authors
    ON books.author_id = authors.author_id
    WHERE first_name = 'Stephen' AND last_name = 'King';

-- 서브쿼리문 사용
SELECT title, publication_date FROM books
    WHERE author_id = (SELECT author_id FROM authors WHERE first_name = 'Stephen' AND last_name = 'King');

-- 12. 책을 쓴 저자의 이름을 표시합니다.
-- 서브쿼리문 사용
SELECT first_name, last_name FROM authors 
	WHERE author_id IN (SELECT author_id FROM books);	-- books 안에 author_id가 있다면

-- JOIN문 사용
SELECT first_name, last_name 
	FROM authors JOIN books 
    ON books.author_id = authors.author_id
    GROUP BY authors.author_id;

-- 13. 각 저자가 쓴 책의 수를 표시합니다.
SELECT first_name, last_name, COUNT(books.author_id) AS 'num_books' 
	FROM authors INNER JOIN books 
    ON books.author_id = authors.author_id
    GROUP BY authors.author_id;
    
-- 선생님 풀이 
SELECT a.first_name, a.last_name, COUNT(b.book_id) AS 'num_books'
FROM authors AS a JOIN books AS b	-- authors를 a로, books를 b로 변경 -> a와 b로 단축 시켰음.
ON a.author_id = b.author_id
GROUP BY a.author_id;

SELECT a.first_name, a.last_name, COUNT(b.book_id) AS 'num_books'
FROM authors AS a, books AS b
WHERE a.author_id = b.author_id
GROUP BY a.author_id;

-- 14. 2022년 2월 16일 이후에 발생한 모든 주문에 대한 책 제목과 고객 이름을 표시합니다.
SELECT title, customer_name 
	FROM books INNER JOIN orders 
    ON books.book_id = orders.book_id
    WHERE order_date >= '2022-02-16';

SELECT books.title, orders.customer_name
FROM books, orders
WHERE books.book_id = orders.book_id AND orders.order_date >= '2022-02-16';

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM orders;



