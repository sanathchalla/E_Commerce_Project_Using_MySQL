create database  e_commerce;
use e_commerce;

/* ANSWER 1 */
create table supplier(SUPP_ID int primary key, SUPP_NAME varchar(50), SUPP_CITY varchar(50), SUPP_PHONE varchar(10));
create table customer(CUS_ID INT NOT NULL, CUS_NAME VARCHAR(20) NULL DEFAULT NULL, CUS_PHONE VARCHAR(10), CUS_CITY varchar(30) ,CUS_GENDER CHAR,PRIMARY KEY (CUS_ID));
create table category (CAT_ID INT NOT NULL, CAT_NAME VARCHAR(20) NULL DEFAULT NULL,PRIMARY KEY (CAT_ID));
create table product (PRO_ID INT NOT NULL, PRO_NAME VARCHAR(20) NULL DEFAULT NULL, PRO_DESC VARCHAR(60) NULL DEFAULT NULL, CAT_ID INT NOT NULL,PRIMARY KEY (PRO_ID),FOREIGN KEY (CAT_ID) REFERENCES CATEGORY (CAT_ID));
create table product_details (PROD_ID INT NOT NULL, PRO_ID INT NOT NULL, SUPP_ID INT NOT NULL, PROD_PRICE INT NOT NULL, PRIMARY KEY (PROD_ID),FOREIGN KEY (PRO_ID) REFERENCES PRODUCT (PRO_ID), FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER(SUPP_ID));
create table orders (ORD_ID INT NOT NULL, ORD_AMOUNT INT NOT NULL, ORD_DATE DATE, CUS_ID INT NOT NULL, PROD_ID INT NOT NULL,PRIMARY KEY (ORD_ID),FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),FOREIGN KEY (PROD_ID) REFERENCES PRODUCT_DETAILS(PROD_ID));
create table rating (RAT_ID INT NOT NULL, CUS_ID INT NOT NULL, SUPP_ID INT NOT NULL, RAT_RATSTARS INT NOT NULL,PRIMARY KEY (RAT_ID),FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER (SUPP_ID),FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID));

/* ANSWER 2 */
insert into supplier values 
( '1', 'Rajesh Retails', 'Delhi', '1234567890'),
('2', 'Appario Ltd', 'Mumbai', '2589631470'),
('3', 'Knome products', 'Bangalore', '9785462315'),
('4', 'Bansal Retails', 'Kochi', '8975463285'),
('5', 'Mittal Ltd', 'Lucknow', '7898456532');

insert into customer values
('1', 'AAKASH', 9999999999, 'DELHI', 'M'),
('2', 'AMAN', 9785463215, 'NOIDA', 'M'),
('3', 'NEHA', 9999999998, 'MUMBAI', 'F'),
('4', 'MEGHA', 9994562399, 'KOLKATA', 'F'),
('5', 'PULKIT', 7895999999, 'LUCKNOW', 'M');

INSERT INTO category values 
('1', 'BOOKS'),
('2', 'GAMES'),
('3', 'GROCERIES'),
('4', 'ELECTRONICS'),
('5', 'CLOTHES');

INSERT INTO product values
('1', 'GTA V', 'DFJDJFDJFDJFDJFJF', 2),
('2', 'TSHIRT', 'DFDFJDFJDKFD', 5),
('3', 'ROG LAPTOP', 'DFNTTNTNTERND', 4),
('4', '0ATS', 'REURENTBTOTH', 3),
('5', 'HARRY POTTER', 'NBEMCTHTJTH', 1);

INSERT INTO product_details values
('1', 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000);

insert into orders values
(20, 1500, '2021-10-12', 3, 5),
(25, 30500, '2021-09-16', 5, 2),
(26, 2000, '2021-10-01', 1, 1),
(30, 3500, '2021-08-16', 4, 3),
(50, 2000, '2021-10-06', 2, 1);

insert into rating values 
(1, 2, 2, 4),
(2, 3, 4, 3),
(3, 5, 1, 5),
(4, 1, 3, 2),
(5, 4, 5, 4);

/* ANSWER 3 */
SELECT 
    c.CUS_ID
FROM
    customer c
        JOIN
    orders o ON c.CUS_ID = o.CUS_ID
WHERE
    o.ORD_AMOUNT >= 3000
GROUP BY CUS_GENDER;

/* ANSWER 4 */
select O.*, p.PRO_NAME from orders o 
join product p
on o.PROD_ID = p.PRO_ID
where o.CUS_ID = 2;

/* ANSWER 5 */
select * from supplier s
join product_details pd
on s.SUPP_ID = pd.SUPP_ID 
group by s.SUPP_ID, s.SUPP_NAME
having count(distinct(pd.PRO_ID)) > 1;

/* ANSWER 6 */
select * from category c where CAT_ID in (select p.CAT_ID from product p
join product_details pd
on p.PRO_ID = pd.PRO_ID where pd.PROD_ID in 
( select o.PROD_ID from orders o having min(o.ORD_AMOUNT))) 
group by c.CAT_ID, c.CAT_NAME;

/* ANSWER 7 */
select p.PRO_ID, p.PRO_NAME from product p
join product_details pd on p.PRO_ID = pd.PRO_ID where pd.PROD_ID in
(select o.PROD_ID from orders o where o.ORD_DATE > '2021-10-05')
group by p.PRO_ID, p.PRO_NAME;

/* ANSWER 8 */
select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS, c.CUS_NAME from supplier s
join rating r on s.SUPP_ID = r.SUPP_ID
join customer c on r.CUS_ID = c.CUS_ID
order by r.RAT_RATSTARS desc limit 3;

/* ANSWER 9 */
select CUS_NAME, CUS_GENDER from customer
where CUS_NAME like ('A%') or CUS_NAME like ('%A');

/* ANSWER 10 */
select sum(o.ORD_AMOUNT) from orders o
join customer c on o.CUS_ID = c.CUS_ID
where c.CUS_GENDER = 'M';

/* ANSWER 11 */
select * from customer c left join orders o on c.CUS_ID = o.CUS_ID;


