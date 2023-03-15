-- <DCL>
-- Data Control Language
-- GRANT, REVOKE

USE new_smartfactory;

SELECT * FROM new_customer;
SELECT * FROM new_orders;

-- 현재 root 사용자만 존재~ 
-- => 새로운 사용자(유저, 계정) 추가 (codee)
-- CREATE USER '계정명'@'접속경로' IDENTIFIED BY '비밀번호';
CREATE USER 'codee'@'localhost' IDENTIFIED BY 'jin805703';
CREATE USER 'lucky'@'localhost' IDENTIFIED BY 'jin805703';	-- 권한 부여 X
CREATE USER 'happy'@'localhost' IDENTIFIED BY 'jin805703';	-- new_smartfactoy 스키마에 SELECT 권한 부여

-- 참고) MySQL 사용자 비밀번호를 변경하고 싶다면? 
ALTER USER 'codee'@'localhost' IDENTIFIED WITH mysql_native_password BY 'jin805703';
FLUSH PRIVIlEGES;	-- 새로 고침해야 반영!

-- 새로 생성한 사용자 확인 
SHOW DATABASES;
SELECT user FROM mysql.USER;	-- mysql.user: mysql db의 user table

-- <GRANT>
-- : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한 부여
-- GRANT 권한 유형 ON 데이터베이스이름.테이블이름 TO '계정명'@'접속경로' WITH GRANT OPTION;
-- 모든 데이터베이스의 모든 테이블: *.*
-- 모든 권한 부여: GRANT ALL PRIVILEGES
-- WITH GRANT OPTION: 권한을 다른 사용자한테 부여 가능할 수 있는 옵션
	-- roor -> codee -> ?

-- Ex. codee 사용자에게 모든 데이터베이스의 모든 테이블에 모든 권한 부여
GRANT ALL PRIVILEGES ON *.* TO 'codee'@'localhost' WITH GRANT OPTION;

-- GRANT 권한 유형 ON 데이터베이스이름.테이블이름
-- GRANT ALL PRIVILEGES ON 데이터베이스이름.*
-- => 특정 데이터베이스의 모든 테이블에 모든 권한 부여

-- GRANT ALL PRIVILEGES ON 데이터베이스이름.테이블이름
-- => 특정 데이터베이스의 특정 테이블에 모든 권한 부여

-- GRANT SELECT ON 데이터베이스이름.테이블이름
-- => 특정 데이터베이스의 특정 테이블에 SELECT 권한 부여

-- GRANT SELECT, INSERT ON 데이터베이스이름.테이블이름
-- => 특정 데이터베이스의 특정 테이블에 SELECT, INSERT 권한 부여

GRANT SELECT ON new_smartfactory.* TO 'happy'@'localhost' WITH GRANT OPTION;

-- <REVOKE>
-- 특정 데이터베이스 사용자에게 특정 작업에 대한 권한 박탈
-- REVOKE 권한 유형 ON 데이터베이스이름.테이블이름 FROM '계정명'@'접속경로';

-- codee의 DELETE 권한 삭제
REVOKE DELETE ON *.* FROM 'codee'@'localhost';	

-- codee의 모든 권한 삭제
REVOKE ALL ON *.* FROM 'codee'@'localhost';		-- 빨간 밑줄이 그어지지만 정상 동작

-- 계정 삭제 
DROP USER 'codee'@'localhost';
DROP USER 'lucky'@'localhost';
DROP USER 'happy'@'localhost';
FLUSH PRIVIlEGES;	-- 새로 고침해야 반영!
