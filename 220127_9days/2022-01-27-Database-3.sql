
-- 사용할 데이터베이스를 선택해요!

USE sqldb;

SELECT * 
FROM userTBL;

-- SELECT를 사용할 때 조건을 이용하고 싶으면.. => WHERE
SELECT *
FROM userTBL
WHERE userName = '김경호';

-- 그러면 조건이 여러개 있으면 어떠게 해야 하나요?
-- 1970년 이후에 출생하고 키가 182 이상인 사람의 아이디와 이름을 조회하세요!
SELECT userID, userName
FROM userTBL
WHERE (birthYear >= 1970) AND (userHeight >= 182);

-- 1970년 이후에 출생하거나 키가 182 이상인 사람의 아이디와 이름을 조회하세요!
SELECT userID, userName
FROM userTBL
WHERE birthYear >= 1970 OR userHeight >= 182;

-- 키가 180~183인 사람을 조회하세요!
SELECT userID, userName
FROM userTBL
WHERE userHeight >= 180 AND userHeight <= 183;

SELECT userID, userName
FROM userTBL
WHERE userHeight BETWEEN 180 AND 183;
-- 이상(>=), 이하(<=), 초과(>), 미만(<)

-- 주소가 경남, 전남, 경북 인 사람의 아이디와 이름을 출력하세요!
SELECT userID, userName
FROM userTBL
WHERE userAddr = '경남' OR userAddr = '전남' OR userAddr = '경북';

SELECT userID, userName
FROM userTBL
WHERE userAddr IN ('경남','전남','경북');

-- 많이 사용되는 기능 중 하나가.. 패턴매칭
-- 성이 '김'씨인 사람들의 이름과 키를 조회하세요!
-- 와일드카드 문자를 이용해야 해요! 이 문자를 이용해서 패턴을 완성해야 해요!
-- 와일드카드 문자 => %, _
-- % : 0개 이상의 글자를 의미, 
-- _ : 1개의 글자를 의미
-- 예를 들어보면 '_용%' 이렇게 패턴을 와일드카드를 이용해서 정했어요!
-- '김용' => OK
-- '홍용하하하하하' => OK
-- '사용해 주셔서 감사합니다.' => OK
-- '김%' => 성이 김인 사람이라는 의미의 패턴.

SELECT userName, userHeight
FROM userTBL
WHERE userName LIKE '김%';

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 조회하세요!
-- 1. 김경호의 키를 먼저 알아내야 해요!
SELECT userHeight
FROM userTBL
WHERE userName = '김경호';   -- 177
-- 2. 이렇게 알아낸 키를 이용해서 다른 사람의 이름과 키를 조회해요!
SELECT userName, userHeight
FROM userTBL
WHERE userHeight >= 177;

-- SubQuery(서브쿼리)
SELECT userName, userHeight
FROM userTBL
WHERE userHeight >= (
      SELECT userHeight
      FROM userTBL
      WHERE userName = '김경호');
      
-- 주소가 '경남'인 사람들의 키보다 키가 크거나 같은 사람을 조회하세요!
-- 1. 주소가 경남이 사람들의 이름과 키를 일단 알아보아요!
SELECT userName, userHeight
FROM userTBL
WHERE userAddr = '경남';     

-- Error Code: 1242. Subquery returns more than 1 row
SELECT userName, userHeight
FROM userTBL
WHERE userHeight >= (
      SELECT userHeight
      FROM userTBL
      WHERE userAddr = '경남');
      
-- ANY() : 여러개중의 하나
-- ALL() : 모두 
SELECT userName, userHeight
FROM userTBL
WHERE userHeight >= ANY(
      SELECT userHeight
      FROM userTBL
      WHERE userAddr = '경남');

-- 정렬을 해 보아요!!
-- 회원가입일이 빠른 순으로 모든 회원의 이름, 아이디, 가입일을 출력하세요.
-- 작은값이 앞에 혹은 위에 위치하는게 오름차순, 큰값이 앞에 혹은 위에 위치하는게 내림차순.
-- 정렬의 기본은 당연히 오름차순 정렬.
-- 명시적으로 오름차순, 내림차순을 표현하려면.. ASC(오름차순), DESC(내림차순)을 이용.

