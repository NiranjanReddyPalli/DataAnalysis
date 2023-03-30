SELECT * FROM db1.teachers;

select T1.*, T2.t_NAME as Principle  from 
teachers T1, Teachers T2 
where T1.Principle_ID = T2.t_ID ;

create table Employees 
(
ID Int,
Emp_Name varchar(255),
Age int,
Manager_ID INT 
) ;

select * from Employees;

Insert into Employees values
(1, 'SHEK', 30, 4),
(2, 'RAVI', 30, 4),
(3, 'ARAVIND', 50, 4),
(4, 'KOWSHIK', 35, NULL),
(5, 'PRAVEEN', 29, 4),
(6, 'SWAMY', 30, 1),
(7, 'SASI', 33, 1),
(8, 'BABAJAN', 48, 1),
(9, 'VAASU', 28, 2),
(10, 'SHAFI', 45, 2)
;

select E1.*, E2.Emp_name as Manager from employees as E1, Employees as E2
where E1.Manager_ID = E2.ID ;



SELECT * FROM db1.students;



create table students 
(
ID int,
Name varchar(255),
Address varchar(500)
) ;

insert into students values
(1, 'A', 'AP'),
(2, 'B', 'AP'),
(3, 'C', 'TN'),
(4, 'D', 'KA'),
(5, 'E', 'TS'),
(6, 'F', 'MP'),
(7, 'G', 'TN'),
(8, 'H', 'KA'),
(9, 'I', 'TS'),
(10, 'J', 'AP')
;

CREATE TABLE MARKS
(
ID INT,
MARKS INT
) ;

SELECT * FROM MARKS ;

INSERT INTO MARKS VALUES 
(1, 80),
(2, 70), 
(4, 55), 
(5, 67), 
(6, 34), 
(8, 88), 
(11, 32), 
(12, 90), 
(13, 78), 
(14, 65)
;

SELECT * FROM STUDENTS S CROSS JOIN MARKS M 
-- ON S.ID = M.ID ;


SELECT * FROM STUDENTS;
SELECT * FROM MARKS ;

SELECT S.ID,S.NAME, M.MARKS FROM 
STUDENTS AS S INNER JOIN MARKS AS M
ON S.ID = M.ID 
;

SELECT S.*, M.* FROM students AS S 
LEFT JOIN MARKS AS M
ON S.ID = M.ID 
INNER JOIN SCHOOLS S1
ON S.ID = S1.SCHOOL_ID
;

SELECT S.*, M.* FROM STUDENTS AS S
RIGHT JOIN MARKS M
ON S.ID = M.ID ;

SELECT * FROM STUDENTS AS S , MARKS AS M ;

select c.customerNumber, c.customerName, c.salesRepEmployeeNumber as Emp_number, e.firstName as Emp_first_name, e.lastName as Emp_last_name, e.jobTitle, 
o.orderNumber, o.orderDate, o.status, od.productCode, od.quantityOrdered, od.priceEach, od.quantityOrdered * od.priceEach as Total_product_price
from customers as c
left join employees as e
on c.salesRepEmployeeNumber = e.employeeNumber 
left join orders o
on c.customerNumber = o.customerNumber
inner join orderdetails as od
on o.orderNumber = od.orderNumber
;

select * , sum(creditlimit) over (partition by country ) as high 
from customers ;

select *, ROW_NUMBER() over (partition by country order by creditLimit) rn,  
rank() over (partition by country order by creditlimit ) rank_,  
DENSE_RANK() over ( partition by country order by creditlimit ) denserank_n
from customers ;

select *,  DENSE_RANK() over ( order by creditlimit ) rank_n
from customers ;


select * from orders order by customernumber;

select *, lead(ordernumber,2,"NA" ) over (partition by customernumber ORDER BY orderdate) as lag_val
from orders ;


create view pnr_vw as
select * from customers
where country = "USA" ;

select * from pnr_vw ;

create index idx_pnr on customers(city, country) ; 


SELECT * FROM classicmodels.customers;

delimiter @@

create procedure pnr_proc()
begin
select * from customers 
where city = 'Las Vegas' ;
end @@
delimiter ;

call pnr_proc ;

delimiter @@

create procedure pnr_proc1(pnr_country varchar(50))
begin 
select * from customers 
where country = pnr_country  ;
end @@
delimiter ;

call pnr_proc1("France") ;

select * from customers 
where country = 'Poland' ;


with pnr_cte as
(
select * from customers 
where creditLimit > 100000
)
select * from  pnr_cte 
where city = 'Madrid'
;


select * from  
(
select * from customers 
where creditLimit > 100000
) as pnr_cte 
where city = 'Madrid'
;

SELECT * FROM classicmodels.customers;


select Upper(customername) as customers, character_length(customername) as len from customers ;

select length(customername) from customers ;

select concat( contactFirstname, contactlastname ) as contact_name,  
concat( trim(contactFirstname), trim(contactlastname )) as contact_name_last from customers ;



select Right(customername, 10) from customers ;

select 
*,
right(customername, 5) as right_char,
left(customername, 5) as left_char,
length(customername) as len
from customers ;

select * from customers
where lower(country) = 'hong kong' ;


select reverse(country) as rpt from customers ;


select format(256465452465.542674275254, 2) ;


SELECT * FROM classicmodels.customers;



select instr("Niranjan Abhi", 'Abhi' ) ;

select locate('.', phone) as pd from customers ;

select position('Abhi' in 'Niranjan Abhi') ;

