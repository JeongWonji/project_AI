SELECT * FROM shopdb.membertbl;
SELECT memberName FROM shopdb.membertbl;
# sql 구문 이용, sql이라고 불리는 관계형 데이터베이스용 언어 사용
# sql은 표준이고 모든 관계형 데이터베이스에 공용으로 사용이 가능

-- 데이터 삽입 => insert 구문 이용
INSERT INTO shopdb.membertbl VALUES('iu', '아이유', '부산'); 
INSERT INTO shopdb.membertbl VALUES('shin', '신사임당', '인천'); 
INSERT INTO shopdb.membertbl VALUES('kim', '김연아', '광주'); 

SELECT * FROM shopdb.producttbl;

INSERT INTO shopdb. producttbl VALUES('컴퓨터', 1000, '2022-01-01', '삼성', 5);
INSERT INTO shopdb. producttbl VALUES('세탁기', 2000, '2022-01-02', 'LG', 2);
INSERT INTO shopdb. producttbl VALUES('냉장고', 1500, '2022-01-05', '대우', 4);

select * from shopdb.membertbl;
select memberName, memberAddr from shopdb.membertbl;
select memberName, memberAddr from shopdb.membertbl where memberName = '아이유';

-- -------------------------------------------------------------------------------

-- index(색인)
-- 검색을 빠르게 하기 위해서 사용하는게 인덱스
-- index는 column에 설정 -> 그러면 해당 column안에 있는 값을 이용해서
-- B-Tree(Balanced Tree)형태로 데이터를 분배시켜서 저장하는 index를 따로 생성함

-- 테이블 하나 만들자
CREATE TABLE shopdb.indexTBL (
	first_name VARCHAR(14),
    last_name VARCHAR(16),
    hire_date DATE
);

-- 데이터 입력하자
-- 하나하나 입력하기 보다 기존에 데이터를 이용해서 입력하자
select * from employees.employees LIMIT 500;
-- 위에 살짝 눈을 크게 뜨고 보면.. limit to 1000 rows가 설정되어 있음

insert into shopdb.indextbl
select first_name, last_name, hire_date
from employees.employees limit 500;

select * from shopdb.indextbl;

-- first name이 mary인 사람 찾기
select * from shopdb.indextbl where first_name = 'Mary';

-- 특정컬럼(first_name)에 index를 설정헤서 B-Tree를 생성
create index idx_indexTBL_firstname on shopdb.indextbl(first_name);

-- 인덱스 설정된 후 다시 검색을 해보아요
select * from shopdb.indextbl where first_name = 'Mary';

-- 인덱스는 많을수록 좋은가? (여러컬럼에 컬럼마다 index설정하면 좋은가?)
-- 인덱스를 설정하면 해당 컬럼의 데이터를 이용해서 B-Tree라는 자료구조를 만듦
-- 그런데 데이터가 추가되거나 변경되거나 삭제되면 이 B-Tree구조를 다시 만들어야함
-- overhead가 발생
-- 그래서 전체적인 performance를 따져서 index를 설정해야한다.