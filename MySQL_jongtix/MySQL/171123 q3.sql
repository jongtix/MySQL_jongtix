## 데이터 정의의 (DDL) - Data Definition Language
# creat, alter, drop

## 데이터 처리어(DML) - Data Manipulation Language
# insert, update, delete, select

## 데이터 제어어(DCL) - Data Control Language
# grant, revoke

use myworld;
desc member;
# 테이블에 데이터 입력하기
insert into member(id, username, dept, birth, email, tel) values(201301, '홍길동', '기술', '1992-10-23', 'hong@naver.com', '010-1111-1234');
# 데이터 조회하기
select id, username, dept, birth, email, tel from member;
# 데이터 수정
update member set tel = '010-1212-5678' # 수정할 값
				where id = 201301; # 조건
# 데이터 삭제
delete from member where id = 201301;
