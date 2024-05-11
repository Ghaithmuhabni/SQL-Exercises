create database Sample

use Sample 
go

create schema sales
go


create schema production
go
--Start create tables and connect them together --
create table sales.customers(
	customer_id int identity(1,1) primary key ,
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	phone varchar(15) unique,
	email varchar(50) unique,
	street varchar(40) not null,
	city varchar(25) not null,
	state varchar(25),
	zip_code varchar(5)
);


create table sales.orders(
	order_id int identity(1,1) primary key,
	customer_id int not null,
	order_status tinyint,
	order_date date not null,
	required_date date not null,
	shipped_date date,
	store_id int not null , 
	staff_id int not null 

	constraint customer_orders_fk foreign key (customer_id)
	references sales.customers(customer_id),

	constraint staff_orders_fk foreign key (staff_id)
	references sales.staffs(staff_id),

	constraint store_orders_fk foreign key (store_id)
	references sales.stores(store_id)
);

create table sales.staffs(
	staff_id int identity(1,1) primary key,
	f_name varchar(15) not null,
	l_name varchar(15) not null,
	email varchar(50) unique not null,
	phone varchar(12) unique,
	active varchar(30),
	store_id int,
	manager_id int 

	constraint store_staffs_fk foreign key (store_id)
	references sales.stores(store_id),
);

alter table sales.staffs
add constraint manager_staffs_fk foreign key (manager_id)
references sales.staffs(staff_id)
	

create table sales.stores(
	store_id int identity(1,1) primary key,
	store_name varchar(30),
	phone varchar(12) unique not null,
	email varchar(50) unique,
	street varchar(50),
	city varchar(20),
	state varchar(20),
	zip_code varchar(5)
);

create table sales.order_items(
	order_id int,
	item_id int,
	product_id int,
	quantity int,
	list_price decimal,
	discount decimal,

	primary key(order_id,item_id),

	constraint order_orders_fk foreign key (order_id)
	references sales.orders(order_id),

	constraint product_orders_fk foreign key (product_id)
	references production.products(product_id)
);

create table production.categories(
	category_id int identity(1,1) primary key,
	category_name varchar(40)
);

create table production.products(
	product_id int identity(1,1) primary key,
	product_name varchar(40),
	brand_id int,
	category_id int,
	model_year int,
	list_price decimal,

	constraint brand_products_fk foreign key (brand_id)
	references production.brands(brand_id),

	constraint category_products_fk foreign key (category_id)
	references production.categories(category_id)
);

create table production.stocks(
	store_id int,
	product_id int,
	quantity int

	primary key (store_id,product_id),

	constraint store_stocks_fk foreign key (store_id)
	references sales.stores(store_id),

	constraint products_stocks_fk foreign key (product_id)
	references production.products(product_id)
);

create table production.brands(
	brand_id int identity(1,1) primary key,
	brand_name varchar(50)
);

--End create tables and connect them together --

--Start add values to tables--
INSERT INTO sales.customers (f_name, l_name, phone, email, street, city, state, zip_code)
VALUES
('Alice', 'Johnson', '1112223333', 'alice.johnson@example.com', '123 Oak St', 'New York', 'New York', '12345'),
('Bob', 'Smith', '2223334444', 'bob.smith@example.com', '456 Maple St', 'Los Angeles', 'California', '54321'),
('Charlie', 'Brown', '3334445555', 'charlie.brown@example.com', '789 Elm St', 'Chicago', 'Illinois', '67890'),
('Diana', 'Garcia', '4445556666', 'diana.garcia@example.com', '987 Pine St', 'Houston', 'Texas', '23456'),
('Ethan', 'Martinez', '5556667777', 'ethan.martinez@example.com', '654 Cedar St', 'Phoenix', 'Arizona', '87654'),
('Fiona', 'Lopez', '6667778888', 'fiona.lopez@example.com', '321 Birch St', 'Philadelphia', 'Pennsylvania', '34567'),
('George', 'Hernandez', '7778889999', 'george.hernandez@example.com', '890 Walnut St', 'San Antonio', 'Texas', '78901'),
('Hannah', 'Young', '8889990000', 'hannah.young@example.com', '234 Pine St', 'San Diego', 'California', '21098'),
('Ian', 'Gonzalez', '9990001111', 'ian.gonzalez@example.com', '567 Oak St', 'Dallas', 'Texas', '87654'),
('Julia', 'Rodriguez', '1234567890', 'julia.rodriguez@example.com', '890 Elm St', 'San Jose', 'California', '10987'),
('Kevin', 'Lee', '2345678901', 'kevin.lee@example.com', '123 Maple St', 'Austin', 'Texas', '45678'),
('Lily', 'Clark', '3456789012', 'lily.clark@example.com', '456 Cedar St', 'Jacksonville', 'Florida', '54321'),
('Mason', 'Walker', '4567890123', 'mason.walker@example.com', '789 Pine St', 'Indianapolis', 'Indiana', '67890'),
('Nora', 'Hall', '567-890-234', 'nora.hall@example.com', '987 Birch St', 'San Francisco', 'California', '23456'),
('Owen', 'Harris', '678-901-2345', 'owen.harris@example.com', '654 Walnut St', 'Columbus', 'Ohio', '87654'),
('Penelope', 'Moore', '789-012-3456', 'penelope.moore@example.com', '321 Cedar St', 'Fort Worth', 'Texas', '34567'),
('Quinn', 'Allen', '890-123-4567', 'quinn.allen@example.com', '890 Oak St', 'Charlotte', 'North Carolina', '78901'),
('Rachel', 'King', '901-234-5678', 'rachel.king@example.com', '234 Pine St', 'Seattle', 'Washington', '21098'),
('Samuel', 'Lewis', '012-345-6789', 'samuel.lewis@example.com', '567 Elm St', 'Denver', 'Colorado', '45678'),
('Taylor', 'Taylor', '123456780', 'taylor.taylor@example.com', '890 Maple St', 'Portland', 'Oregon', '54321');

