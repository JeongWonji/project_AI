
-- JOIN에 대해서 알아보아요!!

-- MySQL DBMS는 관계형 데이터베이스.
-- 중복과 공간의 낭비를 피하고 데이터의 무결성을 위해서 
-- 여러 개의 테이블에 데이터를 나누어서 저장합니다.

-- 이 분리된 테이블은 서로 Relation을 가지고 있어요!

-- 두 개의 테이블을 묶어서 하나의 결과 집합(Result Set)을 만들어 내는것을 알아보아요!

-- JOIN은 크게 두가지로 나누어져요!
-- 1. INNER JOIN : 일반적으로 많이 사용. 그냥 JOIN이라고 말하면 대부분 INNER JOIN을 의미. 
-- 2. OUTER JOIN

-- 형식
-- SELECT <열 목록>
-- FROM <첫번째 테이블> 
--     INNER JOIN <두번째 테이블>
--     ON <조인 조건>
-- WHERE <검색 조건>
-- GROUP BY
-- HAVING
-- ORDER BY    

USE sqldb;

SELECT * FROM userTBL;
SELECT * FROM buyTBL;

-- 모호한 표현은 사용하면 안되요! 똑같은 컬럼명이 2개 이상 있을때 
-- 반드시 테이블명도 같이 명시해야 해요!
SELECT *
FROM buyTBL
    INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID
WHERE buyTBL.userID = 'JYP';     


SELECT *
FROM buyTBL
    INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID
WHERE productName = '운동화'; 

-- 필요한 컬럼만 추출

SELECT buyTBL.userID, buyTBL.productName, userTBL.userName, userTBL.userHeight
FROM buyTBL
    INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID;
    
-- 너무 길어요! 손가락이 아파요! 
-- Table이름에 alias를 사용하면 좋아요! (일반적)

SELECT B.userID, B.productName, U.userName, U.userHeight
FROM buyTBL B
    INNER JOIN userTBL U
    ON B.userID = U.userID;

-- ----------------------------------------
-- 예제를 위한 테이블 생성과 데이터를 입력해 보아요!

USE sqldb;

-- 학생테이블 생성(stdTBL)
CREATE TABLE stdTBL (
    stdName    VARCHAR(10) PRIMARY KEY,  -- 학생 이름  
    stdAddr    VARCHAR(4) NOT NULL       -- 학생 주소
);

-- 동아리테이블 생성(clubTBL)
CREATE TABLE clubTBL (
    clubName  VARCHAR(10) PRIMARY KEY,   -- 동아리 이름
    clubRoom  VARCHAR(4) NOT NULL        -- 동아리 방 번호
);

-- 학생동아리 테이블 생성(stdclubTBL)
CREATE TABLE stdclubTBL (
    num      INT AUTO_INCREMENT PRIMARY KEY,   -- 일련번호
    stdName  VARCHAR(10) NOT NULL,
    clubName VARCHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdTBL(stdName),
    FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
);

-- 데이터를 입력해야 해요!( 순서에 조심해서 입력해야 해요! )
INSERT INTO stdTBL VALUES ('김범수','경남');
INSERT INTO stdTBL VALUES ('성시경','서울');
INSERT INTO stdTBL VALUES ('조용필','경기');
INSERT INTO stdTBL VALUES ('은지원','경북');
INSERT INTO stdTBL VALUES ('바비킴','서울');

SELECT * FROM stdTBL;

INSERT INTO clubTBL VALUES ('수영','101호');
INSERT INTO clubTBL VALUES ('바둑','102호');
INSERT INTO clubTBL VALUES ('축구','103호');
INSERT INTO clubTBL VALUES ('봉사','104호');

SELECT * FROM clubTBL;

INSERT INTO stdclubTBL VALUES (NULL, '김범수','바둑');
INSERT INTO stdclubTBL VALUES (NULL, '김범수','축구');
INSERT INTO stdclubTBL VALUES (NULL, '조용필','축구');
INSERT INTO stdclubTBL VALUES (NULL, '은지원','축구');
INSERT INTO stdclubTBL VALUES (NULL, '은지원','봉사');
INSERT INTO stdclubTBL VALUES (NULL, '바비킴','봉사');

SELECT * FROM stdclubTBL;


