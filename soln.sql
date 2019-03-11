create database lab_test;
use lab_test;

drop table if exists frequency;
drop table if exists dp;
create table frequency (
number INT,
frequency INT
);

insert into frequency values(0,0);
insert into frequency values(1,0);
insert into frequency values(2,0);
insert into frequency values(3,0);
insert into frequency values(4,0);
insert into frequency values(5,0);
insert into frequency values(6,0);
insert into frequency values(7,0);
insert into frequency values(8,0);
insert into frequency values(9,0);



create table dp (
number INT,
dest INT
);

insert into dp values(0,-1);
insert into dp values(1,-1);
insert into dp values(2,-1);
insert into dp values(3,-1);
insert into dp values(4,-1);
insert into dp values(5,-1);
insert into dp values(6,-1);
insert into dp values(7,-1);
insert into dp values(8,-1);
insert into dp values(9,-1);

#procedure for finding the sum of squared digit
drop procedure if exists get_sq_sum;
delimiter $$
create procedure get_sq_sum(in num int, out ans int)
begin
declare tmp int default 0;
select 0 into ans;
while num > 0 do
select floor(mod(num, 10)) into tmp;
select tmp*tmp into tmp;
select ans+tmp into ans;
#select floor(num/10);
select floor(num/10) into num;
end while;
end;
$$
delimiter ;

#procedure to find where a given num converges to
drop procedure if exists get_dest;
delimiter $$
create procedure get_dest(in num int)
begin
declare tmp int default -2;
declare tos int default 1;
declare original int default 0;
select num into original;
create or replace view v1 as select * from dp;
while tos = 1 do
    
    select dest into tmp from dp where number = num;
    if tmp = -1 then
    update v1 set dest = 0 where number = num;
    elseif tmp != -2 then
    update dp set dest = num where number = original;
    update frequency set frequency = frequency+1 where number = num;
    select 0 into tos;
    end if;
    call get_sq_sum(num, @var);
    select @var into num;

end while;
end;
$$
delimiter ;

#for giving range i.e 1 to n
drop procedure if exists full_range;
delimiter $$
create procedure full_range(in n int)
begin
declare i int default 1;
while i <= n do
call get_dest(i);
select i+1 into i;
end while;
end;
$$
delimiter ;

call full_range(3);
select * from frequency;