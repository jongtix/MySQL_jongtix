# 1. category
# 2. maker
# 3. goods
# 4. stock

insert into category(catid, categoryname) values(1, '식품');
insert into category(catid, categoryname) values(2, '생활용품');

insert into maker(makercd, name) values(5001, '농심');
insert into maker(makercd, name) values(6001, '휘슬러');
insert into maker(makercd, name) values(7001, '부루스타');

insert into goods(id, name, price, category, maker_makercd) values(1001, '새우깡', 1000, 1, 5001);
insert into goods(id, name, price, category, maker_makercd) values(1002, '감자깡', 1000, 1, 5001);
insert into goods(id, name, price, category, maker_makercd) values(1003, '고구마깡', 1000, 1, 5001);
insert into goods(id, name, price, category, maker_makercd) values(1004, '냄비', 5000, 2, 6001);
insert into goods(id, name, price, category, maker_makercd) values(1005, '젓가락', 1000, 2, 6001);
insert into goods(id, name, price, category, maker_makercd) values(1006, '휴대용버너', 20000, 2, 7001);

alter table stock drop primary key;
insert into stock(goods_id, seq, stockday, qty) values(1001, 1, '2017-06-05', 100);
insert into stock(goods_id, seq, stockday, qty) values(1002, 1, '2017-06-06', 50);
insert into stock(goods_id, seq, stockday, qty) values(1003, 1, '2017-06-07', 200);
insert into stock(goods_id, seq, stockday, qty) values(1004, 1, '2017-05-05', 50);
insert into stock(goods_id, seq, stockday, qty) values(1005, 1, '2017-06-09', 300);
insert into stock(goods_id, seq, stockday, qty) values(1006, 1, '2017-06-10', 100);
insert into stock(goods_id, seq, stockday, qty) values(1002, 1, '2017-06-12', 107);
insert into stock(goods_id, seq, stockday, qty) values(1003, 1, '2017-06-13', 108);
insert into stock(goods_id, seq, stockday, qty) values(1005, 1, '2017-08-10', 300);
insert into stock(goods_id, seq, stockday, qty) values(1006, 1, '2017-08-12', 100);
insert into stock(goods_id, seq, stockday, qty) values(1006, 2, '2017-08-12', 100);


select * from stock;

# 상품코드, 상품명, 제조사명, 가격, 전체재고
CREATE VIEW goodsinfo AS # view - 데이터가 읽는 가상의 테이블
						 # 		  자주 조회하는 데이터쿼리를 미리 만들어서 사용하면 편리
    SELECT 
        goods.id '상품코드',
        goods.name '상품명',
        maker.name '제조사명',
        goods.price '가격',
        SUM(stock.qty) '재고'
    FROM
        goods,
        maker,
        stock
    WHERE
        goods.id = stock.goods_id
            AND goods.maker_makercd = maker.makercd
    GROUP BY goods.id;
    
select * from goodsinfo;

CREATE VIEW goodsinfoDetail AS
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
    WHERE
        goods.id = stock.goods_id
            AND goods.maker_makercd = maker.makercd;
            
select * from goodsinfoDetail;

CREATE VIEW empInfo AS
    SELECT 
        emp.empno, emp.ename, dept.deptname
    FROM
        emp,
        dept
    WHERE
        emp.deptno = dept.deptno;
        
select * from empInfo; # 보여주기 어려운 항목들을 제외한 나머지 항목으로 view를 만들어 보여줌