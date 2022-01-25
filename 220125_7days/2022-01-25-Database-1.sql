-- -----------------------------------------
-- 테이블에 데이터를 입력하고 데이터를 추출하는 SQL구문

-- 데이터 추출
-- SELECT 컬럼명 FROM 테이블명;
-- * => 모든 컬럼을 지칭
SELECT * FROM shopdb.membertbl;
SELECT memberName FROM shopdb.membertbl;

-- SQL구문을 이용해야 해요!
-- SQL이라고 불리는 관계형 데이터베이스용 언어를 사용해야 해요!
-- SQL은 표준이고 모든 관계형 데이터베이스에 공용으로 사용이 가능.
-- ( -- 뒤에 한칸을 꼭 띄어야 해요.그래야 주석이 되요! )

-- 데이터 삽입 => INSERT 구문이용
INSERT INTO shopdb.membertbl VALUES('iu','아이유','부산');
INSERT INTO shopdb.membertbl VALUES('shin','신사임당','인천');
INSERT INTO shopdb.membertbl VALUES('kim','김연아','광주');


SELECT * FROM shopdb.producttbl;
-- productTBL에 데이터를 삽입 => INSERT 구문이용
INSERT INTO shopdb.producttbl VALUES('컴퓨터',1000,'2022-01-01','삼성',5);
INSERT INTO shopdb.producttbl VALUES('세탁기',2000,'2022-01-02','LG',2);
INSERT INTO shopdb.producttbl VALUES('냉장고',1500,'2022-01-05','대우',4);

-- 이렇게 데이터를 삽입을 한 후 원하는 데이터를 추출해 보아요!
SELECT * FROM shopdb.membertbl;
SELECT memberName, memberAddr FROM shopdb.membertbl;
SELECT memberName, memberAddr FROM shopdb.membertbl WHERE memberName = '아이유';

-- --------------------------------------------------------------------

-- Database의 Index(색인)
-- 검색을 빠르게 하기 위해서 사용하는게 Index
-- Index는 column에 설정하는거예요! => 그러면 해당 column안에 있는 값을 이용해서
-- B-Tree(Balanced Tree)형태로 데이터를 분배시켜서 저장하는 Index를 따로 생성해요!

-- 테이블을 하나 만들꺼예요! => SQL구문을 이용해서 만들꺼예요!
CREATE TABLE shopdb.indexTBL (
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    hire_date DATE
);

-- 데이터를 입력해야 해요! (500명 입력할꺼예요!!)
-- 하나하나 입력하기 보다 기존에 데이터를 이용해서 입력할꺼예요!
SELECT first_name, last_name, hire_date 
FROM employees.employees LIMIT 500;
-- 위에 살짝 눈을크게뜨고 보면...Limit to 1000 rows가 설정되어 있어요!

-- SELECT한 결과를 통으로 입력할 수 있어요!
INSERT INTO shopdb.indexTBL
SELECT first_name, last_name, hire_date 
FROM employees.employees LIMIT 500;

-- 확인을 해 보아요!
SELECT * FROM shopdb.indexTBL;

-- 이제 first_name이 'Mary'인 사람을 찾을 꺼예요!
SELECT * FROM shopdb.indexTBL WHERE first_name = 'Mary';
-- 잘 찾았어요! 어떻게 이걸 찾았을까요?
-- Execution plan

-- 특정컬럼(first_name)에 index를 설정해서 B-Tree를 생성
CREATE INDEX idx_indexTBL_firstname ON shopdb.indexTBL(first_name);

-- 인덱스가 설정된 후 다시 검색을 해 보아요!
SELECT * FROM shopdb.indexTBL WHERE first_name = 'Mary';

-- 인덱스는 많을 수록 좋은거 아닌가요?(여러컬럼에 컬럼마다 index를 설정하면 좋은거 아닌가요?)
-- 인덱스를 설정하면 해당 컬럼의 데이터를 이용해서 B-Tree라는 자료구조를 만들어요!
-- 그런데 데이터가 추가되거나 변경되거나 삭제되면 이 B-Tree구조를 다시 만들어야 해요!
-- Overhead가 발생!
-- 그래서 전체적인 performance를 따져서 index를 설정해야 해요!
