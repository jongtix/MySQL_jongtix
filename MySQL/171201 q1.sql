SELECT 
    *
FROM
    mydatabase001.goods;

# delimiter : 구분자를 바꿔줌.
delimiter ?
create procedure GetGoodsList()
Begin
select * from goods;
End ?

delimiter ;

call GetGoodsList();

delimiter //
create procedure GetGoodsInfo(in inId int(4))
begin
select * from goods where id = inId;
end //

delimiter ;
call GetGoodsInfo(1001);

delimiter //
create procedure CountGoods(out cnt int)
begin
select count(*) into cnt from goods;
end //

delimiter ;
call CountGoods(@total); # 바인딩 변수 @ : 프로그램 종료시까지 값을 저장
select @total;

select * from goods;

delimiter //
create procedure CountPerMaker(in maker int, out cnt int)
begin
select count(*) into cnt from goods where maker_makercd = maker;
end//

delimiter ;
call CountPerMaker(5001, @cnt);
select @cnt;

# 함수
# create function 함수명(파라미터)
# return 타입
# begin ~~ returns 값; end

delimiter //
create function getName(goodsNo int)
returns varchar(10)
begin
return(
select name from goods where id = goodsNo
);
end//
delimiter ;

select getName(1001);

delimiter //
create function getPrice(goodsNo int)
returns int
begin
return(
select price from goods where id = goodsNo
);
end//
delimiter ;

select getPrice(1001);

select * from stock;
# 상품코드 입력 받아서 상품명과 재고수량을 출력하는 함수
# getStockInfo(int goodsNo)
select getName(1001), sum(qty) from stock where goods_id = 1001;

delimiter //
create function getStockInfo(goodsNo int)
returns varchar(30)
begin
return(
select concat(concat(getName(goodsNo),', 재고 : '), sum(qty)) from stock where goods_id = goodsNo
);
end//
delimiter ;
SELECT GETSTOCKINFO(1004);
drop function getStockInfo;
select concat(getName(id), getStockInfo(id)) from goods;

# 트리거
select * from stock where goods_id = 1006;

create table totStock as
select goods_id, sum(qty)
from stock 
group by goods_id;

alter table totStock add constraint primary key(goods_id);

select * from totStock;

# 트리거 생성
delimiter //
create trigger stock_in_trg
after insert # insert, update, delete 중 insert
on stock
for each row # 한 행이 입력된 후
begin
update totStock set qty = qty + new.qty where id = new.goods_id;
end//
delimiter ;

insert into stock(goods_id, seq, stockday, qty) values(1001, 2, now(), 100);
select * from totStock;

create table stock_history(
	
);