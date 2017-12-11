# 데이터 조회시 행수 제한

select * from stock;

# 조회된 데이터 중에서 상위 5개만 출력
# select * from 테이블명 limit n [offset 시작행] - 1부터 n까지 (offset이 있으면 시작행 + 1부터)
select * from stock limit 5;
select * from stock limit 5 offset 3;
select * from stock limit 5 offset 0;

SELECT 
    goods.id '상품코드',
    goods.name '상품명',
    maker.name '제조사명',
    goods.price '가격',
    stock.qty '재고'
FROM
    goods,
    maker,
    stock
LIMIT 7;

# 산술연산 +, -, *, /
# select 식1, 식2, .... from 테이블명

create table sam34(
	no int primary key auto_increment,
    price int,
    qty int
);

insert into sam34(price, qty) values(100, 230);
insert into sam34(price, qty) values(230, 24);
insert into sam34(price, qty) values(1980, 1);

# select된 결과값을 연산할 수 있음
SELECT 
    *, price * qty '총 판매 가격'
FROM
    sam34;
    
CREATE TABLE sam34Tot AS SELECT *, price * qty FROM
    sam34;

SELECT 
    *
FROM
    sam34Tot
WHERE
    price * qty >= 2000;
    
    
create table sam35(
	amount double
);


insert into sam35 values(596.60);
insert into sam35 values(2138.40);
insert into sam35 values(1080.00);

select * from sam35;
select amount, round(amount) from sam35; # 반올림함수 - 소수 1 자리에서 반올림 
select amount, round(amount, 1) from sam35; #			소수 2자리에서 반올림
select amount, round(amount, -2) from sam35; #			정수 두자리에서 반올림하여 100자리 맞춤

# 문자열 결합
# concat substirng trim, charecter_length
select 'ABC'||'1234';

create table sam36(
	no int primary key auto_increment,
    price int,
    qty int,
    unit varchar(10)
);

insert into sam36(price, qty, unit) values(100, 10, '개');
insert into sam36(price, qty, unit) values(230, 24, '캔');
insert into sam36(price, qty, unit) values(1980, 1, '장');

select concat(qty, unit) from sam36;
# substring(문자열, 시작, 갯수)
select substring('201711281553', 1, 4);
select substring('201711281553', 5, 2);
select substring('201711281553', 7, 2);
select substring('201711281553', 9, 2);
select substring('201711281553', 11, 2);

# trim() 함수
select trim('ABC  ');
select trim('    ABC');
select trim('A B C');

# select character_length; - ASCII, UNICODE 상관없이 무조건 문자의 갯수를 반환
select character_length('한국인');
select character_length('ABC');
# length - ASCII 기준으로 되어있어서 문자의 길이가 달라짐
select length('한국인');
select length('abc');

# 날짜 연산
# current_timestamp, current_date interval
select current_timestamp(); # 날짜 & 시간
select current_date(); # 날짜
select current_date() + interval + 1 day;
select datediff('2017-11-28', '2017-11-29'); # 기간 조회

# group 함수, sum(), avg(), max(), min(), count()
create table sam51(
	no int primary key auto_increment,
    name varchar(10),
    qty int
);
insert into sam51(name, qty) values('A', 1);
insert into sam51(name, qty) values('A', 2);
insert into sam51(name, qty) values('B', 10);
insert into sam51(name, qty) values('C', 3);
insert into sam51(name, qty) values(null, null);

select * from sam51;

select count(name) from sam51; # null값은 집계에서 제외
select count(qty) from sam51;
select count(*) from sam51; # * - 전체항목을 의미 -> 집계함수 사용 시 (*)를 사용하면 

# sub쿼리 - 쿼리의 결과가 다른 쿼리의 일부가 되는 쿼리
create table sam13(
	no int primary key auto_increment,
    a int
);

insert into sam13(a) values(100);
insert into sam13(a) values(900);
insert into sam13(a) values(80);

select * from sam13;
select min(a) from sam13; # 전체에서 최솟값 하나 출력 - 스칼라값
select max(a) from sam13; # 전체에서 최댓값 하나 출력
select max(a), min(a) from sam13;

# sub쿼리 - 스칼라 값이 sub쿼리로 사용
select
(select count(*) from sam51) as sq1,
(select count(*) from sam13) as sq2;

# from절에 사용된 sub쿼리
select * from (select * from sam13) sq;

# 상관sub쿼리
# exists (select문)
create table sam55(
	no int primary key auto_increment,
    a varchar(10)
);
insert into sam55(a) values(null);
select * from sam55;
create table sam56(
	no int
);
insert into sam56 values(3);
insert into sam56 values(5);
select * from sam56;

UPDATE sam55 
SET 
    a = '있음'
WHERE
    EXISTS( SELECT 
            *
        FROM
            sam56
        WHERE
            sam55.no = sam56.no);
            
UPDATE sam55 
SET 
    a = '없음'
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            sam56
        WHERE
            sam55.no = sam56.no);

# in(값1, 값2, 값3, ...)
select * from sam55 where no in(3, 5);
select * from sam55 where no in(select no from sam56); # sub쿼리의 결과
select * from sam55 where no not in(select no from sam56);

# union, union all
# 두 개 이상의 쿼리 결과를 합쳐서 출력하는 쿼리문
create table sam71(
	a int
);
insert into sam71(a) values(1);
insert into sam71(a) values(2);
insert into sam71(a) values(3);

create table sam72(
	a int
);

insert into sam72(a) values(2);
insert into sam72(a) values(10);
insert into sam72(a) values(11);

# union 쿼리문에서 출력되는 항목이 중복되면 union 뒤의 중복된 항목은 제외
select * from sam71
union
select * from sam72;
# union all 모두 출력
select * from sam71
union all
select * from sam72;

select * from sam71 order by a;
select * from sam72 order by a;

# order by 절이 있으면 마지막 쿼리문에만 사용한다
select * from sam71
union
select * from sam72 order by a;

select * from sam71 aa
union all
select * from sam72 bb
union all
select * from sam71 cc
union all
select * from sam72 dd order by a;