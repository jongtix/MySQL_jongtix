create table emp( # 이 칼럼은 비어있면 안됨. 식별자 primary key
	id int not null primary key,
    username varchar(20),
    deptno int,
    hiredate date,
    sal int
);

desc emp;

insert into emp(id, username, deptno, hiredate, sal) values(201701, '홍길동', 1, '2012-01-10', 150);
insert into emp(id, username, deptno, hiredate, sal) values(201702, '임꺽정', 1, '2012-01-11', 200);
insert into emp(id, username, deptno, hiredate, sal) values(201703, '일지매', 3, '2012-01-12', 150);
insert into emp(id, username, deptno, hiredate, sal) values(201704, '이순신', 2, '2012-01-13', 300);
insert into emp(id, username, deptno, hiredate, sal) values(201705, '유관순', 3, '2012-01-14', 100);
insert into emp(id, username, deptno, hiredate, sal) values(201706, '김길동', 1, '2012-01-15', 200);
insert into emp(id, username, deptno, hiredate, sal) values(201707, '이지매', 2, '2012-01-16', 300);
select id, username, deptno, hiredate, sal from emp;
# 데이터 조회시 모든 칼럼을 보고 싶을 때 *
select * from emp;