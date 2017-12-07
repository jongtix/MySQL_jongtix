use myworld;
# database 리스트 조회
show databases;
# database 환경설정
show variables;
# user 생성
create user user02@localhost identified by 'user02';
create user user02@'%' identified by 'user03';
# 권한부여
grant select, insert, update on myworld.member to user02;
# 권한 회수
revoke select,insert,update on 테이블 from user;

# 테이블 생성
create table member( # 이 칼럼은 비어있면 안됨. 식별자 primary key
	id int not null primary key,
    username varchar(20),
    dept varchar(7),
    birth date,
    email varchar (40)
);

# 테이블 구조 - 데이터가 저장되는 구조를 정의 - create table 
desc member;
# 테이블 구조 변경 - 데이터의 저장 구조를 변경
alter table member add(tel varchar(30) not null);
alter table member modify username varchar(10);
alter table member drop primary key;
# 데이터 정의의 (DDL)
# 테이블 삭제 - 데이터가 저장된 구조를 삭제
drop table member;