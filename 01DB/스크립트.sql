use mydb;
show tables;
select * from department;
insert into department values(1, '수학');
insert into department values(2, '국문학');
insert into department values(3, '정보통신공학');
insert into department values(4, '모바일공학');

select * from student;
insert into student values(1, '가길동', 177, 1);
insert into student values(2, '나길동', 178, 1);
insert into student values(3, '다길동', 179, 1);
insert into student values(4, '라길동', 180, 2);
insert into student values(5, '마길동', 170, 2);
insert into student values(6, '바길동', 172, 3);
insert into student values(7, '사길동', 166, 4);
insert into student values(8, '아길동', 192, 4);

select * from professor;
insert into professor values(1, '가교수', 1);
insert into professor values(2, '나교수', 2);
insert into professor values(3, '다교수', 3);
insert into professor values(4, '빌게이츠', 4);
insert into professor values(5, '스티브잡스', 3);

select * from course;
insert into course values(1, '교양영어', 1, '2016/9/2', '2016/11/30');
insert into course values(2, '데이터베이스 입문', 3, '2016/8/20', '2016/10/30');
insert into course values
(3, '회로이론', 2, '2016/10/20','2016/12/30'),
(4, '공업수학', 4, '2016/11/2', '2017/1/28'),
(5, '객체지향프로그래밍', 3, '2016/11/1', '2017/1/30');

SELECT * from student_course;

insert into student_course values
(1, 1);