---------------------------------------------------------------------------------------------------------------
INSERT INTO sales.stores (store_name, phone, email, street, city, state, zip_code)
VALUES
('Store A', '111-222-3333', 'storeA@example.com', '123 Oak St', 'New York', 'New York', '12345'),
('Store B', '222-333-4444', 'storeB@example.com', '456 Maple St', 'Los Angeles', 'California', '54321'),
('Store C', '333-444-5555', 'storeC@example.com', '789 Elm St', 'Chicago', 'Illinois', '67890'),
('Store D', '444-555-6666', 'storeD@example.com', '987 Pine St', 'Houston', 'Texas', '23456'),
('Store E', '555-666-7777', 'storeE@example.com', '654 Cedar St', 'Phoenix', 'Arizona', '87654'),
('Store F', '666-777-8888', 'storeF@example.com', '321 Birch St', 'Philadelphia', 'Pennsylvania', '34567'),
('Store G', '777-888-9999', 'storeG@example.com', '890 Walnut St', 'San Antonio', 'Texas', '78901'),
('Store H', '888-999-0000', 'storeH@example.com', '234 Pine St', 'San Diego', 'California', '21098'),
('Store I', '999-000-1111', 'storeI@example.com', '567 Oak St', 'Dallas', 'Texas', '87654'),
('Store J', '123-456-7890', 'storeJ@example.com', '890 Elm St', 'San Jose', 'California', '10987'),
('Store K', '234-567-8901', 'storeK@example.com', '123 Maple St', 'Austin', 'Texas', '45678'),
('Store L', '345-678-9012', 'storeL@example.com', '456 Cedar St', 'Jacksonville', 'Florida', '54321'),
('Store M', '456-789-0123', 'storeM@example.com', '789 Pine St', 'Indianapolis', 'Indiana', '67890'),
('Store N', '567-890-1234', 'storeN@example.com', '987 Birch St', 'San Francisco', 'California', '23456'),
('Store O', '678-901-2345', 'storeO@example.com', '654 Walnut St', 'Columbus', 'Ohio', '87654'),
('Store P', '789-012-3456', 'storeP@example.com', '321 Cedar St', 'Fort Worth', 'Texas', '34567'),
('Store Q', '890-123-4567', 'storeQ@example.com', '890 Oak St', 'Charlotte', 'North Carolina', '78901'),
('Store R', '901-234-5678', 'storeR@example.com', '234 Pine St', 'Seattle', 'Washington', '21098'),
('Store S', '012-345-6789', 'storeS@example.com', '567 Elm St', 'Denver', 'Colorado', '45678'),
('Store T', '123-455-7890', 'storeT@example.com', '890 Maple St', 'Portland', 'Oregon', '54321');

