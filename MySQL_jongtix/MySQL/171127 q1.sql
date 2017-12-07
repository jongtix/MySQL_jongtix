# 데이터베이스 사용
use mydatabase01;
CREATE TABLE emp (
    empno INT(4) PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(20),
    sal INT,
    deptno INT(1) NOT NULL,
    deptname VARCHAR(20)
);

show tables;
desc emp;

# 데이터 입력
drop table emp;
insert into emp(empno, ename, sal, deptnodeptdeptemp, deptname) values(2001, '홍길동', 15000, 1, '기획');
insert into emp(ename, sal, deptno, deptname) values('임꺽정', 20000, 1, '기획');
insert into emp(ename, sal, deptno, deptname) values('일지매', 18000, 2, '영업');
insert into emp(ename, sal, deptno, deptname) values('김길동', 23000, 2, '영업');
insert into emp(ename, sal, deptno, deptname) values('임거정', 20000, 3, '재무');
insert into emp(ename, sal, deptno, deptname) values('이순신', 25000, 3, '재무');
SELECT 
    empno, ename, sal, deptno, deptname
FROM
    emp;

# dept 테이블 생성
# 속성 :     deptno, deptname, location
# 타입 :     int(1), varchar(20), varchar(50)
# 제약조건 : key & 자동증가

drop table dept;
CREATE TABLE dept (
    deptno INT(1) PRIMARY KEY AUTO_INCREMENT,
    deptname VARCHAR(20),
    location VARCHAR(50)
);

insert into dept(deptname, location) values('기획', '서울시');
insert into dept(deptname, location) values('영업', '인천시');
insert into dept(deptname, location) values('재무', '수원시');

SELECT 
    deptno, deptname, location
FROM
    dept;
    
# 칼럼 삭제 - alter table 테이블명 drop 칼럼명;
alter table emp drop deptname;
desc emp;
SELECT 
    empno, ename, sal, deptno
FROM
    emp;
    
SELECT 
    emp.empno,
    emp.ename,
    emp.sal,
    emp.deptno,
    dept.deptname,
    dept.location
FROM
    emp,
    dept
WHERE
    emp.deptno = dept.deptno;
    
SELECT 
    empno, ename, sal, emp.deptno, deptname, location
FROM
    emp,
    dept
WHERE
    emp.deptno = dept.deptno;
    
SELECT 
    empno '사번',
    ename '사원명',
    sal '급여',
    emp.deptno '부서코드',
    deptname '부서명',
    location '위치'
FROM
    emp,
    dept
WHERE
    emp.deptno = dept.deptno;

SELECT 
    deptno, deptname, location
FROM
    dept;

# 테이블 삭제 전 데이터 삭제
# DDL문에서의 데이터 삭제
# table 구조는 그대로 있고, 데이터만 삭제
# DML문의 delete와 비슷함
# 		-> 차이 : delete는 rollback을 할 수 있음
#				  truncate는 rollback 자체가 없음
truncate table dept;
SELECT 
    *
FROM
    dept;
truncate table emp;
SELECT 
    *
FROM
    emp;

# DDL - create, alter, drop, truncate
# DML - insert, update, delete, select
# DCL - grant, revoke

drop table emp;
drop table dept;

# foreign key
# 두 테이블이 연관되는 속성을 가진 경우,
# 주테이블(Parent)의 속성값이
# 참조하는 테이블의 속성으로 부여되는 경우
# 부모 - 자식의 관계라 하고,
# 부모테이블의 주key(primary key)가
# 자식의 주key(primary key)로 부여되는 경우 : 식별관계
# 자식의 일반 속성으로 부여되는 경우 : 비식별관계

desc mydatabase01;
drop table dept;
drop table emp;
CREATE TABLE dept (
    deptno INT(1) PRIMARY KEY AUTO_INCREMENT,
    deptname VARCHAR(20),
    location VARCHAR(20)
);
CREATE TABLE emp (
    empno INT(4) PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(20),
    sal INT,
    deptno INT(1),
    CONSTRAINT fk_deptno FOREIGN KEY (deptno)
        REFERENCES dept (deptno)
        ON DELETE CASCADE
);
show tables;
desc emp;

drop table emp;
CREATE TABLE emp (
    empno INT(4) PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(20),
    sal INT,
    deptno INT(1)
);

# 테이블 생성 후 외래키 제약조건 부여하기
alter table emp add foreign key (deptno) references dept (deptno) on delete cascade;

