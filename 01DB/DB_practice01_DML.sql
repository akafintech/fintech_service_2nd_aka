USE titanic;
SHOW TABLES;
 # 데이터 조회 명령 SELECT 컬럼명 / *(전체) FROM 테이블명;
 SELECT * FROM p_info;
 
 # 테이블에서 1개 컬럼만 조회할 때 SELECT 컬럼명 FROM 테이블명;
 SELECT Name from p_info;
  
 # 테이블에서 2개 이상 컬럼을 조회할 때 SELECT 컬럼명1, 컬럼명2... FROM 테이블명;
 SELECT Name, Age FROM p_info;
 DESC p_info; # 테이블의 구조를 보고 싶을 때 DESC 테이블명;
 
 # 테이블에서 데이터를 10개만 조회하고 싶을 때 SELECT * FROM 테이블명 LIMIT 10;
 # 테이블에서 데이터를 N개만 조회하고 싶을 때 SELECT * FROM 테이블명 LIMIT N;
 SELECT * FROM p_info LIMIT 10;
 
 # 조건에 맞는 데이터 검색할 때 WHERE + 비교연산자, 논리연산자
 # 성별이 남자인 경우만 조회하고 싶을 때 :
SELECT * FROM p_info WHERE Sex="male";

 # 나이가 40세 이상인 사람만 조회하고 싶을 때
 SELECT * FROM p_info WHERE Age>=40;
 
 # 조건을 2개 이상 줄 때 논리연산자 묶기 and, or
 select * from p_info where Age<10 or Sex="male" ;
 
 #p_info 테이블에서 20세 이상 50세 미만의 여성을 조회
 select * FROM p_info where Age>=20 and Age<50 and Sex="female";
 
 # p_info 테이블에서 SibSp가 1이거나 Parch가 1이상인 사람을 조회
 select * from p_info where SibSp=1 or Parch>=1;
 
 #t_info 테이블에서 Pclass가 1인 승객을 조회
 DESC t_info;
 select * from t_info where Pclass=1;
 
 #t_info 테이블에서 Pclass가 2인 또는 Fare가 50 초과인 승객을 조회
 select * from t_info where Pclass=2 or Fare>50;
 
 #survived 테이블에서 Survived가 1인 승객을 조회
 select * from survived where Survived = 1;
 
 # IN, LIKE, BETWEEN, IS NULL, IS NOT NULL
 #p_info 테이블에서 Sibsp 컬럼의 값이 1,2,3인 행 찾기
 select * from p_info where Sibsp in(1, 2, 3);
 
 #p_info 테이블에서 Sibsp 컬럼의 값이 0,1,2,3이 아닌 행 찾기
 select * from p_info where Sibsp not in(0,1,2,3);
 
 # LIKE 는 문자열 안에서 특정 단어를 포함한 행을 찾을 때 보통 %와 같이 사용
 select * FROM p_info where name LIKE "Rice, Master. Eugene";
 select * FROM p_info where name = "Rice, Master. Eugene";
 select * FROM p_info where name LIKE "Rice%";
 select * FROM p_info where name LIKE "%Eric";
 select * FROM p_info where name LIKE "%Oscar%";
 
 # BETWEEN a and b - a 이상 b이하를 찾을 때
 # Age 컬럼의 값이 20이상 40이하인 값 찾을 때
 SELECT * FROM p_info where Age between 20 and 40;
 SELECT * FROM p_info where Age >=20 and Age <=40;
 
 # IS NULL , NOT NULL
 #p_info 테이블에서 Age의 값이 Null인 것 찾기
 SELECT * FROM p_info WHERE Age IS NULL;
 SELECT * FROM p_info WHERE Age IS NOT NULL;
 
 #t_info 테이블에서 Fare가 100이상 1000이하인 승객을 조회
 SELECT * FROM t_info WHERE Fare BETWEEN 100 and 1000;
 
 #  t_info 테이블에서 Ticket이 PC로 시작하고 Embarked가 C 혹은 S인 승객을 조회
 SELECT * FROM t_info WHERE Ticket like "PC%" AND Embarked LIKE "c" OR "S";
 SELECT * FROM t_info WHERE Ticket like "PC%" AND Embarked IN ("C" or "S");
 
 #t_info 테이블에서 Pclass가 1 혹은 2인 승객을 조회
 SELECT * FROM t_info WHERE Pclass IN(1, 2);
 
 #t_info 테이블에서 Cabin에 숫자 59가 포함된 승객을 조회
 SELECT * FROM t_info WHERE Cabin LIKE "%59%";
 
 #p_info 테이블에서 Age가 NULL이 아니면서 이름에 James가 포함된 40세 이상의 남성을 조회
 SELECT * FROM p_info WHERE Age>=40 AND name LIKE "%James%" AND Sex="male";
 
 # 데이터의 순서 정렬하기 ORDER BY
 # SELECT * FROM 테이블명 WHERE 컬럼명 + 조건 ORDER BY 기준(정렬할)컬럼 오름차순 ASC, 내림차순 DESC
 # p_info 테이블에서 Age가 NULL이 아니면서 이름에 Miss가 포함된 40세 이하의 여성을 조회하고 나이를 기준으로 내림차순 정렬하기
 SELECT * FROM p_info WHERE Age<=40 AND name LIKE "%Miss%" AND Sex="female" ORDER BY Age DESC;
 
 # GROUP BY 특정 컬럼을 기준으로 그룹 연산을 할 떄 (평균, 최소값, 최대값, 행 갯수, 중복값 없는 행 갯수...)
 # SELECT 기준컬럼명, 그룹연산 함수 FROM 테이블명 WHERE 컬럼명 GROUP BY 기준컬럼;
 # p_info 테이블에서 나이가 NULL이 아닌 행의 성별 별 나이 평균 구하기
 # 그룹연산 함수 AVG() 평균, MIN() 최소값, MAX() 최대값, COUNT() 행 갯수
 SELECT Sex, AVG(Age) FROM p_info WHERE AGE IS NOT NULL GROUP BY Sex;
 
 # 그룹연산 후의 결과에서 특정 조건을 충족하는 행을 찾고 싶을 때 HAVING
 # t_info 테이블에서 Pclass별 Fare 가격 평균을 구하고 그 중 가격 평균이 50을 초과하는 결과만 조회하기
 SELECT Pclass, AVG(Fare) f
 FROM t_info GROUP BY Pclass HAVING f>50;
 
 #INNER JOIN (교집합) 왼쪽, 오른쪽에 있는 테이블에서 기준 컬럼의 값이 일치하는 것만 합친다
 # passenger 컬럼(왼쪽)과 ticket 컬럼(오른쪽)을 INNER JOIN 하기
 SELECT * FROM passenger, ticket LIMIT 3;
 
 # SELECT * FROM 테이블1 명(왼쪽이 된다) INNER JOIN 테이블2 명(오른쪽이 된다) ON 테이블1명.기준컬럼명 = 테이블2명.기준컬럼명
 SELECT * FROM passenger p INNER JOIN ticket t ON p.PassengerId = t.PassengerId;
 
 # LEFT JOIN
 SELECT * FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId;
 
 # RIGHT JOIN
 SELECT * FROM passenger p RIGHT JOIN ticket t ON p.PassengerId = t.PassengerId;
 
 # 두개의 테이블을 조인하면서 Name, Age, Pclass, Fare만 보고 싶을 때
 SELECT passenger.PassengerId, Name, Age, Pclass, Fare FROM passenger RIGHT JOIN ticket ON passenger.PassengerId = ticket.PassengerId;
 
 # 약칭, 별칭 AS
