USE new_smartfactory;

CREATE TABLE new_customer (
	custid CHAR(10) PRIMARY KEY,
    custname VARCHAR(10) NOT NULL, 
	addr CHAR(10) NOT NULL,
    phone CHAR(11),
    birth DATE
);
DESC new_customer;
SELECT * FROM new_customer;
 
CREATE TABLE new_orders (
	orderid INT PRIMARY KEY AUTO_INCREMENT,
    custid CHAR(10) NOT NULL,
    prodname CHAR(6) NOT NULL,
    price INT NOT NULL,
    amount smallint NOT NULL,
    FOREIGN KEY(custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
);
DESC new_orders;
SELECT * FROM new_orders;

-- ctrl + shfit + enter : 드래그한 여러 행 동시 실행
INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

DROP TABLE new_customer;
DROP TABLE new_orders;

-- <INSERT>
-- 테이블에 새로운 투플 추가 
-- INSERT INTO 테이블명 (필드1, 필드2, 필드3, ...) VALUES (값1, 값2, 값3)
-- INSERT INTO 테이블명 VALUES (값1, 값2, 값3)
-- 필드를 명시하지 않은 경우 테이블의 모든 컬럼에 값을 순서대로 추가해야 한다.

-- 1) 첫번째 방법: 긴 명령어 버전
INSERT INTO new_customer (custid, custname, addr, phone, birth) VALUES ('lucky', '강해원', '미국 뉴욕', '01022223333', '2002-03-05');

-- 속성 순서를 바꿔서 추가하고 싶다면?
-- 순서 바꿀 수 있음! 단, 속성명과 속성값 순서가 차례대로 대응되어야 함.
INSERT INTO new_customer (birth, custid, custname, addr, phone) VALUES ('2007-04-28', 'wow', '이지은', '대한민국 부산', '01098765432');

-- 2) 두번째 방법: 짧은 명령어 버전 (속성 순서를 맞추어서 추가해야 함.)
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');

-- 여러 고객 정보를 동시에 추가하고 싶으면 INSERT 문을 여러번 작성하면 되겠네요? 
-- Yes! 그러나 더 간편한 방법이 있다.
INSERT INTO new_customer VALUES 
	('asdf', '강세희', '대한민국 부산', '01033331235', '2004-11-11'),
	('sdfg', '윤지성', '일본 도쿄', '01033331236', '1995-02-15'),
    ('dfgh', '이재은', '미국 뉴욕', '01033331237', '2004-06-07');


SELECT * FROM new_customer;
SELECT * FROM new_orders;

-- <UPDATE>
-- 테이블에서 특정 속성 값 수정 
-- UPDATE 테이블명 SET 필드1 = 값1 WHERE 필드2 = 조건2;

-- custid가 'apple'인 사람 주소를 '대한민국 서울'로 변경
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid = 'apple';

-- custid의 끝이 'y'인 사람 주소를 '대한민국 서울'로 변경
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid LIKE '%y'; -- 안전장치를 풀어야 실행 가능
SET sql_safe_updates = 0;	-- 안전장치 해제, 실행 후 1회에 한해서만 해제


SELECT * FROM new_customer;
SELECT * FROM new_orders;

-- <DELETE>
-- 테이블의 기존 투플을 삭제 
-- DELETE FROM 테이블명 WHERE 필드1 = 값1;

-- custid가 'happy'인 사람 삭제
DELETE FROM new_customer WHERE custid = 'happy';

-- 외래키 연결되어 있는 경우, 연쇄 삭제
-- orders 테이블에 있는 kiwi 주문목록도 같이 삭제된다. cascade 설정되어 있기 때문. 
DELETE FROM new_customer WHERE custid = 'kiwi';	

SELECT * FROM new_customer;
SELECT * FROM new_orders;

-- <DROP>
-- 테이블 삭제하기 
-- 테이블을 잘못 만들었거나 더 이상 필요 없는 경우

-- <TRUNCATE>
--  테이블 초기화하기
-- 테이블의 모든 행(row) 일괄 삭제

