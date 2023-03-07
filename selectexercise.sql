use selectexercise;

SELECT * FROM user;

-- 모든 회원목록을 가져오는데, 이때 birthday 컬럼의 값을 기준으로 오름차순 정렬하여 가져오시오. 
SELECT * FROM user ORDER BY birthday;

-- 회원 목록 중 gender 컬럼의 값이 "M"인 회원목록을 가져오는데, 이때 name 컬럼의 값을 기준으로 내림차순 정렬하여 가져오시오. 
SELECT * FROM user WHERE gender = 'M' ORDER BY name DESC;

-- 1990년대 태어난 회원의 id, name 컬럼을 가져와 목록으로 보여주시오. 
SELECT id, name FROM user WHERE birthday >= '1990-01-01' AND birthday <= '1999-12-31';

-- 6월생 회원의 목록을 birthday 기준으로 오름차순 정렬하여 가져오시오.
SELECT * FROM user WHERE birthday LIKE '______6' ORDER BY birthday;

-- gender 컬럼의 값이 "M"이고, 1970년대에 태어난 회원의 목록을 가져오시오. 
SELECT * FROM user WHERE gender LIKE 'M' AND birthday >= '1970-01-01' AND birthday <= '1979-12-31';

-- 모든 회원목록 중 age를 기준으로 내림차순 정렬하여 가져오는데, 그때 처음 3개의 레코드만 가져오시오.
 SELECT * FROM user ORDER BY age DESC LIMIT 3;
 
 -- 모든 회원 목록 중 나이가 25 이상 50 이하인 회원의 목록을 출력하시오.
 SELECT * FROM user WHERE age BETWEEN 25 AND 50; 