# dept와 emp테이블의 부모 - 자식 관계 설정 후 데이터 입력하기
insert into dept(deptname, location) values('기획', '서울시');
insert into dept(deptname, location) values('영업', '인천시');
insert into dept(deptname, location) values('재무', '수원시');

SELECT 
    *
FROM
    dept;

insert into emp(empno, ename, sal, deptno) values(2001, '홍길동', 15000, 1);
insert into emp(ename, sal, deptno) values('임꺽정', 20000, 1);
insert into emp(ename, sal, deptno) values('일지매', 18000, 2);
insert into emp(ename, sal, deptno) values('김길동', 23000, 2);
insert into emp(ename, sal, deptno) values('임거정', 20000, 3);
# 부모테이블의 도메인은 (1, 2, 3)인데,
# 자식테이블에서 도메인 외의 속성값을 입력하려는 경우 오류발생 - 정합성오류
# 자식테이블에는 외래키인 경우 : null 값이 올 수 있음. (이 칼럼을 not null로 하면 안됨.)
insert into emp(ename, sal, deptno) values('이순신', 25000, null);

UPDATE emp 
SET 
    deptno = 3
WHERE
    empno = 2006;
SELECT 
    *
FROM
    emp;
SELECT 
    *
FROM
    dept;
DELETE FROM dept 
WHERE
    deptno = 3;

# 외래키 삭제
alter table emp drop foreign key emp_ibfk_1;

# 부모테이블의 속성값을 삭제 후
# 자식테이블의 속성값을 null로 하기 위한 외래키 생성 옵션을 이용하여 외래키를 재생성
alter table emp add foreign key (deptno) references dept(deptno) on delete set null;
DELETE FROM dept 
WHERE
    deptno = 1;

insert into emp(empno, ename, sal, deptno) values(4, '임거정', 20000, null);
insert into dept(deptno, deptname, location) values(3, '재무', '수원시');
UPDATE emp 
SET 
    deptno = 3
WHERE
    empno = 4;
DELETE FROM dept 
WHERE
    deptno = 3;

UPDATE dept 
SET 
    deptno = 5
WHERE
    deptno = 3;

CREATE TABLE sample31 (
    a INTEGER NOT NULL,
    b INTEGER NOT NULL UNIQUE,
    c VARCHAR(30)
);

insert into sample31(a, b, c) values(1, 1, '값1');
insert into sample31(a, b, c) values(1, 1, '값2');CREATE TABLE sample123 (
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30),
    PRIMARY KEY (no , sub_no)
);
desc sample123;
insert into sample123(no, sub_no, name) values(1, 1, '값1');
insert into sample123(no, sub_no, name) values(1, 2, '값2');
insert into sample123(no, sub_no, name) values(1, 1, '값3');

drop table sample123;

CREATE TABLE sample123 (
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30),
    CONSTRAINT pkey_sam123 PRIMARY KEY (no , sub_no)
);
desc sample123;

CREATE TABLE sample124 (
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30)
);
desc sample124;
# primary key 제약조건 추가하기
# alter table 테이블명 add constraint 키명 primary key(칼럼);
alter table sample124 add constraint pkey_sam124 primary key(no, sub_no);
# primary key 제약조건 삭제
# alter table 테이블명 drop primary key;
alter table sample124 drop primary key;

# 상품테이블, 제조사테이블, 재고
# 상품테이블 : goods
# 속성 :     goodsno, goodsname,   price, prodno
# 타입 :     int,     varchar(20), int,   int
# 제약조건 : key(자동증가)                fk_goods_1
CREATE TABLE goods (
    goodsno INT PRIMARY KEY AUTO_INCREMENT,
    goodsname VARCHAR(20),
    price INT,
    prodno INT,
    CONSTRAINT fk_goods_1 FOREIGN KEY (prodno)
        REFERENCES maker (prodno)
        ON DELETE CASCADE
);

# 제조사테이블 : maker
# 속성 :     prodno, prodname
# 타입 :     int,    varchar(30)
# 제약조건 : key(자동증가)
CREATE TABLE maker (
    prodno INT PRIMARY KEY AUTO_INCREMENT,
    prodname VARCHAR(30)
);

# 제조사테이블 : stock
# 속성 :     no,  			goodsno, qty
# 타입 :     int, 			int      int
# 제약조건 : key(자동증가), fk_stock_1(외래키)
CREATE TABLE stock (
    no INT PRIMARY KEY AUTO_INCREMENT,
    goodsno INT,
    qty INT,
    CONSTRAINT fk_stock_1 FOREIGN KEY (goodsno)
        REFERENCES goods (goodsno)
        ON DELETE CASCADE
);