SELECT p.PassengerID, Name, Age, Pclass, Fare FROM passenger AS p LEFT JOIN ticket AS t ON p.PassengerId = t.PassengerId;

# AS 생략
SELECT p.PassengerId, Name, Age, Pclass, Fare FROM passenger p LEFT JOIN ticket t ON p.PassengerId = t.PassengerId;

# 3개의 테이블 1개로 합치기 - (테이블1 + 테이블2) + 테이블 3

SELECT *
FROM passenger p
INNER JOIN ticket t ON p.PassengerId = t.PassengerId
INNER JOIN survived s ON p.PassengerId = s.PassengerId;

# 1. passenger, ticket, survived 테이블을 조인하고 Survived가 1인 사람들만 찾아서 Name, Age, Sex, Pclass, survived 컬럼을 출력하시오.
# SELECT * FROM passenger, ticket, survived limit 3;
SELECT Name, Age, Sex, Pclass, survived
FROM passenger p
INNER JOIN ticket t ON p.passengerId = t.passengerId
INNER JOIN survived s ON p.passengerId = s.passengerId
where survived = 1;

#2. 1의 결과를 10개만 출력하시오.
SELECT Name, Age, Sex, Pclass, survived
FROM passenger p
INNER JOIN ticket t ON p.passengerId = t.passengerId
INNER JOIN survived s ON p.passengerId = s.passengerId
where survived = 1 LIMIT 10;

