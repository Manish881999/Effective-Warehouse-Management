use warehouse;

# Displaying the required tables
select * from Warehouse;
select * from Clothing;
select * from employee;
select * from goods;

# Find the top 5 goods with highest stock available and show their price
select product_name, sum(stock) as stock, round(avg(price),2)
from Goods 
group by product_name 
order by stock DESC 
limit 5;

# Total amount of money through credit and debit for online orders
select payment_method, sum(amount)
from Payment 
group by payment_method;

# Find the warehouse name if the distribution center which supplies to more than 20 stores.
select distinct(warehouse_name) from Distribution_center
where center_name in
(
select center_name from Supplies_To
group by center_name
having count(*) > 20
);

# Displaying the products that have maximum price higher than the products from  manufacturer "Mia"
select product_name from goods
group by product_name
having max(price) >= all(select price from goods where manufacturer_name = "Mia");

# Find the address of customers who ordered top 5 quantity in online order
select c.customer_name,c.customer_address, o.order_qty 
from Online_order as o INNER JOIN Customer as c on o.customer_ID=c.customer_ID
order by o.order_qty DESC limit 5;

# select product names and codes from goods of a manufacturer named "Mason" with price <= 1000 using "EXISTS"
select product_code, product_name from goods as g
where exists (select * from goods g1 where g.manufacturer_name = "Mason" and g.price <= "1000") ;

# find the distribution center name, address which supplies to the highest recieved payment happened in a store
select s.supplies_to_center_name,d.center_address, r.amount 
from Receives as r JOIN Supplies_To as s 
on r.receives_store_ID=s.supplies_to_store_ID JOIN Distribution_center as d 
on s.supplies_to_center_name=d.center_name order by r.amount desc limit 1;


# find the stock availability of all the clothes with respect to each type
select  c.material_type, SUM(g.stock) as Total_Stock 
from Clothing as c join Goods as g 
on c.clothing_product_code=g.product_code  group by c.material_type;

# find the total cost of stock of items for each category
select f.category as Food_Category, SUM(g.price*g.stock) 
as Total_Cost from Food as f join Goods as g 
on f.food_product_code=g.product_code  group by f.category;