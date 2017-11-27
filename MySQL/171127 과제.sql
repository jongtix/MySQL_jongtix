# 게시글 테이블
create table board(
	no int primary key auto_increment,
    title varchar(50),
    content longtext,
    writer varchar(30),
    readcount int default 0,
    regdate datetime default current_timestamp,
    favor int default 0
);

desc board;

create table reply(
	no int primary key auto_increment,
    repno int,
    content text,
    writer varchar(30),
    regdate datetime default current_timestamp
);

desc reply;

# 11/27일 과제
# 게시글 10개 입력
# 게시글 1 개 당 댓글 1 ~ 2 개씩 입력
# 게시글의 좋아요 칼럼에 10 ~ 15씩 카운트 입력
# 게시글의 readcount 3 ~ 10씩 카운트 입력
# 출력 : 게시글번호, 제목, 내용, 작성자, 읽은 횟수, 좋아요 횟수, 등록 일시,  댓글 작성자, 댓글 내용, 댓글 등록 일시
insert into board(no, title, content, writer) values(1, '가', '가', '가');
insert into board(title, content, writer) values('나', '나', '나');
insert into board(title, content, writer) values('다', '다', '다');
insert into board(title, content, writer) values('라', '라', '라');
insert into board(title, content, writer) values('마', '마', '마');
insert into board(title, content, writer) values('바', '바', '바');
insert into board(title, content, writer) values('사', '사', '사');
insert into board(title, content, writer) values('아', '아', '아');
insert into board(title, content, writer) values('자', '자', '자');
insert into board(title, content, writer) values('차', '차', '차');
select * from board;
select * from reply;
insert into reply(no, repno, content, writer) values(1, 1, 'a', 'a');
insert into reply(repno, content, writer) values(1, 'aasdf', 'aa');
insert into reply(repno, content, writer) values(2, 'adf', 'asdf');
insert into reply(repno, content, writer) values(2, 'sdf', 'ad');
insert into reply(repno, content, writer) values(3, 'adasf', 'asdf');
insert into reply(repno, content, writer) values(3, 'adff', 'asdf');
insert into reply(repno, content, writer) values(4, 'adsf', 'asdf');
insert into reply(repno, content, writer) values(4, 'adfsdf', 'asdf');
insert into reply(repno, content, writer) values(5, 'asdff', 'asdf');
insert into reply(repno, content, writer) values(5, 'adfsdff', 'as45df');
insert into reply(repno, content, writer) values(6, 'adsfdf', 'asdf');
insert into reply(repno, content, writer) values(6, 'adsf', 'asdf');
insert into reply(repno, content, writer) values(7, 'ad50f', 'as8df');
insert into reply(repno, content, writer) values(8, 'a45df', 'a75sdf');
insert into reply(repno, content, writer) values(8, 'adf', 'asd1f');
insert into reply(repno, content, writer) values(9, 'ad7f', 'asd3f');
insert into reply(repno, content, writer) values(9, 'ad5f', 'asdf');
insert into reply(repno, content, writer) values(10,'ad7f', 'a45sdf');
insert into reply(repno, content, writer) values(10,'ad88f', 'asdf');
    
UPDATE board 
SET 
    favor = 10
WHERE
    no = 1;
UPDATE board 
SET 
    favor = 12
WHERE
    no = 2;
UPDATE board 
SET 
    favor = 15
WHERE
    no = 3;
UPDATE board 
SET 
    favor = 4
WHERE
    no = 4;
UPDATE board 
SET 
    favor = 15
WHERE
    no = 5;
UPDATE board 
SET 
    favor = 11
WHERE
    no = 6;
UPDATE board 
SET 
    favor = 7
WHERE
    no = 7;
UPDATE board 
SET 
    favor = 15
WHERE
    no = 8;
UPDATE board 
SET 
    favor = 11
WHERE
    no = 9;
UPDATE board 
SET 
    favor = 10
WHERE
    no = 10;
    
UPDATE board 
SET 
    readcount = 10
WHERE
    no = 1;
UPDATE board 
SET 
    readcount = 4
WHERE
    no = 2;
UPDATE board 
SET 
    readcount = 2
WHERE
    no = 3;
UPDATE board 
SET 
    readcount = 3
WHERE
    no = 4;
UPDATE board 
SET 
    readcount = 10
WHERE
    no = 5;
UPDATE board 
SET 
    readcount = 8
WHERE
    no = 6;
UPDATE board 
SET 
    readcount = 4
WHERE
    no = 7;
UPDATE board 
SET 
    readcount = 11
WHERE
    no = 8;
UPDATE board 
SET 
    readcount = 4
WHERE
    no = 9;
UPDATE board 
SET 
    readcount = 11
WHERE
    no = 10;
select * from board;

SELECT 
    b.no,
    b.title,
    b.content,
    b.writer,
    b.readcount,
    b.favor,
    b.regdate,
    r.writer,
    r.content,
    r.regdate
FROM
    board b,
    reply r
WHERE
    b.no = r.no;