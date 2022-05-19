create table Tabl1
(Col1 number(5));

insert all
into Tabl1 values(1)
into Tabl1 values(1)
into Tabl1 values(2)
into Tabl1 values(2)
into Tabl1 values(3)
select * from dual;
select * from Tabl1;

create table Tabl2
(Col1 number(5),
Col2 number(5));
drop table Tabl2;

insert all
into Tabl2 values(1,2)
into Tabl2 values(1,2)
into Tabl2 values(4,6)
into Tabl2 values(4,6)
into Tabl2 values(9,6)
select * from dual;
select * from Tabl2;
commit;
---inner join
select *
from Tabl1 ta,Tabl2 tb
where ta.col1=tb.col1;
---left join
select *
from Tabl1 ta,Tabl2 tb
where ta.col1=tb.col1(+);
---right join
select *
from Tabl1 ta,Tabl2 tb
where ta.col1(+)=tb.col1;
---cross join
select *
from Tabl1 ta,Tabl2 tb;

select *
from Tabl1 ta 
union 
select * 
from Tabl2 tb;
commit;
select * from tab;
select * from customer_retail;
insert into customer_retail values(1107,'adars','south end','bangalore',9886266201,'adars@gmail.com');
============================================================================================================
create table cust
(Cust_id number(5),
 cust_name varchar(20),
 cust_city varchar(20),
 gender varchar(10),
 dob date,
 mobile number(10));
 
 insert all 
 into cust values(001,'peter','chennai','male','10-jan-1993',9886266201)
 into cust values(002,'yash','bangalore','male','19-apr-1995',9886266202)
 into cust values(003,'arun','mumbai','female','02-jun-1994',9886266203)
 into cust values(004,'khan','hyderabad','female','17-apr-1993',9886266204)
 into cust values(005,'sundar','bangalore','male','24-feb-1994',9886266205)
 into cust values(006,'mukesh','chennai','female','29-dec-1992',9886266206)
 select * from dual;
 
 select * from cust;
 
 create table account
(acc_id number(5),
 acc_type varchar(20),
 acc_ball number(10),
 acc_branch varchar(10),
 cust_id number(5),
 acc_open_date date);
 
 insert all 
 into account values(10,'savings',10000,'jayanagar',003,'22-jan-2002')
 into account values(20,'savings',40000,'mg road',002,'21-sep-2004')
 into account values(30,'current',80000,'hsr',005,'14-nov-2006')
 into account values(40,'savings',30000,'jpnagar',001,'15-may-2004')
 into account values(50,'current',80000,'sarakki',004,'16-apr-2003')
 into account values(60,'current',90000,'hsr',004,'26-apr-2003')
 into account values(70,'savings',1000000,'sangam',006,'16-dec-2006')
 select * from dual;
 select * from account;
 
  create table trans
(acc_id number(5),
 trans_id number(5),
 trans_date date,
 trans_type varchar(20),
 trans_amt number(10));

 insert all 
 into trans values(10,101,'22-jan-2022','online',1500)
 into trans values(20,102,'14-feb-2022','debit card',5500)
 into trans values(50,103,'19-apr-2022','online',2200)
 into trans values(10,104,'16-jan-2022','online',6000)
 into trans values(40,105,'21-feb-2021','debit card',3500)
 into trans values(70,106,'22-jan-2021','debit card',4000)
 into trans values(60,107,'28-apr-2021','online',500)
 into trans values(30,108,'16-sep-2021','online',2500)
 select * from dual;
 select * from trans;

 --query to display customer who have opened savings acc on the birthday
 select c.cust_id, c.cust_name
 from cust c,account a
 where c.cust_id=a.cust_id
 and acc_type='savings'
 and to_char(acc_open_date, 'dd-mm') = to_char(dob, 'dd-mm');
 --query to display customer who have 2 current account in the current month with ballence more than 
 select c.cust_id, c.cust_name
 from cust c,account a
 where c.cust_id=a.cust_id
 and acc_type = 'current'
 and to_char(acc_open_date, 'mm-yy') = to_char(sysdate, 'mm-yy')
 and acc_ball>30000
 group by c.cust_id,c.cust_name
 having count(acc_type)=2;
 --query to display female customer who are from chennai and have ballence less than 5000
 select c.cust_id,c.cust_name
 from cust c,account a
 where c.cust_id=a.cust_id
 and gender='female'
 and cust_city='chennai'
 and acc_ball<5000;
--query to display customer who made atleast 10 transaction in the current year
select c.cust_name, count(trans_id)
from cust c,account a,trans t
where c.cust_id=a.cust_id
and a.acc_id=t.acc_id
and to_char(trans_date, 'yy') = to_char(sysdate, 'yy')
group by cust_name
having count(trans_id)>=1;
--query to display city wise number of male and female customer
select cust_city,
    count(case when gender='male' then 1 end)as M,
    count(case when gender='female' then 1 end)as F
    from cust
    group by cust_city;
--query to display type wise number of customer in the current year
select * from trans;
select * from cust;
select t.trans_type, count(c.cust_id)
from customer c,account a,trans t
where c.cust_id=a.cust_id
and a.acc_id=t.acc_id
and to_char(trans_date, 'yyyy') = to_char(sysdate, 'yyyy')
group by trans_type;
--query to disply customer who are from the same city as that of peter
select cust_id, cust_name
from cust
where cust_city in (select cust_city
                  from cust
                  where cust_name='peter');
commit;
================================================================================
