use master;
create database sales;

use sales;
go 

create schema sales_schema;

create schema production; 

create table sales_schema.customers(
	customer_id int,
	f_name varchar(20) not null,
	l_name varchar(20) not null, 
	email varchar(50) not null, 
	phone varchar(15) unique, --unique not null olabilir ve primery key ayni is yarar
	state varchar(15),
	city varchar(15) not null, 
	street varchar(30) not null, 
	zip_code varchar(5),
	
	constraint customers_pk primary key (customer_id) -- bu sekilde table constrant level adilandirir
);   

create table categories(
	category_id int primary key ,-- primary key benzersizlik icin ve not null olmasi gerekir ve bu sekilde column constrant level adilandirir 
	category_name varchar(20)
);

create table brands(
	brand_id int ,
	brand_name varchar (20),

	constraint brands_pk primary key (brand_id)
);

create table staff (
	staff_id int primary key , 
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	salary numeric(7,2) check (salary between 300 and 15000) not null , --numeric 25000.50 Gibi ,check constrant : sart sagliyorsa kontrol ediyor 
	hire_date date,
	store_id int , --burda yeni eleman ekledik store table baglamak icin 
	constraint store_staff_fk foreign key (store_id)  -- burda foreign key nasil yapiyoruz ana yol 
	references store (store_id)
);

create table store (
	store_id int primary key , 
	store_name varchar(30),
	city varchar(10) not null,
	phone varchar(10)
);

create table orders(
	order_id int primary key,
	order_date date, 
	order_status varchar(10),
	order_type varchar(10),
	customer_no int references sales_schema.customers(customer_id) -- burda foreign key kisa yol 
);

create table products (
	product_id int not null,
	product_name varchar(20),
	model int,
	brand_id int 
);

------------------- alter table statments-----------------------
alter table store
add street varchar(20);

alter table store 
add zip_code int,
fax varchar(10);

alter table store 
alter column store_name varchar(50);

alter table store 
alter column city varchar(25) null;

alter table store 
drop column fax

alter table store 
add constraint store_name_uq unique (store_name);

alter table products 
add constraint products_pk primary key (product_id);

alter table products
add constraint brands_products_fk foreign key(brand_id)
references brands(brand_id)

alter table store 
drop constraint store_name_uq;

alter table products 
drop constraint brands_products_fk

exec sp_rename 'store','stores'; -- burda tablo ismi degistiriyorus 
exec sp_rename 'staff','workers';

exec sp_rename 'categories.category_name' ,'cnaem' ,'column'
---------------------------------------------------------

------------new database for example --------------------
create database BikeStore 

use BikeStore 
go 

create table customers(
	customer_id int primary key,
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	phone varchar(15) not null,
	email varchar(50) not null,
	city varchar(15) check (city in ('mersin','istanbul','adana')),
	zip_code varchar(5)
);

alter table customers 
drop column street 

create table orders(
	order_id int identity(1,1),
	customer_id int,
	order_status tinyint not null,
	order_date date not null,
	required_date date not null,
	shipped_date date not null, 
	store_id int not null, 
	staff_id int not null,

	constraint orders_pk primary key(order_id),
	constraint customer_orders_fk foreign key(customer_id)
	references customers (customer_id)
);

create table stores(
	store_id int identity (1,1) primary key,
	store_name varchar(50) not null, 
	phone varchar(15),
	email varchar(30),
	street varchar(20),
	city varchar(10),
	state varchar(15),
	zip_code varchar(5)
);

alter table orders
add constraint store_orders_fk foreign key (store_id)
references stores (store_id);



create table staffs (
	staff_id int identity(1,1) primary key,
	f_name varchar(20) not null, 
	l_name varchar(20) not null,
	email varchar(50) not null unique, 
	phone varchar(15),
	active tinyint not null,
	store_id int not null, 
	manager_id int
);

alter table staffs
add constraint store_staff_fk foreign key(store_id)
references stores (store_id)

CREATE TABLE stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-----------------------------------------------------

------------insert into statement--------------------

insert into categories (category_id , category_name)
values(1,'weels');