-- 학생을 기준으로 학생이름, 지역, 가입한 동아리, 동아리방을 출력하세요.

SELECT S.stdName, S.stdAddr, SC.clubName, C.clubRoom
FROM stdTBL S
    INNER JOIN stdclubTBL SC
    ON S.stdName = SC.stdName
    INNER JOIN clubTBL C
    ON SC.clubName = C.clubName;

-- 동아리를 기준으로 가입한 학생의 목록을 출력하세요!
-- clubName, clubRoom, stdName, stdAddr

-- INNER JOIN에 대해서 알아보았어요!~
-- OUTER JOIN에 대해서 알아보아요!!! 
-- OUTER JOIN은 <LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN>

-- OUTER JOIN은 userTBL과 buyTBL을 이용해 보아요!

-- 전체 회원의 구매내역을 조회하세요. 단, 구매 기록이 없는 회원도 출력되어야 해요!

SELECT * FROM userTBL;
SELECT * FROM buyTBL;

-- 아래와 같이 INNER JOIN을 하는 경우 구매내역이 없는 회원은 결과에 포함되지 않아요!
SELECT *
FROM userTBL U
    INNER JOIN buyTBL B
    ON U.userID = B.userID;

-- OUTER JOIN의 형태
-- SELECT <컬럼>
-- FROM <왼쪽(LEFT) 테이블>
--     <LEFT|RIGHT|FULL> OUTER JOIN <두번째 테이블(오른쪽 테이블)>
--     ON <조인 조건>
-- OUTER JOIN은 INNER JOIN에 포함되지 못한 데이터를 포함해주는 기능.    

-- 전체 회원의 구매내역을 조회하세요. 단, 구매 기록이 없는 회원도 출력되어야 해요!

SELECT *
FROM userTBL U
    LEFT OUTER JOIN buyTBL B
    ON U.userID = B.userID
ORDER BY U.userID;    
    
-- 한번도 구매한 적이 없는 회원의 목록을 출력하세요! 
-- NULL은 특수한 의미를 가지는 값. = 기호로 비교를 할 수 없어요! IS 키워를 이용.

SELECT *
FROM userTBL U
    LEFT OUTER JOIN buyTBL B
    ON U.userID = B.userID
WHERE B.productName IS NULL      -- = 기호를 사용하면 안되요!
ORDER BY U.userID; 


-- UNION, UNION ALL
-- 두 쿼리의 결과를 행으로 합치는 기능

(SELECT stdName, stdAddr 
FROM stdTBL)

UNION

(SELECT clubName, clubRoom 
FROM clubTBL);

-- UNION이 안되는 경우를 보자!!
-- UNION의 기본 조건은.. 컬럼의 개수가 같아야 해요!
--                    컬럼의 개수가 같고 데이터타입이 같아야 해요!
-- (SELECT stdName, stdAddr 
-- FROM stdTBL)

-- UNION

-- (SELECT clubName 
-- FROM clubTBL);

-- 그러면 UNION과 UNION ALL은 무슨차이가 있나요??
-- UNION은 중복을 배제하고 합쳐요!
-- UNION ALL은 중복에 상관없이 무조건 합쳐요!

-- IN, NOT IN 

-- usertbl에 대해
-- 모든 회원을 조회하되 전화가 없는 사람을 제외하고 출력하세요!
SELECT * FROM userTBL;

-- 이렇게 하면 되네!!
SELECT *
FROM userTBL
WHERE mobile1 IS NOT NULL;

-- 다른 방법을 알아보아요!
SELECT userID, userName, CONCAT(mobile1,mobile2)
FROM userTBL
WHERE userName NOT IN (
    SELECT userName FROM userTBL WHERE mobile1 IS NULL
);


-- 여러가지 SQL 구문에 대해서 알아보았어요!!! 
-- 원래 추가적으로 공부해야하는건... Database안에 들어 있는 다른 객체들
-- Table, View, Index, Stored Procedure, Function, Trigger, 등등에 대한 
-- 세부적인 내용을 알아야 해요!
-- Database마다 가지고 있는 Data Type에 대해서도 자세히 알아봐야 하죠.

-- 연습을 해야 해요!! => 문제를 살짝 내 드릴꺼예요!!
-- 문제를 해결하면서 지금까지 배운 내용을 정리해 보세요!



