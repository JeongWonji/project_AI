-- view
-- sql은 대소문자 구분 안함
-- 일반적으로 keyword(이미 정해져있는 글자)는 대문자로 표기하는게 관용적
-- 식별자(변수이름, 함수이름,... 내가 이름을 지어주는거.. 테이블이름, 인덱스이름, 뷰이름)는 관용적으로 소문자를 이용

-- view는 table처럼 사용함. 실제 사용자 입장에선 이게 테이블인지 뷰인지 안중요함.
-- 일반적으로 테이블안에는 중요한데이터가 들어갈수 있음(개인정보 등) 
-- 데이터베이스 관리자(DBA)가 View를 만들어서 사람(개발자, 일반사용자)에게 제공
-- 복잡한 sql구문을 view로 단순화 시킬수 있음
-- 관리자나 프로젝트 매니저가 view를 생성해서 제공 

CREATE VIEW shopdb.v_membertbl
AS SELECT memberName, memberAddr FROM shopdb.membertbl;

SELECT * FROM shopdb.v_membertbl;

-- 다음 내용은 데이터베이스의 가장 중요한 작업 중 하나인.. backup, restore
-- 메뉴에서 처리할 수 있어요 
-- 방금 shopdb라는 schema를 export (back up) 했다
-- 이제 shopdb라는 schema를 삭제

-- DROP DATABASE shopdb;

-- --------------------------------------------------------
-- 두개의 테이블 생성
-- 만약 지금 내가 사용하고 있는 데이터베이스(schema)가 지정되어 있다면 데이터베이스(schema)명을 생략가능

-- 데이터베이스(schema) 지정
USE shopdb;

-- pk를 지정하지 않고 userTBL을 만들어 보자
CREATE TABLE shopdb.userTBL (
	userName VARCHAR(6),
    userAddr varchar(12),
    userMobile varchar(11)
);

-- 이상태에서 데이터 입력하기
insert into userTBL values('아이유', '서울', '1234');
insert into userTBL values('김연아', '인천', '5678');
insert into userTBL values('신사임당', '부산', '9011');

-- 입력이 잘 되었는지 확인
select * from userTBL;
-- 아이유	 서울	1234
-- 김연아	 인천	5678
-- 신사임당 부산	9011

-- 테이블 삭제
drop table usertbl;


-- pk를 지정해서 userTBL을 만들어 보자
CREATE TABLE shopdb.userTBL (
	userName VARCHAR(6) primary key,
    userAddr varchar(12),
    userMobile varchar(11)
);

insert into userTBL values('아이유', '서울', '1234');
insert into userTBL values('김연아', '인천', '5678');
insert into userTBL values('신사임당', '부산', '9011');

select * from userTBL;

-- primary key를 기준으로 오름차순 정렬되어 데이터가 저장된다
-- 그래서 primary key로 설정하면 clustered index가 자동으로 설정되고 데이터가 사전식으로 정렬되어 유지된다
-- 김연아	    인천	5678
-- 신사임당	부산	9011
-- 아이유	    서울	1234
-- 어제 했던 그냥 index를 생성하는건... secondary index라고 하고 이 secondary index는 B-Tree를 따로 구성함. 정렬같은거 안함.

-- 두번째 table 생성하자
create table buyTBL (
	userName varchar(6) not null, -- foreign key
    productName varchar(10) not null,
    productPrice int not null,
    buyAmount int not null,
    foreign key(userName) references userTBL(userName)
);

-- 데이터 입력
-- 잘못입력해보자
insert into buytbl values('홍길동', '냉장고', 1000, 2);
-- 에러뜸. foreign key 조건에 위배됐다고 오류뜸
-- 제대로 입력하기
insert into buytbl values('아이유', '냉장고', 1000, 2);
insert into buytbl values('김연아', 'tv', 2000, 1);
insert into buytbl values('신사임당', '컴퓨터', 3000, 3);

select * from buytbl ;

-- usertbl에 특정 user를 삭제
delete from usertbl where userName = '아이유';
-- 안됨. buytbl에 아이유가 존재해서

-- sql 알아보기
-- select 알아보기

-- 현재 사용가능한 모든 database(schema)를 출력
show databases;

-- 사용할 데이터베이스를 선택
use employees;

-- 현재 데이터베이스안의 테이블 조회
show tables;

-- table중 employees라는 table이 있음. 이 table의 명세를 알고 싶음
desc employees;

-- 잠깐 데이터 타입에 대해서 하나만 알아보고 넘어가자
-- int : 정수형 (-21억 ~ +21억)
-- varchar(variable character) : 가변 문자열
-- varchar(10) => 최대 10글자까지 저장할 수 있는 가변 문자열 타입.
			-- => 만약 5글자만 저장하면 사용되는 공간이 5글자로 줄어듦. 저장되는 공간을 효율적으로 사용
-- char(10) => 최대 10글자까지 저장할수 있는 고정 문자열 타입.
		-- => 만약 5글자만 저장. 그래도 공간 자체는 10글자 공간이 할당. 공간을 효율적으로 사용은 못함
        -- => varchar보다 연산이 빠름
-- date  => 날짜타입(연월일)
-- datetime => 날짜타입(연월일시분초)

-- table에서 특정 데이터를 추출하기 위해서 사용하는 dml은 select

-- select 컬럼(들) from 스키마.테이블(view)
select emp_no, first_name, hire_date from employees;  -- 아까 위에서 use employees 해놔서

select emp_no, first_name, hire_date from employees limit 5;
-- 결과를 result grid(결과 레코드 집합, result set)

-- 결과 레코드 집합(result set)은 테이블 형태. 당연히 컬럼이 존재 => select한 컬럼명이 사용
-- 결과 레코드 집합에 컬럼명 변경 가능 => alias를 이용

select emp_no as '사번',
		first_name as '이름',
        hire_date as '입사일'
	from employees limit 5;
    
-- 데이터가 너무 많아서.. 정상적으로 수행되었는지 확인이 힘듦 (데이터 30만개임 employee)
-- 그래서 다른 테이블과 데이터를 이용해서 select에 대한 내용을 좀더 알아보자

-- 데이터베이스가 존재하면 지우자
drop database if exists sqldb;

-- 데이터베이스를 생성하자
create database sqldb;

-- sqldb라는 데이터베이스가 생성되었으니 사용하자
use sqldb;

-- 테이블 생성
create table usertbl (
	userID char(8) primary key,     -- 사용자 id
    userName varchar(10) not null,  -- 사용자 이름
    birthYear int not null,         -- 출생연도
    userAddr char(2) not null,      -- 지역(2글자짜리 지역명)
    mobile1 char(3),                -- 휴대폰 앞자리(3자리)
    mobile2 char(8),                -- 휴대폰 뒷자리(8글자)
    userHeight smallint,            -- 키 (smallint는 작은정수)
    userDate date                   -- 회원가입
);

create table buyTBL(
	num int auto_increment primary key,  -- 순번(pk)
    userID char(8) not null,             -- 사용자 id (fk)
    productName char(6) not null,        -- 제품명
    productGroup char(4),                -- 제품분류
    productPrice int not null,           -- 제품단가
    buyAmount int not null,              -- 구매수량
    foreign key(userID) references userTBL(userID)
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