#3. Passenger 테이블을 기준 ticket, survived테이블을 LEFT JOIN 한 결과에서 성별이 여성이면서 Pclass가 1인 사람 중 생존자(survived=1)를 찾아 이름, 성별, Pclass를 표시하시오.
SELECT Name, Sex, Pclass
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Sex="female" AND Pclass = 1 AND survived = 1;

#4. passenger, ticket, survived 테이블을 left join 후 나이가 10세 이상 20세 이하 이면서 Pclass 2인 사람 중 생존자를  표시하시오.
SELECT *
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Age BETWEEN 10 AND 20 AND Pclass = 2 AND survived = 1;

#5. passenger, ticket, survived 테이블을 left join 후 성별이 여성 또는 Pclass 가 1인 사람 중 생존자를 표시하시오.
SELECT *
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE survived = 1 AND (Sex="female" OR Pclass = 1);

#6.  passenger, ticket, survived 테이블을 left join 후 생존자 중에서 이름에 Mrs가 포함된 사람을 찾아 이름, Pclass, 나이, Parch, Survived 를 표시하시오.
SELECT Name, Pclass, Age, Parch, Survived
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Survived = 1 AND Name LIKE "%Mrs%";

#7. passenger, ticket, survived 테이블을 left join 후 Pclass가 1, 2이고 Embarked가 s, c 인 사람중에서 생존자를 찾아 이름, 성별, 나이를 표시하시오.
# SELECT * FROM t_info, p_info;

SELECT Name, Sex, Age
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Pclass IN(1, 2) AND Embarked IN("s" ,"c") AND Survived = 1;

-- 8. passenger, ticket, survived 테이블을 left join 후 이름에 James가 들어간 사람중 생존자를 찾아 이름, 성별, 나이 를 표시하고 나이를 기준으로 내림차순 정렬하시오.
SELECT Name, Sex, Age
FROM Passenger p
LEFT JOIN ticket t ON p.PassengerId = t.PassengerId
LEFT JOIN survived s ON p.PassengerId = s.PassengerId
WHERE Name LIKE "%James%" AND survived = 1 ORDER BY Age DESC;

-- 9. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서 성별별, 생존자의 숫자를 구하시오. 생존자 숫자 결과는 별칭을 Total로 하시오.
SELECT Sex, count(*) Total # count(*), count(survived), count(s.survived) 차이와 정확도 질문 할 것
FROM Passenger p
INNER JOIN ticket t ON p.PassengerId = t.PassengerId
INNER JOIN Survived s ON p.PassengerId = s.PassengerId
WHERE s.Survived = 1 GROUP BY Sex;
#SELECT 기준컬럼명, 그룹연산 함수 FROM 테이블명 WHERE 컬럼명 GROUP BY 기준컬럼;

-- 10. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서 성별별, 생존자의 숫자, 생존자 나이의 평균을 구하시오. 생존자 숫자 결과는 별칭을 Total로 하시오.
SELECT Sex, AVG(Age), count(*) Total
FROM Passenger p
INNER JOIN ticket t ON p.PassengerId = t.PassengerId
INNER JOIN Survived s ON p.PassengerId = s.PassengerId
WHERE s.Survived = 1 GROUP BY Sex;

-- 11. passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서
-- 성별별, pclass별, 생존자별로
-- pclass, sex, survived ,
-- survived의 클래스별 합계, 생존자/사망자의 나이 평균을 구하시오.
-- survived의 별칭은 is_survived로,
-- 생존자 클래스별 합계는 별칭을 survived_total로,
-- 생존자/사망자의 나이 평균은 별칭을 avg_age로 하시오.
# 문제 이해못함.......
-- SELECT Pclass, Sex, Survived, AVG(s.Survived)
-- FROM Passenger p
-- INNER JOIN ticket t ON p.PassengerId = t.PassengerId
-- INNER JOIN Survived s ON p.PassengerId = s.PassengerId
-- WHERE s.Survived IN (1,2) GROUP BY Sex, Pclass, survived;