select 
locate('a', "Niranjan Abhi",1) as first, 
locate('a', "Niranjan Abhi",(locate('a', "Niranjan Abhi") + 1)) as second, 
locate('a', "Niranjan Abhi", locate('a', "Niranjan Abhi",(locate('a', "Niranjan Abhi") + 1)) + 1 ) as Third
 ;
 
 
 select replace("Python Tutorial", "Python", 'SQL');
 
 select substring("Python Tutorial", 1, 7) ;
 
 select substring("Python Tutorial",1, locate(' ', "Python Tutorial") - 1) ;
 
 select locate(' ', "Python Tutorial") - 1 ;
 
 
 select count(name) as avg from customers ;
 
 select count(*) from customers ;
 
 select count(*), count(state) state_count, count(distinct state) unq_state_count from customers ;
 
 select count(*) from customers
 where state is not null ;
 
 select floor(27.844342332), ceil(27.8444342332), round(27.844342332) ;
 select truncate(rand(), 2) ;
 
 select abs(-23) ;
 
 select mod(10, 3) ;
 
select rand() ;

select sqrt(16) ;

select pow(2, 4) ;

select least(1,2,3,4,5,6,7,7) ;

select greatest(1,2,3,4,5,6,7,7);

select current_date(), current_time(), current_timestamp() ;



select sysdate() ;

select getdate() ;

select second(now()) ;

select date(now()), year(now()), month(now()), dayofmonth(now()) ;

SELECT week(now()) ;

select weekday(now()) ;

select dayofweek(now()) ;

select dayofyear(now()) ;

select quarter(now()) ;

select monthname(orderdate) from orders ;

select dayname(orderdate) from orders ;

select last_day(now()); 

select extract(week from now()) ;
select now() ;
-- select str_to_date(orderdate, %y-%m-%d)

select date_format(now(), '%d-%M');

select date_add(now(), interval -10 day) ;

select adddate(now(), -50) ;

select datediff('2023-12-20', '2023-12-10') ;

select from_days(738894) ; 

select to_days(now()) ;


select cast(creditlimit as FLOAT) from customers ; 

select month(cast(orderdate as date)) from orders ;

select coalesce(null, null,'a',33,null, 222,33) ;

select isnull(null);

select ifnull(null, 'a') ;

select nullif('a','a') ;

select if(a<b, 'a is greater', 'a is not greater' ) ;

SELECT * FROM classicmodels.customers;



select customernumber, customername, city, country from classicmodels.customers
where customernumber in ( select customerNumber from orders) ;



select c.customernumber, c.customername, c.city, c.country, o.ordernumber
from customers c
left join orders o
on c.customerNumber = o.customerNumber 
where o.orderNumber is null;

select distinct c.customernumber, c.customername, c.city, c.country
from classicmodels.customers as c
inner join orders o 
on c.customerNumber <> o.customerNumber 
;

select  c.country, count(o.orderNumber) as cnt
from classicmodels.customers as c
left join orders o 
on c.customerNumber = o.customerNumber 
GROUP BY c.country
;

select c.customernumber, count(o.ordernumber) as cnt
from customers as c
inner join orders o
on c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
ORDER BY cnt desc
limit 5
;


/*
from
where
group by
having
select
order by
limit
*/

select creditlimit, if(creditlimit > 100000, "More than 1 lakh", "Less than 1 lakh") from customers ;

select version();

select user() ;

select system_user(), session_user() ;

select e.employeenumber, count(distinct o.ordernumber) cnt
from customers c
inner join orders o
on c.customernumber = o. customernumber
inner join employees e
on c.salesrepemployeenumber = e.employeenumber
GROUP BY e.employeeNumber
ORDER BY cnt desc
limit 1
;


select year(orderdate), month(orderdate), count(ordernumber) from orders
group by year(orderdate), month(orderdate) ;

SELECT distinct year(orderdate)*100 + month(orderdate) as ind from orders ;


SELECT * FROM classicmodels.orderdetails;

select c.customernumber, c.customerName, c.city, c.country, c.postalCode, od.ordernumber, od.total_value
from 
(
select ordernumber, sum(quantityordered*priceeach) as Total_value
from orderdetails
group by orderNumber 
) od
left join orders o 
on od.ordernumber = o.orderNumber
left join customers as c
on o.customerNumber = c.customerNumber
order by total_value desc
limit 5
;
-- 

select *, DENse_RANK() over (order by cnt desc) as ranking 
from 
(
select  c.salesRepEmployeeNumber emp_number, concat(e.firstname, e.lastname) Emp_name, count(o.orderNumber) as cnt
from orders o 
left join customers c
on o.customerNumber = c.customerNumber
left join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber
group by c.salesRepEmployeeNumber, concat(e.firstname, e.lastname)
) a
;

select  p.productLine, count(distinct od.ordernumber) cnt
from orderdetails od 
left join products p
on od.productCode = p.productCode
group by p.productLine
;

select 
(year(orderdate)*100 + month(orderdate)) as year_month_ind, count(ordernumber) cnt
from orders
where year(orderdate) = 2004
group by (year(orderdate)*100 + month(orderdate))
;

select avg(shipping_days), max(shipping_days), min(shipping_days)
from
(
select ordernumber, datediff(shippeddate, orderdate) as shipping_days
from orders
) a
;

select o.*, c.* 
from orders o
left join customers c
on o.customerNumber = c.customerNumber
where lower(o.status) = "cancelled"
;