SELECT userName, userID, userDate
FROM userTBL   
ORDER BY userDate DESC;  

-- 모든 회원의 이름과 키를 출력하세요. 단, 키에 대한 내림차순으로 출력하세요!
SELECT userName, userHeight
FROM userTBL
ORDER BY userHeight DESC;

-- 앗..동률이 있어요! 동률이 존재할 경우 동률에 대해서만 2차 정렬을 할 수 있어요!
SELECT userName, userHeight
FROM userTBL
ORDER BY userHeight DESC, userName ASC;

SELECT userName, userHeight
FROM userTBL
WHERE userHeight >= 170
ORDER BY userHeight DESC, userName ASC;

-- 회원의 주소를 출력하세요.
SELECT userAddr
FROM userTBL;

-- 서울
-- 경북
-- 경기
-- 경기
-- 경남
-- 전남
-- 서울
-- 서울
-- 서울
-- 경남

-- 중복된 값을 배제하려면 어떻게 해야 하나요? => DISTINCT 

SELECT DISTINCT userAddr
FROM userTBL;

-- SELECT에서 가져온 결과 레코드 집합(Result Set, Result Grid) 중 일부분만
-- 가져오려면 => LIMIT

SELECT *
FROM userTBL
LIMIT 3;

SELECT *
FROM userTBL
LIMIT 2,5;   -- LIMIT OFFSET,가져올개수

-- 테이블을 복사해 생성해 보아요!
-- 하나의 테이블의 컬럼명, 데이터 타입, 들어가있는 데이터를 복사해서 새로운 테이블을 생성

CREATE TABLE tmpTBL (
    SELECT * FROM userTBL
);

SELECT *
FROM tmpTBL;

DESC tmpTBL;    -- 복사한 테이블의 명세를 살펴보아요!
                -- 키(PK, FK는 복사되지 않아요!)

-- 여기까지는 별로 어렵지 않아요!!

-- 이제 Grouping에 대해서 알아보아요!!

SELECT *
FROM buyTBL;

-- buyTBL에서 사용자가 구매한 물품의 개수를 출력(사용자 ID와 구매수량을 출력)

SELECT userID, buyAmount
FROM buyTBL
ORDER BY userID;

SELECT userID, SUM(buyAmount)
FROM buyTBL
GROUP BY userID
ORDER BY userID;

-- 
SELECT userID, COUNT(buyAmount)
FROM buyTBL
GROUP BY userID
ORDER BY userID;

SELECT userID, AVG(buyAmount)
FROM buyTBL
GROUP BY userID
ORDER BY userID;

-- 각 사용자 별 구매액의 총합을 출력하세요.(구매액 = 단가 * 수량)

SELECT userID AS 'ID', SUM(productPrice * buyAmount) AS 'amount'
FROM buyTBL
GROUP BY userID
ORDER BY userID;

-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- ORDER BY

-- 집계함수의 종류
-- SUM(), AVG(), MAX(), MIN(), COUNT(), STDEV(), etc...

-- 각 사용자별로 한번 구매 시 물건을 평균 몇 개 구매했는지 조회하세요.
SELECT userID, AVG(buyAmount)
FROM buyTBL
GROUP BY userID
ORDER BY userID;

-- userTBL에서 가장 큰 키와 가장 작은키의 회원의 이름과 키를 출력하세요!


-- SELECT userName, MAX(userHeight), MIN(userHeight)
-- FROM userTBL;

-- SELECT userName, MAX(userHeight), MIN(userHeight)
-- FROM userTBL
-- GROUP BY userName;

-- 다 안되는거 같아요.. 너무 어려워요!!

-- 문제가 어려우면 SubQuery를 이용하는 쪽으로 생각을 해보세요!
SELECT userName, userHeight
FROM userTBL
WHERE userHeight = (
      SELECT MAX(userHeight) FROM userTBL
) OR userHeight = (
      SELECT MIN(userHeight) FROM userTBL
);

