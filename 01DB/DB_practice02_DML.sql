# 데이터베이스, 테이블 만들기 
CREATE DATABASE sample_db;
DROP DATABASE sample_db;

# DB 조회
SHOW DATABASES;

# TABLE 만들기
USE sample_db;
# CREATE table 테이블명(컬럼명1 데이터타입, 컬럼명2 데이터타입id...);
CREATE table customers(id int, name varchar(100), sex varchar(20), phonenumber varchar(20), address varchar(255));

# TABLE 삭제하기
DROP table customers;

# market_db 만들기
CREATE DATABASE market_db;
USE market_db;

# hongong1 테이블 만들기 toy_id(INT), toy_name(CHAR(4)), age(INT)
CREATE TABLE hongong1 (toy_id INT, toy_name CHAR(4), age INT);
SHOW TABLES;
DESC hongong1;

# 생성한 테이블에 데이터 입력하기 INSERT INTO 테이블명(컬럼명1, 컬럼명2...) VALUES (1, '우디', 25);
INSERT INTO hongong1(toy_id, toy_name, age) VALUES(1, '우디', 25);

select * from hongong1;
# id: 2, name 버즈
INSERT INTO hongong1(toy_id, toy_name) VALUES(2, '버즈');
SELECT * FROM hongong1;

INSERT INTO hongong1(toy_name, age, toy_id) VALUES('제시', 20, 3);
INSERT INTO hongong1 VALUES(5, '포테이토', 40);
INSERT INTO hongong1 VALUES(6, '강아지');
INSERT INTO hongong1(toy_name, age) VALUES('강아지', 3);

# primary key와 auto increment 기능을 추가한 테이블 만들기
CREATE TABLE hongong2 (
toy_id int AUTO_INCREMENT PRIMARY KEY,
toy_name char(4),
age int);

DESC hongong2;

# AUTO INCREAMENT가 지정된 테이블에 데이터 넣기
INSERT INTO hongong2 VALUES (NULL, '보핍', 25);
SELECT * FROM hongong2;
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES (NULL, '렉스', 21);

# 테이블 수정하기 alter
# 컬럼 추가 ALTER TABLE 테이블명 ADD COLUMN 컬럼명, 자료형, 속성(NOT NULL, UNIQUE...)
# hongong2 테이블에 country 컬럼 추가하기
ALTER TABLE hongong2 ADD COLUMN country varchar(100);

# 기존 테이블에 있는 자료 UPDATE 하기 WHERE(필수)과 함께 쓰기 - 전체 수정이 아닌 일부 정보만 변경하는 것이기 때문에 
# UPDATE 테이블명 SET 컬럼명 = 업데이트 할 값 WHERE toy_id=1;
UPDATE hongong2 SET country='미국' WHERE toy_id=1;
UPDATE hongong2 SET age=30 WHERE toy_id=1;

# 테이블의 내용은 모두 지우고 테이블의 구조는 남기고 싶을 때 TRUNCATE
# TRUNCATE TABLE hongong2;

# 테이블의 데이터 삭제 delete from 테이블명 WHERE 조건 
DELETE FROM hongong1 WHERE toy_id=2;

# idx 컬럼 추가  primary key로 지정하고 AUTO_INCREMENT
ALTER TABLE hongong1 ADD COLUMN idx INT AUTO_INCREMENT PRIMARY KEY;
DELETE FROM hongong1 WHERE idX=11;
INSERT INTO hongong1 VALUES(7, '렉스', 30, NULL);
SELECT * FROM hongong1; 

# CREATE, INSERT(READ), UPDATE, DELETE (CRUD)

# 회원테이블, 제품테이블 만들기

CREATE TABLE member (
id int AUTO_INCREMENT PRIMARY KEY,
member_id varchar(20),
name varchar(30),
address varchar(100));

DESC member;

INSERT INTO member VALUES(null, 'tess', '나훈아', '경기 부천시 중동');
INSERT INTO member VALUES(null, 'hero', '임영웅', '서울 은평구 증산동');
INSERT INTO member VALUES(null, 'iyou', '아이유', '인천 남구 주안동');
INSERT INTO member VALUES(null, 'jyp', '박진영', '경기 고양시 장항동');

#INSERT INTO 할 때 여러번 작성하지 않고 요약해서 하는 법
-- INSERT INTO member VALUES
-- (nULL, "tess", "나훈아", "경기 부천시 중동"),
-- (null, 'hero', '임영웅', '서울 은평구 증산동'),
-- (null, 'iyou', '아이유', '인천 남구 주안동'),
-- (null, 'jyp', '박진영', '경기 고양시 장항동');

select * from member;


CREATE TABLE product (
제품이름 varchar(10),
가격 int,
제조일자 varchar(20),
제조회사 varchar(30),
남은수량 int);
INSERT INTO product VALUES("바나나", 1500, "2024-07-01", "델몬트", 17);
INSERT INTO product VALUES('카스', 2500, '2023-12-12', 'OB', 3);
INSERT INTO product VALUES('삼각김밥', 1000, '2025-02-26', 'CJ', 22);
select * from product;

# product 테이블에 prod_id 컬럼을 추가하고 AUTO_INCREMENT, Primary Key 추가하기
ALTER TABLE product ADD COLUMN prod_id INT AUTO_INCREMENT Primary Key;
DESC member;
INSERT INTO member (id, member_id, name)
VALUES(NULL, 'akmu3', '악동뮤지션');

# ROLLBACK 연습
CREATE DATABASE mywork;
USE mywork;
CREATE TABLE emp_test (
emp_no int not null,
emp_name varchar(30) not null,
hire_date date null,
salary int null,
PRIMARY KEY(emp_no));
DESC emp_test;
INSERT INTO emp_test (
emp_no, emp_name, hire_date, salary)
VALUES 
(1005, '퀴리', '2021-03-01', 4000),
(1006, '호킹', '2021-03-05', 5000),
(1007, '패러데이', '2021-04-01', 2200),
(1008, '맥스웰', '2021-04-04', 3300),
(1009, '플랑크', '2021-04-05', 4400);
SELECT * FROM emp_test;

# UPDATE 연습
# 호킹의 salary를 10000으로 변경
# 패러데이의 hire_date를 2023-07-11로 변경
# 플랑크가 있는 데이터를 삭제
UPDATE emp_test SET salary = 10000 WHERE emp_no=1006;
UPDATE emp_test SET hire_date="2023-07-11" WHERE emp_no=1007;
DELETE FROM emp_test WHERE emp_no=1009;

# 오토커밋 옵션 활성화 확인
SELECT @@autocommit; # 결과가 1이면 오토커밋 활성화, 0이면 비활성화
SET autocommit = 0; # 오토커밋 비활성화

CREATE TABLE emp_tran1 AS SELECT * FROM emp_test; # select 결과값으로 emp_trans1로 만들라는 뜻 
SELECT * FROM emp_test;
DESC emp_tran1;
DESC emp_test;
ALTER TABLE emp_tran1 ADD constraint primary key(emp_no);
DROP TABLE emp_tran1;
SHOW TABLES;
rollback;

-- COMMIT - ROLLBACK 이해하기