---------------------------------------------------------------------------------------------------------------
INSERT INTO sales.staffs (f_name, l_name, email, phone, active, store_id, manager_id)
VALUES
('John', 'Doe', 'john.doe@example.com', '111-222-3333', 'Active', 1, NULL),
('Jane', 'Smith', 'jane.smith@example.com', '222-333-4444', 'Active', 2, NULL),
('Michael', 'Johnson', 'michael.johnson@example.com', '333-444-5555', 'Active', 3, NULL),
('Emily', 'Brown', 'emily.brown@example.com', '444-555-6666', 'Active', 1, NULL),
('David', 'Martinez', 'david.martinez@example.com', '555-666-7777', 'Active', 2, NULL),
('Sarah', 'Garcia', 'sarah.garcia@example.com', '666-777-8888', 'Active', 3, NULL),
('Daniel', 'Lopez', 'daniel.lopez@example.com', '777-888-9999', 'Active', 1, NULL),
('Olivia', 'Gonzalez', 'olivia.gonzalez@example.com', '888-999-0000', 'Active', 2, NULL),
('James', 'Rodriguez', 'james.rodriguez@example.com', '999-000-1111', 'Active', 3, NULL),
('Sophia', 'Hernandez', 'sophia.hernandez@example.com', '123-456-7890', 'Active', 1, NULL),
('William', 'Walker', 'william.walker@example.com', '234-567-8901', 'Active', 2, NULL),
('Amelia', 'Young', 'amelia.young@example.com', '345-678-9012', 'Active', 3, NULL),
('Benjamin', 'White', 'benjamin.white@example.com', '456-789-0123', 'Active', 1, NULL),
('Emma', 'King', 'emma.king@example.com', '567-890-1234', 'Active', 2, NULL),
('Liam', 'Clark', 'liam.clark@example.com', '678-901-2345', 'Active', 3, NULL),
('Ava', 'Lewis', 'ava.lewis@example.com', '789-012-3456', 'Active', 1, NULL),
('Lucas', 'Martin', 'lucas.martin@example.com', '890-123-4567', 'Active', 2, NULL),
('Mia', 'Harris', 'mia.harris@example.com', '901-234-5678', 'Active', 3, NULL),
('Ella', 'Moore', 'ella.moore@example.com', '012-345-6789', 'Active', 1, NULL),
('Noah', 'Taylor', 'noah.taylor@example.com', '123-455-7890', 'Active', 2, NULL);

---------------------------------------------------------------------------------------------------------------
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
(1, 1, '2024-04-01', '2024-04-05', '2024-04-03', 1, 4),
(2, 2, '2024-04-02', '2024-04-06', '2024-04-04', 2, 4),
(3, 2, '2024-04-03', '2024-04-07', '2024-04-05', 3, 9),
(4, 3, '2024-04-04', '2024-04-08', '2024-04-06', 1, 4),
(5, 2, '2024-04-05', '2024-04-09', '2024-04-07', 2, 5),
(6, 4, '2024-04-06', '2024-04-10', '2024-04-08', 3, 6),
(7, 1, '2024-04-07', '2024-04-11', '2024-04-09', 1, 4),
(8, 4, '2024-04-08', '2024-04-12', '2024-04-10', 2, 5),
(9, 3, '2024-04-09', '2024-04-13', '2024-04-11', 3, 8),
(1, 2, '2024-04-10', '2024-04-14', '2024-04-12', 1, 4),
(1, 1, '2024-04-11', '2024-04-15', '2024-04-13', 2, 5),
(2, 1, '2024-04-12', '2024-04-16', '2024-04-14', 3, 6),
(3, 2, '2024-04-13', '2024-04-17', '2024-04-15', 1, 9),
(4, 4, '2024-04-14', '2024-04-18', '2024-04-16', 2, 7),
(5, 1, '2024-04-15', '2024-04-19', '2024-04-17', 3, 5),
(6, 1, '2024-04-16', '2024-04-20', '2024-04-18', 1, 4),
(7, 2, '2024-04-17', '2024-04-21', '2024-04-19', 2, 5),
(8, 4, '2024-04-18', '2024-04-22', '2024-04-20', 3, 6),
(9, 4, '2024-04-19', '2024-04-23', '2024-04-21', 1, 5),
(1, 3, '2024-04-20', '2024-04-24', '2024-04-22', 2, 4);

---------------------------------------------------------------------------------------------------------------
INSERT INTO production.categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Home Appliances'),
('Books'),
('Furniture'),
('Toys'),
('Sporting Goods'),
('Jewelry'),
('Automotive'),
('Beauty Products'),
('Kitchenware'),
('Tools'),
('Healthcare'),
('Pet Supplies'),
('Musical Instruments'),
('Office Supplies'),
('Food and Beverages'),
('Outdoor Gear'),
('Baby Products'),
('Art and Crafts');

