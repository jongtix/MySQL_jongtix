show tables;

# 데이터베이스의 sql 명령문 세가지
# DDL - 정의어
# 		- creat, alter, drop
# DML - 처리어
# 		- insert, update, delete, select
# DCL - 제어어
# 		- grant, revoke

# 테이블 생성
# 테이블명 : sample41
# 속성 : Field, Type, Null, Key, Default, Extra <- 메타데이터
desc emp;

create table sample41(
	no int, # 정수형 타입(기본11자리)
    a varchar(30), # 문자형 타입
    b date # 날짜형 타입
);

desc sample41;

# 1, 'ABC', '2014-10-25' 넣기
insert into sample41(no, a, b) values(1, 'ABC', '2014-10-25');

# 조회 select
select no, a, b from sample41;

insert into sample41(a, no) values('XYZ', 2);

select no, a, b from sample41;

insert into sample41(no, a, b) values(null, null, null);

select no, a, b from sample41;

# SQL도 연산이 가능
# Null값과 다른 값의 연산결과는 Null
drop table sample41;

# 테이블을 not null 제약조건(constraint)를 부여하여 재작성
create table sample41(
	no int not null, # 정수형 타입(기본11자리), option null값 입력 방지 제약
    a varchar(30), # 문자형 타입
    b date # 날짜형 타입
);

insert into sample41(no, a, b) values(1, 'ABC', '2014-10-25');
insert into sample41(a, no) values('XYZ', 2);
insert into sample41(no, a, b) values(null, null, null);

select no, a, b from sample41;

desc sample41;

drop table sample41;
create table sample411(
	no int not null, # 정수형 타입(기본11자리), option null값 입력 방지 제약
    a varchar(30), # 문자형 타입
    b int default 0 # 기본값을 0으로 처리
    # default옵션 - 테이블 칼럼에 데이터 입력시, 값이 null로 들어오면 값을 대체
);

desc sample411;

insert into sample411(no, a) values(1, 1);

select * from sample411;

create table sample412(
	no int primary key auto_increment, # 옵션 - 자동증가
    # auto_increment - 
    a varchar(10),
    b date
);

desc sample412;

insert into sample412(a, b) values('ABC', '2017-11-24');
insert into sample412(a, b) values('DEF', '2017-11-24');
insert into sample412(no, a, b) values(4, 'AAA', '2017-11-25');

select * from sample412;

# 데이터 삭제
# delete from 테이블명 where 조건;
# delete from sample412; # 전체 삭제
delete from sample412 where no > 5; # 부분 삭제
delete from sample412 where a = 'ABC';

# update 테이블명 set 대상칼럼 = 값 where 조건;
update sample412 set a = 'ABCD' where no = 4;

# 테이블 생성
# dept
# deptno, dname, location
# int(4), varchar(30), varchar(20)
# key & 자동증가
# 1001부터 시작
create table dept(
	deptno int(4) primary key auto_increment ,
    dname varchar(30),
    location varchar(20)
);

insert into dept(dname, location, deptno) values('기획', '서울', 1001);
insert into dept(dname, location) values('영업', '인천');
insert into dept(dname, location) values('재무', '수원');
insert into dept(dname, location) values('연구', '평창');

select * from dept;

delete from dept;

drop table dept;

# board
# no, title, content, writer, regdate
# int, varchar(30), varchar(500), varchar(50), datetime
create table board(
	no int primary key auto_increment, # primary key는 not null, unique
	title varchar(30),
    content varchar(500),
    writer varchar(50),
    regdate datetime default current_timestamp # 현재 시간이 기본 옵션으로 설정
);

desc board;
insert into board(title, content, writer) values('게시글1', '게시글 등록입니다.', 'user01');
insert into board(title, content, writer) values('게시글2', '게시글2 등록입니다.', 'user02');
insert into board(title, content, writer) values('게시글3', '게시글3 등록입니다.', 'user03');
insert into board(title, content, writer) values('게시글4', '게시글4 등록입니다.', 'user04');
insert into board(title, content, writer) values('게시글5', '게시글5 등록입니다.', 'user05');
insert into board(title, content, writer) values('게시글6', '게시글6 등록입니다.', 'user06');
update board set title = '게시글60',regdate = current_timestamp() where no = 4;

select * from board;

# reply
# no, repno, content, writer, regdate
# int, int, varchar(50), varchar(20), datetime
# key & 자동증가
create table reply(
	no int primary key auto_increment,
    repno int,
    content varchar(50),
    writer varchar(20),
    regdate datetime default current_timestamp
);

insert into reply(repno, content, writer) values(1, '1번 글에 대한 댓글 하나', 'user03');
insert into reply(repno, content, writer) values(1, '1번 글에 대한 댓글 둘', 'user02');
insert into reply(repno, content, writer) values(2, '2번 글에 대한 댓글 하나', 'user05');
insert into reply(repno, content, writer) values(2, '2번 글에 대한 댓글 둘', 'user04');
insert into reply(repno, content, writer) values(3, '3번 글에 대한 댓글 하나', 'user03');

select * from reply;

# favor
# no, boardno, count
# int, int, int
# key       default 0
create table favor(
	no int primary key auto_increment,
    boardno int,
    count int default 0
);
desc favor;
insert into favor(boardno) values(1);
insert into favor(boardno) values(2);
insert into favor(boardno) values(3);
insert into favor(boardno) values(4);
insert into favor(boardno) values(5);
drop table favor;
select * from favor;

update favor set count = count + 1 where boardno = 2;

desc board;
# 테이블 수정 alter
alter table board add readcount int;
alter table board modify readcount int default 0;
select * from board;
# readcount1~3까지 3, readcount4~6 5로 수정
update board set readcount = 3 where no >= 1 and no <= 3;
update board set readcount = 5 where no >= 4 and no <= 6; # 조건절에 칼럼값을 제한하여 처리

# board 테이블, reply 테이블, favor 테이블
select board.no, title, board.content, board.writer,
	   readcount, reply.content,
       count
			from board, reply, favor
				where board.no = reply.repno and board.no = favor.boardno; # join (equal join)
                
# board의 글번호, 내용, 작성자, 좋아요 갯수를 출력
select board.no as '글번호', content as '내용', writer as '작성자', count as '좋아요' from board, favor where board.no = favor.boardno;

# board의 글번호, 댓글번호, 좋아요 출력
select board.no as '글번호', reply.no as '댓글번호', favor.count as '좋아요'
	from board, reply, favor
		where board.no = reply.repno and board.no = favor.boardno;
        
# 테이블 데이터 오름차순/내림차순 정렬
select no, title, content
	from board
		order by no; # 오름차순 정렬
        
select no, title, content
	from board
		order by no desc; # 내림차순 정렬
        
# 정렬 칼럼을 두 개 이상 사용 가능
select board.no, title, favor.count # 실행순서 2
	from board, favor
		where board.no = favor.boardno # 실행순서 1
			order by board.no, favor.count desc; # 실행순서 3