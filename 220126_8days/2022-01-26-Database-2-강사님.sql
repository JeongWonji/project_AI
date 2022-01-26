
-- View에 대해서 알아보아요!!
-- SQL은 대소문자를 구분하지 않아요!
-- 일반적으로 keyword(이미 정해져있는 글자)는 대문자로 표기하는게 관용적.
-- 식별자(변수이름, 함수이름,.. 내가 이름을 지어주는거.. 테이블이름, 인덱스이름, view이름..)는
-- 관용적으로 소문자를 이용

-- 아하..View는 Table처럼 사용하는 거네요. 실제 사용자 입장에서는 이게 테이블인지
-- View인지 중요하지 않아요!
-- 왜 이렇게 하나요???
-- 일반적으로 테이블안에는 중요한데이터가 들어갈 수 있어요.(개인정보등등)
-- 데이터베이스 관리자(DBA)가 View를 만들어서 사람(개발자, 일반사용자)에게 제공.
-- 복잡한 SQL구문을 View로 단순화 시킬 수 있어요!
-- 관리자나 프로젝트 매니저가 View를 생성해서 제공.

CREATE VIEW shopdb.v_memberTBL
AS
    SELECT memberName, memberAddr FROM shopdb.membertbl;
    

SELECT * FROM shopdb.v_memberTBL;
    
-- 다음 내용은 데이터베이스의 가장 중요한 작업 중 하나인..Backup , Restore    
-- 메뉴에서 처리할 수 있어요!
-- 방금 dhopdb라는 schema를 export(backup)했어요!
-- 이제 shopdb라는 schema를 삭제!
DROP DATABASE shopdb;

-- --------------------------------------------------------------
-- 두 개의 테이블을 생성해 보아요!
-- 만약 지금 내가 사용하고 있는 데이터베이스(schema)가 지정되어 있다면 
-- 데이터베이스(schema)명을 생략할 수 있어요!

-- 데이터베이스(Schema) 지정
USE shopdb;

-- PK를 지정하지 않고 userTBL을 만들어 보아요!
CREATE TABLE userTBL (
    userName    VARCHAR(6),
    userAddr    VARCHAR(12),
    userMobile  VARCHAR(11)
);

-- 이상태에서 데이터를 입력해보아요!
INSERT INTO userTBL VALUES('아이유', '서울', '1234');
INSERT INTO userTBL VALUES('김연아', '인천', '5678');
INSERT INTO userTBL VALUES('신사임당', '부산', '9011');

-- 입력이 잘 되었는지 확인해 보아요!
SELECT * FROM userTBL;
-- 아이유	    서울	  1234
-- 김연아	    인천	  5678
-- 신사임당	부산	  9011

-- 테이블을 삭제해 보아요!
DROP TABLE userTBL;

-- 다시 만들어 보아요!!!

-- PK를 userName에 지정해서 userTBL을 만들어 보아요!
CREATE TABLE userTBL (
    userName    VARCHAR(6) PRIMARY KEY,
    userAddr    VARCHAR(12),
    userMobile  VARCHAR(11)
);

-- 이상태에서 데이터를 입력해보아요!
INSERT INTO userTBL VALUES('아이유', '서울', '1234');
INSERT INTO userTBL VALUES('김연아', '인천', '5678');
INSERT INTO userTBL VALUES('신사임당', '부산', '9011');

-- 입력이 잘 되었는지 확인해 보아요!
SELECT * FROM userTBL;
-- 아이유	    서울	  1234
-- 김연아	    인천	  5678
-- 신사임당	부산	  9011
    
-- Primary key를 기준으로 오름차순 정렬되서 데이터가 저장되요!
-- 그래서 primary key로 설정하면 clustered Index가 자동으로 설정되고 
-- 데이터가 사전식으로 정렬되서 유지되요!

-- 아까 했던 그냥 Index를 생성하는 건... Secondary Index라고 하고 이 Secondary Index는
-- B-Tree를 따로 구성해요!
    
-- 김연아	    인천	5678
-- 신사임당	부산	9011
-- 아이유	    서울	1234

-- 두번째 Table을 생성해 보아요!
CREATE TABLE buyTBL (
    userName     VARCHAR(6) NOT NULL,   -- foreign key
    productName  VARCHAR(10) NOT NULL,
    productPrice INT NOT NULL,
    buyAmount    INT NOT NULL,
    FOREIGN KEY(userName) REFERENCES userTBL(userName)
);
		    
-- 데이터를 입력해 보아요!!
-- 잘못입력해볼꺼예요!!!
-- INSERT INTO buyTBL VALUES('홍길동', '냉장고', 1000, 2);   -- 오류

