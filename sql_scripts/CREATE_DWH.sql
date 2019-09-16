CREATE DATABASE  IF NOT EXISTS `DWH`;
USE `DWH`;

create table if not exists DIM_Products
(
	productKey int auto_increment
		primary key,
	productCode varchar(15) not null,
	productName varchar(70) not null,
	productDescription varchar(4000) null,
	productLine varchar(50) not null,
	textDescription varchar(4000) null,
	productScale varchar(10) not null,
	productVendor varchar(50) not null,
	buyPrice decimal(10,2) not null,
	MSRP decimal(10,2) not null
);

create table if not exists DIM_customers
(
	customerKey int auto_increment
		primary key,
	customerNumber int not null,
	customerName varchar(50) not null,
	contactLastName varchar(50) not null,
	contactFirstName varchar(50) not null,
	phone varchar(50) not null,
	addressLine1 varchar(50) not null,
	addressLine2 varchar(50) null,
	city varchar(50) not null,
	state varchar(50) null,
	postalCode varchar(15) null,
	country varchar(50) not null,
	salesRepEmployeeNumber int null,
	creditLimit decimal(10,2) null
);

create table if not exists DIM_time
(
	dateKey int auto_increment
		primary key,
	date date null,
	year int not null,
	month int(10) not null,
	day int(10) not null,
	quarter int not null,
	halfYear int not null
);

create table if not exists FACT_Sales
(
	salesNumber int auto_increment
		primary key,
	orderDateKey int not null,
	requiredDateKey int not null,
	shippedDateKey int null,
	status varchar(15) not null,
	comments text null,
	customerKey int not null,
	productKey int not null,
	quantityOrdered int not null,
	priceEach decimal(10,2) not null,
	orderNumber int null,
	orderLineNumber smallint null,
	constraint FACT_Sales_DIM_Products_productKey_fk
		foreign key (productKey) references DIM_Products (productKey),
	constraint FACT_Sales_DIM_customers_customerKey_fk
		foreign key (customerKey) references DIM_customers (customerKey),
	constraint FACT_Sales_DIM_time_dateKey_fk
		foreign key (orderDateKey) references DIM_time (dateKey),
	constraint FACT_Sales_DIM_time_dateKey_fk_2
		foreign key (requiredDateKey) references DIM_time (dateKey),
	constraint FACT_Sales_DIM_time_dateKey_fk_3
		foreign key (shippedDateKey) references DIM_time (dateKey)
);