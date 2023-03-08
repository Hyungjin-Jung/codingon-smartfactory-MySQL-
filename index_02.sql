-- smartfactory 데이터베이스를 사용하는 명령어 (시작할 때 무조건 한번 써야함)
USE smartfactory;

-- 문장 == Query

DESC customer; -- 테이블 정보, 스키마 -> 테이블 -> 테이블명 눌러서도 확인 가능

-- <SELECT/FROM>

-- customer 테이블의 모든 내용 검색
SELECT * FROM customer;

-- orders 테이블의 모든 내용 검색
SELECT * FROM orders;

-- 홍지수 고객의 주소를 찾으시오.
SELECT addr FROM customer WHERE custname = '홍지수';

-- 모든 고객의 고객아이디를 검색
SELECT custid FROM customer;

-- 모든 고객의 고객아이디와 생년월일을 검색
SELECT custid, birth FROM customer; -- custid, birth 순으로 출력

SELECT birth, custid FROM customer; -- birth, custid 순으로 출력

-- 모든 고객의 아이디, 주소, 전화번호, 이름, 생년월일 검색
SELECT custid, addr, phone, custname, birth FROM customer;

-- (와일드카드 사용) 모든 고객의 아이디, 이름 주소, 전화번호, 생년월일 검색
-- *: All, 모든 것을 의미
SELECT * FROM customer;

-- 고객 테이블에 있는 모든 주소를 검색 (중복 포함된 결과)
SELECT addr FROM customer;

-- 고객 테이블에 있는 중복을 제외한 주소 검색
-- DISTINCT: 중복값 제거
SELECT DISTINCT addr FROM customer;

-- < WHERE 절>

-- 비교:  =, <, >, <=, >=
-- 고객 이름이 강해린인 고객을 검색 
SELECT * FROM customer WHERE custname = '강해린';

-- 제품 가격이 4000원 이상인 주문 내역(모든 속성)을 검색 
SELECT * FROM orders WHERE price >= 4000;

-- 범위 검색
-- 범위: BETWEEN a AND b
-- 1995년 이상 2000년 이하 출생 고객 검색
SELECT * FROM customer WHERE birth BETWEEN '1995-01-01' AND '2000-12-31';
SELECT * FROM customer WHERE birth >= '1995-01-01' OR birth <= 2000-12-31;
-- 테이블을 설계할 때 생년월일의 데이터형식을 날짜(DATE)형식으로 지정했기 때문에 범위 찾는 것이 가능

-- 집합 (IN, NOT IN)
-- 주소가 서울 혹은 런던인 고객 검색 
SELECT * FROM customer WHERE addr IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr = '대한민국 서울' OR addr = '영국 런던';
SELECT * FROM customer WHERE addr LIKE '대한민국 서울' OR addr LIKE '영국 런던';

-- 주소가 서울 혹은 런던이 아닌 고객 검색
SELECT * FROM customer WHERE addr NOT IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr != '대한민국 서울' AND addr != '영국 런던';
SELECT * FROM customer WHERE addr NOT LIKE '대한민국 서울' AND addr NOT LIKE '영국 런던';

-- 패턴 (LIKE): 특정 패턴을 포함하는 데이터를 검색
-- %: 0개 이상의 문자
-- _: 1개의 단일 문자
-- 주소가 '미국 로스앤젤레스'인 고겍 검색
SELECT * FROM customer WHERE addr LIKE '미국 로스앤젤레스';

-- 주소에 '미국'이 포함되어 있는 고객 검색
-- 검출 가능한 케이스 예시 '미국', '미국 ', '미국 워싱턴', '미국 로스앤젤레스', ...
SELECT * FROM customer WHERE addr LIKE '미국%'; -- IN, = 등에서 사용 불가, 오직 LIKE에서만 가능 
-- 주의) 검색 안됨 
SELECT * FROM customer WHERE addr = '미국%';
SELECT * FROM customer WHERE addr IN ('미국%');
SELECT * FROM customer WHERE addr LIKE '미국_'; -- 검출 가능한 케이스 예시: '미국 ', '미국인' 등 미국을 시작으로 포함하는 3글자만 검출 가능
SELECT * FROM customer WHERE addr LIKE '미국__'; -- 검출 가능한 케이스 예시: '미국  ', '미국사람', ... 등 미국을 시작으로 포함하는 4글자만 검출 가능
SELECT * FROM customer WHERE addr LIKE '_미국_'; -- 검출 가능한 케이스 예시: ' 미국 ', '진미국밥', '난미국인', ... 등 

-- 고객 이름 두번째 글자가 '지'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '_지_'; -- 이름이 3자이며, 두번째 글자가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '_지%'; -- 두번째 글자가 '지'인 사람

