use prct5;
show tables;
select * from department;
insert into department values
(1, '수학'),
(2, '국문학'),
(3, '정보통신공학'),
(4, '모바일공학');

select * from student;
insert into student values
(1, '가길동', 177, 1),
(2, '나길동', 178, 1),
(3, '다길동', 179, 1),
(4, '라길동', 180, 2),
(5, '마길동', 170, 2),
(6, '바길동', 172, 3),
(7, '사길동', 166, 4),
(8, '아길동', 192, 4);

select * from professor;
insert into professor values
(1, '가교수', 1),
(2, '나교수', 2),
(3, '다교수', 3),
(4, '빌게이츠', 4),
(5, '스티브잡스', 3);

select * from course;
insert into course values
(1, '교양영어', 1, '2016/9/2', '2016/11/30'),
(2, '데이터베이스 입문', 3, '2016/8/20', '2016/10/30'),
(3, '회로이론', 2, '2016/10/20','2016/12/30'),
(4, '공업수학', 4, '2016/11/2', '2017/1/28'),
(5, '객체지향프로그래밍', 3, '2016/11/1', '2017/1/30');

SELECT * from student_course;
insert into student_course values
(1, 1),
(2, 1),
(3, 2), (4, 3), (5, 4), (6, 5), (7, 5);


# Q1. 학생번호, 학생명, 키높이, 학과번호, 학과명 정보 출력
select student_id, student_name, height, s.department_id, department_name
from student s left join department d on s.department_id = d.department_id;
-- 1대 다의 관계에서 다에 해당하는 것을 먼저 작성하는 것이 좋음. 

# Q2. '가교수' 교수의 교수아이디를 출력
select professor_id
from professor where professor_name='가교수';

# Q3 학과이름별 교수의 수를 출력
select department_name, COUNT(d.department_id)
from department d left join professor p on d.department_id = p.department_id
group by department_name;
-- 나의 풀이

select department_name, COUNT(professor_id)
from department d left join professor p on d.department_id = p.department_id
group by department_name;
-- 강사님 풀이

# Q4 '정보통신공학'과의 학생정보를 출력
select *
from student s left join department d
on s.student_id = d.department_id
where department_name='정보통신공학';

select student_id, student_name, height, d.department_id, department_name
from student s left join department d
on s.student_id = d.department_id
where department_name = '정보통신공학';

# Q5 '정보통신공학'과의 교수명 출력
select *
from professor p left join department d
on p.department_id=p.department_id
where department_name='정보통신공학';
######################### Q4,5 DB 수정해서 다시 할 것 ###

# Q6 학생 중 성이 '아' 인 학생이 속한 학과명과 학생명을 출력
select student_name, department_name
from student s left join department d
on s.department_id = d.department_id
where student_name like '아%';

# Q7 키가 180 - 190 사이에 속하는 학생 수를 출력
select count(student_id)
from student where height between 180 and 190;

# Q8 학과이름별 키의 최고값, 평균값 출력
select department_name, max(height), round(avg(height)) -- round()에서 자리값을 지정하지 않으면 정수로 표기
from student s left join department d on s.department_id=d.department_id
group by department_name;

# Q9 '다길동' 학생과 같은 학과에 속한 학생의 이름을 출력
select student_name
from student s left join department d on s.department_id=d.department_id
where department_name = '수학';
-- 나의 풀이

select *
from student
where student_name='다길동';
select student_name
from student
where department_id='1';
-- 강사님 1차 풀이

# sub query  1개의 sql 문장 안에 select문이 2개 이상 있는 경우 사용.
select *
from student
where department_id = (
select student_name
from student
where student_name='다길동'
);
######################### 서브쿼리문 확인 ###