desc maker;
desc goods;
desc stock;

# relationship으로 연결된 테이블들 간의 데이터 입력은
# 참조되는 부모테이블의 데이터가 먼저 입력된 후
# 자식테이블의 데이터가 입력되어야함.
# 부모테이블이 도메인 범위 내의 값만 허용하기 때문

select * from maker;
insert into maker(prodname) values('삼성');
insert into maker(prodname) values('LG');
insert into maker(prodname) values('대우');

select * from goods;
insert into goods(goodsno, goodsname, price, prodno) values(1001, '갤럭시S8', 1000000, 1);
insert into goods(goodsname, price, prodno) values('V30', 990000, 2);
insert into goods(goodsname, price, prodno) values('세탁기1', 800000, 3);

select * from stock;
insert into stock(no, goodsno, qty) values(1, 1001, 100);
insert into stock(goodsno, qty) values(1002, 100);
insert into stock(goodsno, qty) values(1003, 200);

# select 상품코드 상품명 제조사명 재고수량
# 조회순서 where -> select -> order by
SELECT 
    goods.goodsno '상품코드',
    goods.goodsname '상품명',
    maker.prodname '제조사명',
    stock.qty '재고수량'
FROM
    goods,
    maker,
    stock
WHERE
    goods.goodsno = stock.goodsno
        AND goods.prodno = maker.prodno
ORDER BY prodname desc; # 정렬기준(default 오름차순)

insert into stock(goodsno, qty) values(1001, 300);
insert into stock(goodsno, qty) values(1002, 50);
insert into stock(goodsno, qty) values(1003, 100);
insert into stock(goodsno, qty) values(1001, 100);
insert into stock(goodsno, qty) values(1002, 150);
insert into stock(goodsno, qty) values(1003, 100);

select * from stock;

# 집계함수 - mysql에서 제공해주는 내장함수 사용
# sum(), avg(), count(), max(), min()
# 이런 집계함수는 반드시 group by절과 함께 사용.
# stock테이블에서 상품코드별 재고 수량 파악
SELECT 
    goodsno, SUM(qty)
FROM
    stock
GROUP BY goodsno; # 집계 함수는 group by와 함께 사용

# 상품테이블, 제조사테이블 - 변화가 거의 없는 테이블 (마스터테이블)
# 재고테이블은 변화가 자주 일어난 테이블 (transactional 테이블)

# 조회순서 where -> group by -> select -> order by
SELECT 
    goods.goodsno '상품코드',
    MAX(goods.goodsname) '상품명',
    MIN(maker.prodname) '제조사명',
    SUM(stock.qty) '재고수량'
FROM
    goods,
    maker,
    stock
WHERE
    goods.goodsno = stock.goodsno
        AND goods.prodno = maker.prodno
GROUP BY stock.goodsno
ORDER BY goods.goodsno;

# group by 기준 속성으로 집계한 데이터의 조건으로
# 수량이 400개 이상인 상품의 코드, 상품명, 제조사명, 수량
# 조회순서 where -> group by -> having -> select -> order by
SELECT 
    goods.goodsno '상품코드',
    MAX(goods.goodsname) '상품명',
    MIN(maker.prodname) '제조사명',
    SUM(stock.qty) '재고수량'
FROM
    goods,
    maker,
    stock
WHERE
    goods.goodsno = stock.goodsno
        AND goods.prodno = maker.prodno
GROUP BY stock.goodsno
having sum(qty) >= 400 # group by 기준 다음에 조건으로 having절이 옴
ORDER BY goods.goodsno;

# stock테이블에서 재고를 반출
# 1001 : -100, 1002 : -100, 1003 : -50
# update말고 insert로 재고를 등록하세요
insert into stock(goodsno, qty) values(1001, -100);
insert into stock(goodsno, qty) values(1002, -100);
insert into stock(goodsno, qty) values(1003, -50);
select * from stock;

# 집계함수를 사용하여
# 코드별 총재고수량을 출력하세요
# 단, 재고량이 400개 이상인 것만 출력
SELECT 
    goodsno, SUM(qty)
FROM
    stock
GROUP BY goodsno
HAVING SUM(qty) >= 400;

# 재고테이블
CREATE TABLE totStock (
    no INT NOT NULL,
    sub_no INT NOT NULL,
    goodsno INT,
    qty INT,
    PRIMARY KEY (no , sub_no)
);

desc totStock;

alter table totStock add constraint foreign key (goodsno) references goods (goodsno);

