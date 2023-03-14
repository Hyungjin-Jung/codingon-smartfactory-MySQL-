USE smartfactory;

SELECT * FROM customer;
SELECT * FROM orders;

DROP TABLE IF EXISTS customer; 
CREATE TABLE customer 
( custid    CHAR(10) NOT NULL PRIMARY KEY,
  custname  VARCHAR(10) NOT NULL, 
  addr      CHAR(10) NOT NULL, 
  phone     CHAR(11), 
  birth     DATE 
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders 
(  orderid   INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   custid    CHAR(10) NOT NULL, 
   prodname  CHAR(6) NOT NULL, 
   price     INT  NOT NULL, 
   amount    SMALLINT  NOT NULL,
   FOREIGN KEY (custid) REFERENCES customer(custid)
);


DELETE FROM customer;
INSERT INTO customer VALUES('bunny', '강해린', '대한민국 서울', '01012341234', '2000-02-23');
INSERT INTO customer VALUES('hello', '이지민', '대한민국 포항', '01022221234', '1999-08-08');
INSERT INTO customer VALUES('kiwi', '최지수', '미국 뉴욕', '01050005000', '1990-12-25');
INSERT INTO customer VALUES('imminji01', '강민지', '영국 런던', '01060001000', '1995-01-11');
INSERT INTO customer VALUES('lalala', '홍지수', '미국 로스앤젤레스', '01010109090', '2007-05-16');
INSERT INTO customer VALUES('jjjeee', '홍은정', '대한민국 서울', '01099991111', '2004-08-17');
INSERT INTO customer VALUES('wow123', '이민혁', '일본 삿포로', '01011223344', '1994-05-31');
INSERT INTO customer VALUES('minjipark', '박민지', '프랑스 파리', '01088776655', '1998-04-08');
INSERT INTO customer VALUES('jy9987', '강지연', '일본 삿포로', '01012312323', '1996-09-01');
SELECT * FROM customer;


DELETE FROM orders;
INSERT INTO orders VALUES(NULL, 'jy9987', '프링글스', 3500, 2);
INSERT INTO orders VALUES(NULL, 'kiwi', '새우깡', 1200, 1);
INSERT INTO orders VALUES(NULL, 'hello', '홈런볼', 4200, 2);
INSERT INTO orders VALUES(NULL, 'minjipark', '맛동산', 2400, 1);
INSERT INTO orders VALUES(NULL, 'bunny', '오감자', 1500, 4);
INSERT INTO orders VALUES(NULL, 'jjjeee', '양파링', 2000, 1);
INSERT INTO orders VALUES(NULL, 'hello', '자갈치', 1300, 2);
INSERT INTO orders VALUES(NULL, 'jjjeee', '감자깡', 1200, 4);
INSERT INTO orders VALUES(NULL, 'bunny', '죠리퐁', 1500, 3);
INSERT INTO orders VALUES(NULL, 'kiwi', '꼬깔콘', 1700, 2);
INSERT INTO orders VALUES(NULL, 'hello', '버터링', 4000, 2);
INSERT INTO orders VALUES(NULL, 'minjipark', '칙촉', 4000, 1);
INSERT INTO orders VALUES(NULL, 'wow123', '콘초', 1700, 3);
INSERT INTO orders VALUES(NULL, 'imminji01', '꼬북칩', 2000, 2);
INSERT INTO orders VALUES(NULL, 'bunny', '썬칩', 1800, 5);
INSERT INTO orders VALUES(NULL, 'kiwi', '고구마깡', 1300, 3);
INSERT INTO orders VALUES(NULL, 'jy9987', '오징어집', 1700, 5);
INSERT INTO orders VALUES(NULL, 'jjjeee', '바나나킥', 2000, 4);
INSERT INTO orders VALUES(NULL, 'imminji01', '초코파이', 5000, 2);
SELECT * FROM orders;

-- <JOIN>
-- 두 테이블을 묶어서 하나의 테이블을 만듦
-- 왜? 두 테이블을 엮어야 원하는 형태가 나오기도 함
-- 사용하려면 두 테이블이 PK-FK 관계여야 한다.
-- 조인조건은 PK-FK관계를 쓴다고 생각하자
-- SELECT 속성이름, ... FROM 테이블A, 테이블B WHERE 조인조건 AND 검색조건;
-- SELECT 속성이름, ... FROM 테이블A INNER JOIN 테이블B ON 조인조건 WHERE 검색조건;
-- 둘 중 편한걸 사용하지만, 보통은 JOIN문을 사용한다. 

SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customer, orders;	-- 19 * 9 = 171
-- a 고객이 orders의 19개 행과 결합, b 고객이 orders의 19개 행과 결합, ... => 논리에 안맞음!

-- WHERE 절을 이용해 조인 조건을 추가 
-- 참고) [테이블이름.테이블명] 표기: 특정 테이블의 열을 가르킴 
SELECT * FROM customer, orders WHERE customer.custid = orders.custid;
SELECT * FROM customer INNER JOIN orders ON customer.custid = orders.custid;
SELECT * FROM customer JOIN orders ON customer.custid = orders.custid;	-- INNER 생략 가능

