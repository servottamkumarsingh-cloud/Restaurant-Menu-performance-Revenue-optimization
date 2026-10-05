create table menu_items (
menu_item_id int primary key, 
item_name varchar(50),
category varchar(50),
price numeric(10,5)
)

select * from menu_items;
DROP table menu_items

COPY  menu_items
FROM 'C:\Restaurant Orders project\menu_items.csv'
DELIMITER ','
CSV HEADER ;


create table order_details(
order_details_id int primary key,
order_id int,
order_date varchar(50),
order_time varchar(50),
item_id varchar(50)
)

select * from order_details
DROP table order_details

COPY  order_details
FROM 'C:\Restaurant Orders project\order_details.csv'
DELIMITER ','
CSV HEADER ;


update order_details
set item_id=0
where item_id='NULL'

ALTER TABLE order_details
ALTER COLUMN item_id TYPE int
USING item_id::integer



create view Total_item_price as 
select 
   t1.menu_item_id,
   t1.price,
   count(t2.item_id) as total_unique_item_id,
   (t1.price * count(t2.item_id)) as Total_price
from menu_items t1
left join order_details t2 on t1.menu_item_id= t2.item_id
group by t1.menu_item_id, t1.price
order by t1.menu_item_id asc


select * from Total_item_price
drop VIEW Total_item_price

select  sum(Total_price) from Total_item_price