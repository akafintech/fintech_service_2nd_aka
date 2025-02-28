SHOW databases;
SHOW TABLES;
USE SAKILA;
SHOW TABLES;
USE WORLD;

# ERD SYS 만들기
-- FILE - NEW MODEL - SAVE 

select * from buy_table;

select * from stock_company_info;
select * from 2024_09_stock_price_info;
use korea_exchange_rate;

# 2020년 1월 1일부터 12-31까지 데이터에서 통화별 현찰_살때_환율의 최소, 최대, 평균가
select 통화, min(현찰_살때_환율) 최저가, max(현찰_살때_환율) 최고가,
ROUND(avg(현찰_살때_환율),2) 평균가 #ROUND(이름, 소수 N번째까지 노출)
from exchange_rate
where date between "2020-01-01" AND "2020-12-31"
GROUP BY 통화;

show tables;
# drop tables stock_2024_all;
select * from 2024_07_stock_price_info;
select * from 2024_08_stock_price_info;

# 7,8,9월로 나누어져 있는 데이터를 1개의 테이블로 모으기 위해
# join(가로, 옆으로 붙기 때문에) 말고 union 사용

create table stock_2024_all
select * from 2024_07_stock_price_info
union all
select * from 2024_08_stock_price_info
union all        
select * from 2024_09_stock_price_info;

show tables;
SELECT*from stock_2024_all;

# pandas concat 함수로 union/join 역할을 함


#######################################################################################

# SQL 함수
# SELECT 함수(값)  e.g. MIN(), MAX(), AVG()...

-- 절대값 구하는 함수 ABS( )
SELECT ABS(-34), ABS(1), ABS(-256);

# 문자열의 길이 측정 LENGTH(문자열); -- 띄어쓰기 등 공백을 포함 한다 
SELECT length("mysql ");

# 반올림 함수 ROUND()
SELECT ROUND(3.14467, 2); # 3번째 자리에서 반올림을 해서 2번째 자리수 까지 표기한다

# 올림 CEIL, 내림 FLOOR
SELECT CEIL(4.5);
SELECT FLOOR(4.5);

# 연산자를 통한 계산 + - * / %, mod(나머지) div(몫)
SELECT 7/2; #나누기
SELECT 7*2; #곱하기
SELECT 7+2;
SELECT 7-2;
SELECT 7%2; -- 나머지 연산자%2 에서 나머지가 1이면 홀수, 나머지가 0이면 짝수 홀짝 구분할 때 많이 사용
select 7 div 2;
select 7 mod 2;

# power(n , n)(제곱), sqrt(루트), sign(음수 양수) 확인
select power(4, 3); # 4의 3제곱 계산
select sqrt(3);
select sign(5), sign(-98); # 양수는 1로 음수는 -1로 표기

# truncate(값, 자릿수) 버림 함수(select와 같이 사용)
select round(2.2345, 3),
truncate(2.2345, 3); #floor는 어떤 수가 오든 버림 처리하지만 truncate는 자릿수를 지정해서 버릴 수 있다 
select round(29282.2345678, -3); #-자릿수가 오면 소수점 앞으로 개수를 세서 반올림 

#문자열 함수
# 문자의 길이를 알아보는 함수
select char_length('my sql'), length('my sql');
select char_length('호 길동'), length('홍 길동');
 
# 문자를 연결하는 함수 concat(), concat_ws()
select concat('this', ' is ', 'my sql'); # concat('','',''...); 요소를 단순히 잇기만 하기 때문에 필요에 따라 공백을 넣어줘야 함
select concat('this', null, 'my sql'); #null 있으면 null로 출력됨 
select concat_ws(' : ', 'this', ' is ', 'my sql'); # 맨 앞 요소가 사이사이에 들어감 (this : is : my sql)

# 대문자를 소문자로 바꾸는 함수 lower(), 소문자를 대문자로 upper()
select lower('ABcd');
select upper('abcD');

# 문자열의 자릿수를 일정하게 하고 빈 공간을 지정한 문자로 채우는 함수
# lpad(값, 자릿수, 채울문자), rpad(값, 자릿수, 채울문자)
select lpad('sql', 7, ' '); # 오른쪽부터 채워 나감. 값-채울문자 
select rpad('sql', 7, '='); # 왼쪽부터 채워 나감. 채울문자 - 값 

# 공백을 없애는 함수 ltrim(문자열), rtrim(문자열)
select ltrim('    SQL    '); # 왼쪽의 공백을 지움 
select rtrim('    SQL    '); # 오른쪽의 공백을 지움

# 문자열의 공백을 앞뒤로 삭제하는 trim()
SELECT trim('    sql   ');
select trim('    my sql    '); # 문자열의 시작과 끝에 있는 공백만 제거해 주기 때문에 my sql의 공백은 제거 불가
select trim('    my sql study    '); # 문자열 바깥쪽 공백만 제거 하고 안쪽 공백은 제거 불가
# python strip() 과 유사함.
 
 # 문자열을 잘라내는 함수 left(문자열, 길이), right(문자열, 길이)
 select left('this is my sql', 4), right('this is my sql', 5); # 길이를 4로 해서 자르고 이때 공백도 포함됨 
 select left('이것이 my sql이다', 7), right('이것이 my sql이다.', 5);