INSERT INTO customers (customer_id, f_name, l_name, phone, email, city, zip_code)
VALUES
(1, 'John', 'Doe', '1234567890', 'john.doe@example.com', 'istanbul', '12345'),
(2, 'Jane', 'Smith', '0987654321', 'jane.smith@example.com', 'adana', '54321'),
(3, 'Michael', 'Johnson', '5551234567', 'michael.johnson@example.com', 'mersin', '67890'),
(4, 'Emily', 'Brown', '9876543210', 'emily.brown@example.com', 'istanbul', '23456'),
(5, 'David', 'Martinez', '4445556666', 'david.martinez@example.com', 'adana', '87654'),
(6, 'Sarah', 'Garcia', '7778889999', 'sarah.garcia@example.com', 'mersin', '34567'),
(7, 'Daniel', 'Lopez', '3332221111', 'daniel.lopez@example.com', 'istanbul', '78901'),
(8, 'Olivia', 'Gonzalez', '2223334444', 'olivia.gonzalez@example.com', 'adana', '21098'),
(9, 'James', 'Rodriguez', '6667778888', 'james.rodriguez@example.com', 'mersin', '87654'),
(10, 'Sophia', 'Hernandez', '9998887777', 'sophia.hernandez@example.com', 'istanbul', '10987'),
(11, 'William', 'Walker', '1112223333', 'william.walker@example.com', 'mersin', '45678'),
(12, 'Amelia', 'Young', '4445556666', 'amelia.young@example.com', 'adana', '54321'),
(13, 'Benjamin', 'White', '7778889999', 'benjamin.white@example.com', 'istanbul', '67890'),
(14, 'Emma', 'King', '1234567890', 'emma.king@example.com', 'mersin', '23456'),
(15, 'Liam', 'Clark', '5556667777', 'liam.clark@example.com', 'adana', '87654'),
(16, 'Ava', 'Lewis', '8889990000', 'ava.lewis@example.com', 'istanbul', '34567'),
(17, 'Lucas', 'Martin', '3334445555', 'lucas.martin@example.com', 'mersin', '78901'),
(18, 'Mia', 'Harris', '6667778888', 'mia.harris@example.com', 'adana', '21098'),
(19, 'Ella', 'Moore', '9998887777', 'ella.moore@example.com', 'istanbul', '45678'),
(20, 'Noah', 'Taylor', '1112223333', 'noah.taylor@example.com', 'mersin', '54321');

INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
(1, 1, '2024-04-01', '2024-04-05', '2024-04-03', 1, 1),
(2, 1, '2024-04-02', '2024-04-06', '2024-04-04', 2, 1),
(3, 1, '2024-04-03', '2024-04-07', '2024-04-05', 3, 2),
(4, 1, '2024-04-04', '2024-04-08', '2024-04-06', 1, 2),
(5, 1, '2024-04-05', '2024-04-09', '2024-04-07', 2, 3),
(6, 1, '2024-04-06', '2024-04-10', '2024-04-08', 3, 1),
(7, 1, '2024-04-07', '2024-04-11', '2024-04-09', 1, 2),
(8, 1, '2024-04-08', '2024-04-12', '2024-04-10', 2, 2),
(9, 1, '2024-04-09', '2024-04-13', '2024-04-11', 3, 3),
(10, 1, '2024-04-10', '2024-04-14', '2024-04-12', 1, 1),
(11, 1, '2024-04-11', '2024-04-15', '2024-04-13', 2, 1),
(12, 1, '2024-04-12', '2024-04-16', '2024-04-14', 3, 3),
(13, 1, '2024-04-13', '2024-04-17', '2024-04-15', 1, 1),
(14, 1, '2024-04-14', '2024-04-18', '2024-04-16', 2, 1),
(15, 1, '2024-04-15', '2024-04-19', '2024-04-17', 3, 2),
(16, 1, '2024-04-16', '2024-04-20', '2024-04-18', 1, 3),
(17, 1, '2024-04-17', '2024-04-21', '2024-04-19', 2, 3),
(18, 1, '2024-04-18', '2024-04-22', '2024-04-20', 3, 4),
(19, 1, '2024-04-19', '2024-04-23', '2024-04-21', 1, 2),
(20, 1, '2024-04-20', '2024-04-24', '2024-04-22', 2, 2);

INSERT INTO stores (store_name, phone, email, street, city, state, zip_code)
VALUES
('Store A', '123-456-7890', 'storea@example.com', '123 Main St', 'Istanbul', 'Istanbul', '12345'),
('Store B', '098-765-4321', 'storeb@example.com', '456 Elm St', 'Ankara', 'Ankara', '54321'),
('Store C', '555-123-4567', 'storec@example.com', '789 Oak St', 'Izmir', 'Izmir', '67890'),
('Store D', '987-654-3210', 'stored@example.com', '321 Pine St', 'Bursa', 'Bursa', '23456'),
('Store E', '444-555-6666', 'storee@example.com', '654 Cedar St', 'Antalya', 'Antalya', '87654'),
('Store F', '777-888-9999', 'storef@example.com', '987 Maple St', 'Adana', 'Adana', '34567'),
('Store G', '333-222-1111', 'storeg@example.com', '234 Birch St', 'Mersin', 'Mersin', '78901'),
('Store H', '222-333-4444', 'storeh@example.com', '567 Walnut St', 'Gaziantep', 'Gaziantep', '21098'),
('Store I', '666-777-8888', 'storei@example.com', '890 Ash St', 'Konya', 'Konya', '87654'),
('Store J', '999-888-7777', 'storej@example.com', '432 Spruce St', 'Bursa', 'Bursa', '10987'),
('Store K', '111-222-3333', 'storek@example.com', '765 Oak St', 'Istanbul', 'Istanbul', '45678'),
('Store L', '444-555-6666', 'storel@example.com', '890 Pine St', 'Ankara', 'Ankara', '54321'),
('Store M', '777-888-9999', 'storem@example.com', '123 Elm St', 'Izmir', 'Izmir', '67890'),
('Store N', '333-444-5555', 'storen@example.com', '456 Maple St', 'Antalya', 'Antalya', '78901'),
('Store O', '666-777-8888', 'storeo@example.com', '789 Cedar St', 'Adana', 'Adana', '21098'),
('Store P', '999-888-7777', 'storep@example.com', '321 Birch St', 'Istanbul', 'Istanbul', '45678'),
('Store Q', '111-222-3333', 'storeq@example.com', '654 Walnut St', 'Mersin', 'Mersin', '54321'),
('Store R', '444-555-6666', 'storer@example.com', '987 Ash St', 'Izmir', 'Izmir', '67890'),
('Store S', '777-888-9999', 'stores@example.com', '234 Pine St', 'Ankara', 'Ankara', '78901'),
('Store T', '333-444-5555', 'storet@example.com', '567 Elm St', 'Istanbul', 'Istanbul', '21098');