-- 사용자 별 총 구매 금액이 1000 이상인 사용자의 아이디와 총 구매 금액을 출력하세요!
-- Error Code: 1111. Invalid use of group function
-- WHERE절에는 group 함수(집계함수)를 사용할 수 없어요!
-- 그룹에 대한 조건은 WHERE를 사용하지 않고 HAVING을 이용해야 해요.
-- HAVING절에는 GROUP 함수(집계함수)를 사용할 수 있어요!

SELECT userID, SUM(productPrice * buyAmount)
FROM buyTBL
GROUP BY userID
HAVING SUM(productPrice * buyAmount) >= 1000;

-- SQL SELECT 구문의 순서

-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY

SELECT *
FROM userTBL;

START TRANSACTION;    -- Transaction 시작

SELECT *
FROM buyTBL;

DELETE FROM buyTBL;

SELECT *
FROM buyTBL;

-- Transaction을 끝낼려면 COMMIT , ROLLBACK을 이용하면 되요!
-- COMMIT은 현재 작업한 TRANSACTION을 실제 데이터베이스에 적용!!!!!!!
-- ROLLBACK은 현재 작업한 TRANSACTION을 취소!
ROLLBACK;    -- TRANSACTION이 종료(TRANSACTION안에서 실행된 SQL을 무효화)

-- 나머지 DML에 대해서 알아보아요!!!
-- INSERT, DELETE, UPDATE

-- INSERT (테이블에 데이터를 삽입)

USE sqldb;

CREATE TABLE testTBL (
    id        INT,
    userName  VARCHAR(10),
    userAge   INT
);

-- 가장 기본적인 INSERT(모든 컬럼에 데이터를 다 넣을 경우)
INSERT INTO testTBL VALUES(1, '아이유', 20);

SELECT * FROM testTBL;

-- 필요한 것만 선택해서 INSERT
INSERT INTO testTBL(id, userName) VALUES(2, '김연아');

-- 컬럼의 순서를 바꾸어도 상관 없어요!
INSERT INTO testTBL(userAge, userName) VALUES(30, '신사임당');

-- testTBL을 삭제
DROP TABLE testTBL;

CREATE TABLE testTBL (
    id        INT  AUTO_INCREMENT PRIMARY KEY,
    userName  VARCHAR(10),
    userAge   INT
);

INSERT INTO testTBL VALUES(NULL, '아이유', 20);

SELECT * FROM testTBL;

INSERT INTO testTBL VALUES(NULL, '김연아', 30);

-- 꼭 시작은 1부터 시작해야 하나요? => 아니예요..내가 정해줄 수 있어요!
-- 꼭 1씩 증가해야 하나요? => 아니예요.. 증가하는 값도 내가 정해줄 수 있어요!
-- MySQL내부 변수를 수정해야 해요! => 구글링을 참조하세요!

-- 많은 양의 데이터를 일괄적으로 삽입할 때
-- 일단 기존의 테이블을 삭제
DROP TABLE testTBL;

CREATE TABLE testTBL (
    id     INT,
    fname  VARCHAR(50),
    lname  VARCHAR(50)
);

-- 이렇게 만들어진 Table에 데이터를 입력해 보아요!
INSERT INTO testTBL
    SELECT emp_no, first_name, last_name
    FROM   employees.employees;

SELECT *
FROM testTBL;

-- -----------------------------------------------
-- UPDATE (테이블에 데이터를 수정)

-- 테이블안의 데이터를 수정하려면 UPDATE 구문을 이용.
START TRANSACTION;

UPDATE testTBL
SET lname = '홍길동';

SELECT * FROM testTBL LIMIT 10;

ROLLBACK;


UPDATE testTBL
SET lname = '홍길동'
WHERE fname = 'Parto';

SELECT * FROM testTBL LIMIT 10;

-- -------------------------
-- DELETE (테이블에 데이터를 삭제)

DELETE 
FROM testTBL
WHERE lname = '홍길동';

-- 지금까지는 1개의 테이블을 이용해서 CRUD를 진행했어요!
-- 테이블은 서로 Relation(관계)가 존재해요 => PK, FK
-- 테이블을 서로 결합하려면 어떻게 해야 하나요??
-- JOIN(조인) => 내일 설명할 꺼예요!!!