---------------------------------------------------------------------------------------------------------------
INSERT INTO production.brands (brand_name)
VALUES
('Sony'),
('Nike'),
('Samsung'),
('Adidas'),
('Apple'),
('LG'),
('Puma'),
('Panasonic'),
('Microsoft'),
('Philips'),
('Toyota'),
('Honda'),
('Ford'),
('BMW'),
('Audi'),
('Mercedes-Benz'),
('Ferrari'),
('Loreal'),
('Coca-Cola'),
('Nestle');

---------------------------------------------------------------------------------------------------------------
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES
('Smartphone X', 3, 1, 2023, 799.99),
('Running Shoes A', 2, 2, NULL, 99.99),
('Smart TV B', 6, 3, 2024, 1499.99),
('Laptop C', 5, 1, 2024, 1299.99),
('Refrigerator D', 9, 3, 2023, 899.99),
('Sneakers B', 2, 2, NULL, 79.99),
('Tablet E', 3, 1, 2024, 599.99),
('Washing Machine F', 6, 3, 2023, 699.99),
('T-shirt A', 4, 2, NULL, 19.99),
('Microwave Oven G', 9, 3, 2024, 249.99),
('Dress Shoes C', 2, 2, NULL, 129.99),
('Headphones H', 1, 1, 2023, 299.99),
('Vacuum Cleaner I', 9, 3, 2024, 179.99),
('Soccer Ball', 7, 6, NULL, 24.99),
('Digital Camera', 3, 1, 2023, 499.99),
('Desk J', 5, 5, NULL, 199.99),
('Drill K', 11, 11, 2024, 79.99),
('Dumbbells', 10, 7, NULL, 49.99),
('Face Cream', 18, 10, NULL, 29.99),
('Coffee Maker L', 9, 11, 2023, 89.99);

---------------------------------------------------------------------------------------------------------------
INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES
(4, 1, 1, 2, 799.99, 0),
(5, 2, 5, 1, 899.99, 0),
(6, 1, 3, 1, 1499.99, 0),
(7, 2, 7, 2, 599.99, 0),
(8, 1, 10, 1, 129.99, 0.1),
(9, 2, 15, 1, 24.99, 0),
(10, 1, 12, 1, 299.99, 0),
(11, 2, 17, 1, 199.99, 0),
(12, 1, 8, 1, 179.99, 0),
(13, 2, 20, 3, 29.99, 0),
(14, 1, 14, 1, 499.99, 0),
(15, 2, 16, 2, 199.99, 0),
(16, 1, 2, 1, 99.99, 0),
(17, 2, 9, 1, 249.99, 0),
(18, 1, 4, 2, 1299.99, 0),
(19, 2, 11, 1, 79.99, 0),
(20, 1, 6, 3, 79.99, 0),
(21, 2, 19, 1, 49.99, 0),
(22, 1, 13, 1, 89.99, 0),
(23, 2, 18, 1, 29.99, 0);

select *from production.products
---------------------------------------------------------------------------------------------------------------
INSERT INTO production.stocks (store_id, product_id, quantity)
VALUES
(1, 1, 50),
(1, 2, 100),
(2, 3, 30),
(2, 4, 20),
(3, 5, 80),
(3, 6, 70),
(4, 7, 60),
(4, 8, 40),
(5, 9, 90),
(5, 10, 110),
(6, 11, 25),
(6, 12, 35),
(7, 13, 75),
(7, 14, 45),
(8, 15, 55),
(8, 16, 65),
(9, 17, 85),
(9, 18, 95),
(10, 19, 105),
(10, 20, 115);
--End add values to tables--


------------------Join tables (inner Join & natural join)--------------------
--natural join inner join benziyor sadece foregin key yazmaya gerek yok 
--MSsql dosen't support natural join 

--inner join 
select f_name , l_name , email , order_id , order_date ,store_id
from sales.customers c , sales.orders o 
where c.customer_id = o.customer_id;

-- 2. yol inner join
select f_name , l_name , email , order_id , order_date ,store_id
from sales.customers c join sales.orders o 
on c.customer_id = o.customer_id;

-- inner join
select f_name , l_name , email , order_id , order_status , order_date
from sales.orders c , sales.staffs o 
where c.staff_id = o.staff_id;

---------------join more than 2 tables-------------

-- ornek 1 1.yol  
select f_name , l_name , order_id , order_date , store_name ,s.street , s.city
from sales.customers c ,sales.orders o , sales.stores s
where c.customer_id = o.customer_id and o.store_id = s.store_id;