SELECT * FROM customer WHERE custname LIKE '%지%'; -- '지'라는 글자가 들어간 사람
SELECT * FROM customer WHERE custname LIKE '%지_'; -- 뒤에서 두번째가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '_지'; -- 이름이 2자이며, 마지막 글자가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '%_지'; -- 이름이 2자 이상이며, 마지막 글자가 '지'인 사람

-- 고객 이름 세번째 글자가 '수'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '__수%';

SELECT * FROM customer WHERE custname LIKE '__수'; -- 이름이 3자이며, 세번째 글자가 '수'인 사람
SELECT * FROM customer WHERE custname LIKE '%수'; -- 마지막 글자가 '수'인 사람 Ex) '수', '지수', '김갑수', ... 등

-- 복합 조건 (AND, OR, NOT)
-- 주소지가 대한민국이고, 2000년 이후 고객 검색
SELECT * FROM customer WHERE addr LIKE '대한민국%' AND birth >= '2000-01-01';

-- 주소지가 미국이거나 영국인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국%' OR addr LIKE '영국%';

SELECT * FROM customer WHERE addr LIKE '미국' OR '영국';
-- 검색 안되는 이유 조건1(addr LIke '미국%')과 조건2('영국%')에 대해서 OR 검색을 수행

-- 휴대폰 번호 마지막 자리가 4가 아닌 고객 검색
SELECT *  FROM customer WHERE phone NOT LIKE '%4'; 

-- <ORDER BY> 
-- ORDER BY 절을 사용하지 않는 경우, pk 기준으로 정렬 (숫자순, 문자순 정렬)
SELECT * FROM customer;

-- custname 속성을 기준으로 "오름차순" 정렬 
SELECT * FROM customer ORDER BY custname;

-- custname 속성을 기준으로 "내림차순" 정렬 
SELECT * FROM customer ORDER BY custname DESC;

-- ORDER BY & WHERE 함꼐 사용
-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 검색
SELECT * FROM customer ORDER BY addr DESC WHERE birth >= '2000-01-01'; -- 순서가 틀려서 난 오류
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY addr DESC;

-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 그리고 아이디를 기준으로 내림차순 검색 
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY addr DESC, custid DESC;

-- 2000년 이후 출생자 중에서 아이디를 기준으로 내림차순 그리고 주소를 기준으로 내림차순 검색
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY custid DESC, addr DESC;

-- ORDER BY 뒤에 여러 개의 속성을 줄 수 있음 
-- 아래의 두 쿼리문의 결과는 상이함 
SELECT * FROM orders ORDER BY price, amount;
SELECT * FROM orders ORDER BY amount, price;

-- <LIMIT>
-- LIMIT 형식: LIMIT 시작, 개수 == LIMIT 개수 OFFSET 시작
-- 주의) LIMIT에서 시작은 0임을 잊지 말자!
-- Ex. LIMIT 2 == LIMIT 0,2 == LIMIT 2 OFFSET 0
-- LIMIT은 가장 마지막에 씀
-- 고객 테이블 전체 정보를 조회하는데, 앞에 2건만 조회하고 싶은 경우
SELECT * 
FROM customer 
LIMIT 2;

-- 2000년 이후 출생 고객 중에서 앞에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 2; 
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 0, 2; 

-- 2000년 이후 출생 고객 중에서 뒤에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY custid DESC LIMIT 2; 
 
 -- 고객 테이블 전체 정보를 조회하는데, 2번째부터 6번째 행만 조회하고 싶은 경우
SELECT * FROM customer LIMIT 1, 5;
SELECT * FROM customer LIMIT 5 OFFSET 1; 

-- <IS NULL>
-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE phone IS NULL;

-- 고객 테이블에서 연락처와 생일이 존재하지 않는 고객 조회 
SELECT * FROM customer WHERE phone IS NULL AND birth IS NULL;

-- 고객 테이블에서 연락처가 존재하는 고객 조회
SELECT * FROM customer WHERE phone IS NOT NULL;

-- <집계 함수>
-- SUM, AVG, MIN, MAX, COUNT
-- 주문 테이블에서 총 주문 내역 건수 조회 (== 투플 개수)
-- COUNT(*): 모든 행의 개수를 카운트
-- COUNT(속성이름): 속성 값이 NULL인 것을 제외하고 카운트
/*
count(*)와 count(1) 의 차이
요약 두 명령문 모두 동일한 방식으로 작동
성능상 차이는 거의 없음
개발자 개인의 스타일
가독성을 위해 1보다는 * 사용을 권장
*/

SELECT COUNT(*) FROM orders;
SELECT COUNT(orderid) FROM orders;