insert into totStock(no, sub_no, goodsno, qty) values(1, 1, 1001, 50);
insert into totStock(no, sub_no, goodsno, qty) values(1, 2, 1001, 60);
insert into totStock(no, sub_no, goodsno, qty) values(1, 3, 1001, 70);
insert into totStock(no, sub_no, goodsno, qty) values(2, 1, 1002, 50);
insert into totStock(no, sub_no, goodsno, qty) values(2, 2, 1002, 70);
insert into totStock(no, sub_no, goodsno, qty) values(2, 3, 1002, 90);
insert into totStock(no, sub_no, goodsno, qty) values(3, 1, 1003, 10);
insert into totStock(no, sub_no, goodsno, qty) values(3, 2, 1003, 20);
insert into totStock(no, sub_no, goodsno, qty) values(3, 3, 1003, 30);
insert into totStock(no, sub_no, goodsno, qty) values(4, 1, 1001, 30);

select * from totStock;

select goodsno, sum(qty) from totstock group by goodsno;
# sql에서의 제어문
# 속성 값이 몇 개로 한정된 경우는
# 테이블을 따로 만들어서 foreign관계를 만드는 것보다
# case문을 사용하여 출력하는게 퍼포먼스적으로 효과적
# 예) 남/여, 혈액형, 학점
SELECT 
    goodsno,
    CASE sub_no
        WHEN 1 THEN '창고'
        WHEN 2 THEN '매장'
        WHEN 3 THEN '행사장'
    END AS place,
    qty
FROM
    totstock;
    
CREATE TABLE stockplace (
    sub_no INT,
    placename VARCHAR(20)
);
insert into stockplace values(1, '창고');
insert into stockplace values(2, '매장');
insert into stockplace values(3, '행사장');

SELECT 
    *
FROM
    stockplace;
    
SELECT 
    goodsno,
	sub_no,
    CASE sub_no
        WHEN 1 THEN '창고'
        WHEN 2 THEN '매장'
        WHEN 3 THEN '행사장'
    END AS place,
    qty
FROM
    totstock;

insert into totStock(no, sub_no, goodsno, qty) values(1, 1, 1001, 50);
insert into totStock(no, sub_no, goodsno, qty) values(1, 2, 1001, 60);
insert into totStock(no, sub_no, goodsno, qty) values(1, 3, 1001, 70);
insert into totStock(no, sub_no, goodsno, qty) values(2, 1, 1002, 50);
insert into totStock(no, sub_no, goodsno, qty) values(2, 2, 1002, 70);
insert into totStock(no, sub_no, goodsno, qty) values(2, 3, 1002, 90);
insert into totStock(no, sub_no, goodsno, qty) values(3, 1, 1003, 10);
insert into totStock(no, sub_no, goodsno, qty) values(3, 2, 1003, 20);
insert into totStock(no, sub_no, goodsno, qty) values(3, 3, 1003, 30);
insert into totStock(no, sub_no, goodsno, qty) values(4, 1, 1001, 30);

# 상품코드, 상품명, 창고/매장/행사장별 총 재고수량을 출력 (goods, totstock)
# 출력값 : 상품코드, 상품명, sub_no, sub_no명, 총재고수량
SELECT 
    g.goodsno,
    g.goodsname,
    sub_no,
    CASE sub_no
        WHEN 1 THEN '창고'
        WHEN 2 THEN '매장'
        WHEN 3 THEN '행사장'
    END AS place,
    SUM(qty)
FROM
    goods g,
    totstock t # 테이블도 alias(별칭)을 붙일 수 있음
WHERE
    g.goodsno = t.goodsno
GROUP BY g.goodsno , t.sub_no;

# 상품별 총재고수량
# 출력값 : goodsno, goodsname, sum(qty)
SELECT 
    g.goodsno,
    g.goodsname,
    SUM(qty)
FROM
    goods g,
    totstock t
WHERE
    g.goodsno = t.goodsno
GROUP BY g.goodsno;

SELECT 
    a.goodsno, a.goodsname, SUM(a.sumqty)
FROM
    (SELECT 
        g.goodsno goodsno,
            g.goodsname goodsname,
            sub_no sub_no,
            CASE sub_no
                WHEN 1 THEN '창고'
                WHEN 2 THEN '매장'
                WHEN 3 THEN '행사장'
            END AS place,
            SUM(qty) sumqty
    FROM
        goods g, totstock t
    WHERE
        g.goodsno = t.goodsno
    GROUP BY g.goodsno , t.sub_no) a
GROUP BY goodsno;

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