-- custid 순서로 정렬 
SELECT * FROM customer, orders WHERE customer.custid = orders.custid ORDER BY customer.custid;	-- customer 테이블의 custid순으로 정렬
SELECT * FROM customer INNER JOIN orders ON customer.custid = orders.custid ORDER BY orders.custid; -- orders 테이블의 orderid 순으로 정렬

-- 고객별로 주문한 제품 총 구매액을 고객별로 정렬  (고객별로 주문한 제품 총 구매액 조회)
-- 실행 결과(고객이름, 총 구매액)
SELECT customer.custname AS '이름', SUM(price * amount) AS '총 주문금액'
	FROM customer, orders
	WHERE customer.custid = orders.custid 
	GROUP BY custname
    ORDER BY custname;
    
SELECT customer.custname AS '이름', SUM(price * amount) AS '총 주문금액'
	FROM customer INNER JOIN orders		-- customer와 orders는 순서가 바뀌어도 상관없음.
	ON customer.custid = orders.custid 
	GROUP BY custname
    ORDER BY custname;
    
-- <서브 쿼리, 부속 질의>
-- : SQL문 내에 또 다른 SQL문 작성
-- : SELECT문의 WHERE절에 또 다른 테이블 경과를 이용해서 다시 SELECT 문을 괄호로 묶는다!
-- => SELECT ~ FROM ~ WHERE (SELECT ~ FROM ~~);
 
-- STEP 1. 주문 금액이 가장 큰 주문 내역은 무엇인가?
SELECT MAX(price * amount) FROM orders;

SELECT customer.custname AS '이름', SUM(price * amount) AS '총 주문금액'
	FROM customer, orders
	WHERE customer.custid = orders.custid 
	GROUP BY custname
    ORDER BY SUM(price * amount) DESC LIMIT 1;

-- STEP 2. 가장 큰 주문 금액(10000원)에 대한 주문아이디, 고객아이디, 상품명 조회  
SELECT orderid, custid, prodname FROM orders WHERE price * amount = 10000;

-- STEP 3. 서브 쿼리를 이용해 두 SQL문을 하나로 합치기
SELECT orderid, custid, prodname FROM orders 
	WHERE price * amount = (SELECT MAX(price * amount) FROM orders);

-- 평균 주문 금액 이상인 사람 조회 
SELECT orderid, custid, prodname FROM orders 
	WHERE price * amount > (SELECT AVG(price * amount) FROM orders);

-- 주문 이력이 있는 고객 조회 
SELECT custname FROM customer WHERE custid IN (SELECT custid FROM orders);

SELECT * FROM orders;

SELECT * FROM customer;
SELECT * FROM orders;