# 문자열을 중간에서 잘라내는 함수 substr(문자열, 시작위치, 길이), 공백 포함 
select substr('this is my sql', 6, 5);
select substr('this is my sql', 6); # 길이를 지정하지 않으면 시작위치부터 끝까지 표기 
# 문자 vs 문자열 구분 
# 인덱싱 알아놓을것

#문자열의 공백을 앞뒤로 삭제하고 문자열 앞뒤에 포함된 특정 문자도 삭제하는 함수
-- python 에서 strip와 동일하게 작동 , 여러 문자열 동시 삭제 불가 
# trim(leading '삭제할 문자' from, 전체 문자열);
select trim('    my sql    ');
select trim(leading '*' from '****my sql****'); # 문자 앞쪽에 있는 * 삭제 
select trim(trailing '*' from '****my sql****'); # 문자 뒤쪽에 있는 * 삭제
select trim(both '*' from '****my sql****'); # 문자 양쪽에 있는 * 삭제
select trim(both '*' from '****my ** sql****'); # 문자 가운데에 있는 *은 삭제 불가

# 날짜형 함수
SELECT curdate(); # 현재의 년-월-일 출력, () 안에 아무것도 없는 경우
select curtime(); # 현재의 시 : 분 : 초 출력, () 안에 아무것도 없는 경우
select now(); # 현재의 년-월-일 + 시 : 분 : 초 동시 출력
select current_timestamp(); # 현재의 년-월-일 + 시 : 분 : 초 동시 출력

# 요일 표시 함수 dayname(날짜)
select dayname(now());
select dayname("2025-05-05");

# 요일을 번호로 표기 dayofweek(날짜), 일(1), 월(2) ... 토(7)
select dayofweek(now());
select dayofweek("2025-05-05");

# 1년 중 오늘이 며칠째인지 dayofyear(날짜);
select dayofyear(now());
select dayofyear("2025-05-05");

# 날짜를 세분화해서 보는 함수 
# 현재 달의 마지막 날이 몇 일까지 있는지 출력
select last_day(now());
select last_day("2025-11-01");

# 입력한 날짜에서 연도만 추출하기 
select year(now());
select year("2025-11-01");

#입력한 날짜에서 월만 출력
select month(now());
select month("2025-11-01"); # 숫자로 출력 
select monthname("2025-11-01"); # 영어로 출력

# 몇 분기인지 출력 
select quarter(now());
select quarter("2025-11-01");

# 년도의 몇 주차인지
select weekofyear(now());
select weekofyear("2025-11-01");

# 날짜와 시간이 같이 있는 데이터에서 날짜와 시간을 구분해 주는 함수
select now();
select date(now());
select time(now());

# 날짜를 지정한 날 수 만큼 더하는 함수 date_add(날짜, interval 더할 날 수 day);
select date_add(now(), interval 5 day);
select adddate(now(), 5);

# 날짜를 지정한 날 수 만큼 빼는 함수 
# subdate(날짜, interval 뺄 날 수 day);
select subdate(now(), interval 5 day);
select subdate(now(), 5);

# 날짜와 시간을 년월, 날 시간, 분초 단위로 추출하는 함수 
# extract(옵션, from 날짜시간);
select extract(year_month from now());
-- select extract(day_hour from now());
select extract(minute_second from now());

# 날짜 간격을 계산할 때 쓰는 함수
# 날짜 1에서 날짜 2를 뺀 일 수 계산
# datediff(날짜1, 날짜2);
select datediff(now(), "2024-12-25");

# 날짜 포맷 함수 - 지정한 형식에 맞춰 출력해 주는 함수
# %Y 4자리 연도, %y 2자리 연도
# %M 4자리 월 영문, %m 2자리 월 숫자, %b 월의 축약 영문 표기 Jan, Feb... 
# %d 2자리 일 표기, %e 1자리 일 표기 

select date_format(now(), '%d-%b-%Y');
select date_format(now(), '%d-%M-%Y');
select date_format(now(), '%e-%b-%Y');
select date_format("2025-01-01", '%e-%b-%Y'); # 1일이 한자리 1로 나옴
select date_format("2025-01-01", '%d-%b-%Y'); # 1이 두자리 01로 나옴
select date_format("2025-01-01", '%d-%m-%y');

# 시간 포맷 함수
# %H 24시간제, %h 12시간제, %p AM PM, 
# %i 2자리 분 표시
# %S 2자리 초 표시
# %T 24시간제 시:분:초
# %r 12시간제 시:분:초 + AM/PM
# %W 요일의 영문표기, %w 숫자로 요일 표시 (일0, 월1... 토6)
select date_format(now(), '%H-%i-%S');
select date_format(now(), '%p %h-%i-%S');
select date_format(now(), '%T');
select date_format(now(), '%r');
select date_format(now(), '%w %r');

SELECT CEIL(4.5); -- 5 출력
SELECT FLOOR(4.5); -- 4 출력
SELECT 7%2;
select 7 div 2;
SELECT SQRT(4);
SELECT 7 DIV 2;
select char_length('홍 길동'), length('홍 길동');
select char_length('my sql'), length('my sql');