-- 정상적으로 입력해보아요!!
INSERT INTO buyTBL VALUES('아이유', '냉장고', 1000, 2);
INSERT INTO buyTBL VALUES('김연아', 'TV', 2000, 1);
INSERT INTO buyTBL VALUES('신사임당', '컴퓨터', 3000, 3);

-- 데이터가 정상적으로 저장되었는지를 확인해보아요!
SELECT * FROM buyTBL;

-- userTBL에 특정 user를 삭제해 보아요!
DELETE FROM userTBL WHERE userName = '아이유';   -- 안되겠죠...
                                               -- buyTBL에 아이유가 존재! 
                                               
-- ------------SQL을 알아보아요!! ----------------
-- 제일먼저 SELECT 부터 알아보아요!! ----------------

-- 현재 사용가능한 모든 Database(Schema)를 출력.
SHOW DATABASES;

-- 사용할 데이터베이스(Schema)를 선택
USE employees;

-- 현재 데이터베이스(Schema)안의 테이블을 조회
SHOW TABLES;

-- 테이블 중 employees라는 table이 있어요.. 이 table의 명세를 알고 싶어요!
DESC employees;

-- 잠깐 데이터 타입에 대해서 하나만 알아보고 넘어가요!
-- INT : 정수형 (-21억 ~ +21억)
-- VARCHAR(variable character) : 가변문자열
-- VARCHAR(10) => 최대 10글자까지 저장할 수 있는 가변 문자열 타입.
--                만약 5글자만 저장했어요. 사용되는 공간이 5글자로 줄어요!~ 
--                저장되는 공간을 효율적으로 사용. 
-- CHAR(10) => 최대 10글자까지 저장할 수 있는 고정 문자열 타입.
--             만약 5글자만 저장했어요. 그래도 공간 자체는 10글자 공간이 할당.
--             공간을 효율적으로 사용하지는 못해요!
--             VARCHAR보다 연산이 빨라요.
-- DATE     => 날짜타입(연월일)
-- DATETIME => 날짜타입(연월일시분초)  

-- Table에서 특정 데이터를 추출하기 위해서 사용하는 DML은 SELECT

-- SELECT 컬럼(들) FROM 스키마.테이블(View) 
SELECT emp_no, first_name, hire_date FROM employees;  -- 300024개

-- 가져오는 record의 개수를 제한하는 방법
SELECT emp_no, first_name, hire_date FROM employees LIMIT 5;
-- 결과를 Result Grid(결과 레코드 집합, Result Set)

-- 결과 레코드 집합(Result Set)은 테이블 형태. 당연히 컬럼이 존재 => SELECT한 컬럼명이 사용
-- 결과 레코드 집합에 컬럼명을 변경할 수 있어요! => alias를 이용하면 되요!
--                                        많이 사용됩니다. !! 자주 사용되요!
SELECT emp_no AS '사번', 
       first_name AS '이름', 
       hire_date AS '입사일'
FROM employees LIMIT 5;

-- 데이터가 너무 많아서.. 정상적으로 수행되었는지 확인이 힘들어요!
-- 그래서 다른 테이블과 데이터를 이용해서 SELECT에 대한 내용을 좀 더 알아보아요!

-- 일단 데이터베이스가 존재하면 지워요!!
DROP DATABASE IF EXISTS sqldb;

-- 데이터베이스(Schema)를 생성해요!!
CREATE DATABASE sqldb;

-- sqldb라는 데이터베이스(Schame)가 생성되었으니 이걸 사용해 보아요!
USE sqldb;

-- 테이블을 생성.
CREATE TABLE userTBL (
    userID      CHAR(8) PRIMARY KEY,    -- 사용자 ID(PK)
    userName    VARCHAR(10) NOT NULL,   -- 사용자 이름 
    birthYear   INT NOT NULL,           -- 출생연도 
    userAddr    CHAR(2) NOT NULL,       -- 지역(2글자짜리 지역명)
    mobile1     CHAR(3),                -- 휴대폰 앞자리(3자리)
    mobile2     CHAR(8),                -- 휴대폰 뒷자리(8글자)
    userHeight  SMALLINT,               -- 키
    userDate    DATE                    -- 회원가입일
);

CREATE TABLE buyTBL (
    num          INT  AUTO_INCREMENT PRIMARY KEY,   -- 순번(PK)
    userID       CHAR(8) NOT NULL,                  -- 사용자 ID(FK)
    productName  CHAR(6) NOT NULL,                  -- 제품명
    productGruop CHAR(4),                           -- 제품분류
    productPrice INT NOT NULL,                      -- 제품 단가
    buyAmount    INT NOT NULL,                      -- 구매 수량
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

-- 데이터 입력
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL , 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL , 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);

SELECT * FROM userTBL;
SELECT * FROM buyTBL;


                                              