INSERT INTO staffs (f_name, l_name, email, phone, active, store_id, manager_id)
VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 1, 1, NULL),
('Jane', 'Smith', 'jane.smith@example.com', '098-765-4321', 1, 2, NULL),
('Michael', 'Johnson', 'michael.johnson@example.com', '555-123-4567', 1, 3, NULL),
('Emily', 'Brown', 'emily.brown@example.com', '987-654-3210', 1, 1, NULL),
('David', 'Martinez', 'david.martinez@example.com', '444-555-6666', 1, 2, NULL),
('Sarah', 'Garcia', 'sarah.garcia@example.com', '777-888-9999', 1, 3, NULL),
('Daniel', 'Lopez', 'daniel.lopez@example.com', '333-222-1111', 1, 1, NULL),
('Olivia', 'Gonzalez', 'olivia.gonzalez@example.com', '222-333-4444', 1, 2, NULL),
('James', 'Rodriguez', 'james.rodriguez@example.com', '666-777-8888', 1, 3, NULL),
('Sophia', 'Hernandez', 'sophia.hernandez@example.com', '999-888-7777', 1, 1, NULL),
('William', 'Walker', 'william.walker@example.com', '111-222-3333', 1, 2, NULL),
('Amelia', 'Young', 'amelia.young@example.com', '444-555-6666', 1, 3, NULL),
('Benjamin', 'White', 'benjamin.white@example.com', '777-888-9999', 1, 1, NULL),
('Emma', 'King', 'emma.king@example.com', '123-456-7890', 1, 2, NULL),
('Liam', 'Clark', 'liam.clark@example.com', '555-666-7777', 1, 3, NULL),
('Ava', 'Lewis', 'ava.lewis@example.com', '888-999-0000', 1, 1, NULL),
('Lucas', 'Martin', 'lucas.martin@example.com', '333-444-5555', 1, 2, NULL),
('Mia', 'Harris', 'mia.harris@example.com', '666-777-8888', 1, 3, NULL),
('Ella', 'Moore', 'ella.moore@example.com', '999-888-7777', 1, 1, NULL),
('Noah', 'Taylor', 'noah.taylor@example.com', '111-222-3333', 1, 2, NULL);


----------------Update , Delete , Select(between , and , or , in , is null , is not null)  statement --------------------
select *from staffs;

update customers 
set email = 'ab.hassan@gmail'
where customer_id=2;

update customers
set city ='mersin',
zip_code = '1454d'
where customer_id = 1;

delete from customers
where customer_id = 2;

delete from orders
where customer_id between 3 and 7;

select customer_id , f_name , l_name from customers

select f_name +'  '+l_name as 'Full Name' from customers

select *from customers where f_name='Jane' or l_name = 'Lucas'

select distinct l_name from customers -- distinct : tekrarsiz bir sekilde gosteiyor
--------------------------------------------------

---------Join tables (inner & {natural join MSsql doesn't support it }) statmant---------
-- 1. yol inner join
select f_name , l_name , email , order_id , order_date ,store_id
from customers c , orders o 
where c.customer_id = o.customer_id

-- 2. yol inner join
select f_name , l_name , email , order_id , order_date ,store_id
from customers c join orders o 
on c.customer_id = o.customer_id

-- inner join
select f_name , l_name , email , order_id , order_status , order_date
from orders c , staffs o 
where c.staff_id = o.staff_id

-- join more than 2 tables
-- 1. yol
select f_name , l_name , order_id , order_date , store_name , street , s.city 
from customers c , orders o , stores s
where c.customer_id = o.customer_id and o.store_id = s.store_id

-- 2. yol 
select f_name , l_name , order_id , order_date , store_name , street , s.city 
from customers c join orders o on c.customer_id = o.customer_id 
join stores s on o.store_id = s.store_id
