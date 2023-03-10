USE smartfactory;
USE new_smartfactory;

-- <CREATE>
-- 데이터베이스 생성 + 한글 인코딩 
-- 한글 인코딩: 프로그래밍 언어는 영어 기반이므로 한글을 사용할 수 있도록! 
-- 테이블 생성시 속성의 순서는 상관 없음. 
-- 왜냐하면 릴레이션 특징 중에서 "속성의 순서는 상관 없음"이 존재. 
-- 테이블 생성시 열 이름 > 데이터 형식 순으로 작성은 해야함. 

CREATE DATABASE new_smartfactory DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE new_smartfactory DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
CREATE DATABASE new_smartfactory CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 테이블 생성
-- new_customer 테이블
-- custid(고객번호) CHAR(10), NOT NULL 제약조건, PK
-- custname(고객이름) VARCHAR(10), NOT NULL 제약조건
-- addr (주소) CHAR(10), NOT NULL 제약조건
-- phone (연락처) CHAR(11)
-- birth (생년월일) DATE

-- 1. 기본키 제약 조건 
-- 기본키는 중복 불가능 
-- NULL 불가능
CREATE TABLE new_customer 
(	-- 열(데이터) 이름, 데이터 형식(타입), 제약 조건 순서로 작성
	custid CHAR(10) NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL을 포함하고 있기 때문에 NOT NULL 생략 가능
    custname VARCHAR(10)  NOT NULL,
    addr CHAR(10) NOT NULL,
	phone CHAR(11),
	birth DATE
);
DESC new_customer;
SELECT * FROM new_customer;

-- new_orders 테이블 생성
-- orderid INT, NOT NULL 제약조건, PK, 숫자 자동 증가(AUTO_INCREMENT)
-- custid CHAR(10), NOT NULL 제약조건
-- prodname CHAR(6), NOT NULL 제약조건
-- price INT, NOT NULL 제약조건
-- amount smallint, NOT NULL 제약조건

-- 2. 외래키 제약 조건
-- 두 테이블 사이의 관계를 맺어줌 (= 다른 테이블으 기본키를 현재 테이블의 외래키로 연결함.)
-- 기본키를 갖는 테이블: "기준" 테이블
-- 외래키를 갖는 테이블: "참조" 테이블
-- 형식: FOREIGN KEY(열_이름) REFERENCES 기준_테이블(열_이름)

-- ON UPDATE CASCADE: 기준 테이블의 데이터 수정시 -> 참조 테이즐 데이터도 수정
-- ON DELETE CASCADE: 기준 데이터의 데이터 삭제시 -> 참조 테이블 데이터도 삭제
 
CREATE TABLE new_orders
(
	orderid INT PRIMARY KEY AUTO_INCREMENT, -- PRIMARY KEY는 NOT NULL을 포함하고 있기 때문에 NOT NULL 생략 가능
	custid CHAR(10) NOT NULL,
	prodname CHAR(6) NOT NULL,
	price INT NOT NULL,
	amount SMALLiNT NOT NULL,
    FOREIGN KEY(custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
);
DESC new_orders;
SELECT * FROM new_orders;

-- 칸트롤 + 쉬프트 + 엔터: 드래그한 행 전체 실행
INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

-- <ALTER>

-- 새로운 속성 추가
-- : 고객 테이블에 새로운 속성 "nickname"이 생겼음
ALTER TABLE new_customer ADD nickname VARCHAR(10); 

-- 속성 수정 
-- (1) 속성의 데이터타입 수정 
ALTER TABLE new_customer MODIFY nickname INT;
DESC new_customer;

-- (2) 속성명 변경 
ALTER TABLE new_customer CHANGE nickname n_name VARCHAR(10);

-- (3) 기존 속성 삭제 
ALTER TABLE new_customer DROP n_name;

-- <DROP> 
-- new_customer 테이블과 new_orders 테이블은 custid를 기준으로 pk-fk 관계 맺고 있음
-- 즉, new_customer 테이블에 등록된 고객만 new_orders 테이블에 들어갈 수 있음
-- 만약, new_orders 테이블이 있는데 new_customer 테이블을 DROP 한다면?
-- new_orders 에서 특정 고객의 정보를 확인하고 싶어도, 이미 new_customer 테이블이 삭제되어 알 수 없음
-- => pk-fk 관계로 연결된 테이블은 "외래키가 설정된 테이블"을 먼저 삭제해야 함.

-- new_customer 테이블 (기준 테이블, 기본 키 테이블) -> (2) 나중 삭제
-- new_orders 테이블 (참조 테이블, 외래 키 테이블) -> (1) 먼저 삭제

DROP TABLE new_customer;
DROP TABLE new_orders;


