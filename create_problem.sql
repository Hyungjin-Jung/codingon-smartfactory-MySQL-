-- 실습

USE new_smartfactory;

CREATE TABLE new_user
(
	id VARCHAR(10) PRIMARY KEY, 
	pw VARCHAR(20) NOT NULL,
	name CHAR(5) NOT NULL,
	gender CHAR(1),
	birthday DATE NOT NULL,
    age INT NOT NULL	-- INT(3) 으로 해줘도 됌
);
DESC new_user;
SELECT * FROM new_user;

DROP TABLE new_user;

CREATE TABLE member
(
	id VARCHAR(20) PRIMARY KEY, 
	name VARCHAR(5) NOT NULL,
    age INT,
	gender VARCHAR(2) NOT NULL,
	email VARCHAR(50),
    -- 제약 조건: NOT NULL, PRIMARY KEY, AUTO_INCREMENT, DEFAULT, ...
    -- 기본값: 해당 속성의 기본 값을 설정, DEFAULT
    promotion VARCHAR(2) DEFAULT "x"	
);
DESC member;
SELECT * FROM member;


-- member 속성 수정 

-- (1) id 값 형식 변경 
ALTER TABLE member MODIFY id VARCHAR(10);
ALTER TABLE member CHANGE id id VARCHAR(10);

INSERT INTO member VALUES ('apple', '이사과', 30, 'f', '1hyun@naver.com', 'o');

-- (2) age 속성 삭제 
ALTER TABLE member DROP age;

-- (3) interest 속성 추가
ALTER TABLE member ADD interest VARCHAR(100); 
DESC member;

DROP TABLE member;