SELECT COUNT(*) FROM customer; -- 11 
SELECT COUNT(custname) FROM customer; -- 11 
SELECT COUNT(phone) FROM customer; -- 10 
SELECT COUNT(birth) FROM customer; -- 9 

SELECT * FROM orders;

-- 주문 테이블에서 총 판매 개수 검색 
SELECT SUM(amount) FROM orders;

-- 주문 테이블에서 총 판매 개수 검색 + 의미 있는 열 이름으로 변경
SELECT SUM(amount) AS 'total_amount' FROM orders; -- 속성 이름 변경
SELECT SUM(amount) AS total_amount FROM orders; -- 동일 표현
SELECT SUM(amount) total_amount FROM orders; -- 동일 표현

-- 주문 테이블에서 총 판매 개수, 평균 판매 개수, 상품 최저가, 상품 최고가 검색
-- 총 판매 개수: SUM()
-- 평균 판매 개수: AVG()
-- 상품 최저가: MIN()
-- 상품 최고가: MAX()
SELECT SUM(amount) AS 'total_amount', 
	AVG(amount) AS 'avg_amount', 
    MIN(price) AS 'min_price', 
    MAX(price) AS 'max_price' 
FROM orders;

-- <GROUP BY>
-- 고객 별로 주문한 주문 내역 건수 구하기
SELECT custid, count(*) FROM orders GROUP BY custid;
SELECT custid FROM orders GROUP BY custid ORDER BY custid DESC;

-- 고객별로 주문한 상품 총 수량 구하기
SELECT custid AS '아이디', SUM(amount) AS 'total_amount' FROM orders GROUP BY custid;

-- 고객별로 주문한 총 주문액 구하기
SELECT custid AS '아이디', SUM(price * amount) AS '총 주문액' FROM orders GROUP BY custid;

-- 상품별로 판매 개수 구하기
SELECT prodname AS '상품명', SUM(amount) AS '판매 개수' FROM orders GROUP BY prodname;

-- 상품별로 판매 개수 구하기 + 판매 개수 기준으로 내림차순 정렬
SELECT prodname AS '상품명', SUM(amount) AS '판매 개수' FROM orders GROUP BY prodname ORDER BY SUM(amount) DESC;
SELECT prodname AS '상품명', SUM(amount) AS 'total_amount' FROM orders GROUP BY prodname ORDER BY total_amount DESC; -- 이렇게 표현할 때는 한글 X

-- 짝수 해에 태어난 고객 조회
SELECT * FROM customer WHERE YEAR(birth) % 2 = 0;

-- 홀수 일에 태어난 고객 조회
SELECT * FROM customer WHERE MOD(DAY(birth), 2) = 1;

-- 홀수 달에 태어난 고객 조회
SELECT * FROM customer WHERE MONTH(birth) % 2 = 1;

-- 2000-02-22 다음날에 태어난 고객 조회 
-- DATE('2000-02-22'): '2000-02-22' 문자 데이터를 날짜 데이터로 변환
SELECT * FROM customer WHERE birth = DATE('2000-02-22') + 1;

SELECT * FROM orders;
SELECT * FROM customer;

-- <HAVING>
-- group by 명령 이후 추가 조건

-- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총수량 구하기 
-- = 고객별로 주문한 상품 총수량 구하기. 단, 총 주문액이 10000원 이상인 고객만 구한다. 
SELECT custid AS '아이디', SUM(amount) AS '주문 수량', SUM(price * amount) AS '총 주문금액' 
FROM orders 
GROUP BY custid
HAVING SUM(price * amount) >= 10000;

-- HAVING 절은 GROUP BY 절과 반드시 함꼐 사용
-- HAVING 절은 WHERE 절보다 뒤에 나와야 함. 

-- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총 수량 구하기 (단, custid가 'bunny'인 경우 제외)
SELECT custid AS '아이디', SUM(amount) AS '주문 수량', SUM(price * amount) AS '총 주문금액' 
	FROM orders 
	WHERE custid != 'bunny'
	GROUP BY custid
	HAVING SUM(price * amount) >= 10000;

SELECT custid AS '아이디', SUM(amount) AS '주문 수량', SUM(price * amount) AS '총 주문금액' 
	FROM orders 
	GROUP BY custid
	HAVING SUM(price * amount) >= 10000 AND custid != 'bunny'; -- WHERE을 쓰지 않을 때








/*
SQL 내부 실행 순서
1. 조회 테이블 확인 (FROM)
2. 데이터 추출 조건 확인 (WHERE)
3. 컬럼 그룹화 (GROUP BY)
4. 그룹화 조건 (HAVING)
5. 데이터 추출 (SELECT)
6. 데이터 순서 정렬 (ORDER BY)
*/