-- ornek 1 2.yol  
select f_name , l_name , order_id , order_date , store_name ,s.street , s.city
from sales.customers c join sales.orders o on c.customer_id = o.customer_id 
join sales.stores s on o.store_id = s.store_id;

--ornek 2 1.yol
select o.order_id , order_date , p.product_id , product_name , p.list_price
from sales.orders o , sales.order_items oi , production.products p
where o.order_id = oi.order_id and oi.product_id=p.product_id;

--ornek 2 2.yol
select o.order_id , order_date , p.product_id , product_name , p.list_price
from sales.orders o join sales.order_items oi on o.order_id = oi.order_id  
join  production.products p on oi.product_id=p.product_id;

--ornek 3 1.yol
select f_name+' '+l_name as "Customer Name" , brand_name 
from sales.customers c, sales.orders o, sales.order_items oi,
production.products p, production.brands b
where c.customer_id = o.customer_id and o.order_id = oi.order_id 
and oi.product_id = p.product_id and p.brand_id = b.brand_id

--ornek 3 2.yol
select f_name+' '+l_name as "Customer Name" , brand_name 
from sales.customers c join sales.orders o on c.customer_id = o.customer_id 
join sales.order_items oi on o.order_id = oi.order_id 
join production.products p on oi.product_id = p.product_id
join production.brands b on p.brand_id = b.brand_id

--------------------Aggregate Functions------------------------
------------[max , min , sum , count , avg ]------------
-- (as is optional)

select max(list_price) as "Highest Price",
min(list_price)as"Lowest Price", 
avg(list_price) average, 
sum(list_price)"Total Price", 
count(*) as"NO of Products"
from production.products;

select count(*) ,max(order_date) as "last order" , min(order_date) as "first order" from sales.orders

select max(list_price) as "Highest Price" ,
min(list_price)as"Lowest Price" , 
avg(list_price) average ,
sum(list_price)"Total Price",
count(*) as"NO of Products"
from production.products
where category_id=3

select count(*) "Num of order",
max(order_date) as "last order",
min(order_date) as "first order"
from sales.orders 
where customer_id = 45

-----------------------Grouping Data (Group by Clause & having)--------------------------
--for each category , list category_id , max price , lowest price , avergae price;
 select category_id , count(*)"NO of Products" ,
 max(list_price) "Highest Price" ,
 min(list_price) "Lowest Price" ,
 avg(list_price) "Total prices"
 from production.products
 group by category_id;


--for each brand , display a list of brand name , no of products for that brand along
--with the hightest and lowest price in the brands
select brand_name , count(*) as "NO of Products",
max(list_price) as "Hightest Price",
min(list_price) as "Lowest Price" 
from production.brands b join production.products p 
on b.brand_id = p.brand_id 
group by b.brand_name;

select customer_id , count(*) "No of Orders",
min(order_date) "First Order",
max(order_date) "Last Order"
from sales.orders  
group by customer_id;

select substring(product_name , 1,5) from production.products  

------------------join with group by & order by -----------------
select store_name , count(*) as "No of Orders" 
from sales.stores s join sales.orders o
on s.store_id = o.store_id 
group by store_name 
having store_name='Store A'
order by count(*) ;

select brand_name , count(*) as "No of Orders" 
from production.brands b join production.products p  
on b.brand_id = p.brand_id join sales.order_items oi
on oi.product_id = p.product_id
group by brand_name 
having count(*) >=3
order by count(*) ;

--------------------Select Top Records------------------------
--with ties statment if last (in this example 3. element) selected elements have same value will showing it
select top 3 with ties product_name ,min(list_price)
from production.products
group by product_name
order by min(list_price);

 select *from production.products 

-------------------Nested queries (Sub queries) all & any --------------
-- collegeDB kullaniyorum
use collegeDB 
go 

select stdno , mark from register
where mark = (select max(mark)from register);

select stdno , mark from register 
where mark >(select avg(mark) from register);

select students.stdno , firstname+' '+lastname as "Full name" 
from students join register 
on students.stdno = register.stdno
where courseid in (select courseid from students join register 
on students.stdno = register.stdno where firstname='Khaled')

select students.stdno , firstname+' '+lastname as "Full name" , mark
from students join register 
on students.stdno = register.stdno
where mark >all (select mark from register join students 
on students.stdno = register.stdno 
where Depart='CS' )

select students.stdno , firstname+' '+lastname as "Full name" , mark
from students join register 
on students.stdno = register.stdno
where mark <any (select mark from register join students 
on students.stdno = register.stdno 
where Depart='CS' )

-----------------SQL Server Views--------------------









