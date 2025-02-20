Create Table

CREATE TABLE IF NOT EXISTS Books(
Book_ID int  PRIMARY KEY,
Title VARCHAR(100),
Author	VARCHAR(100),
Genre	VARCHAR(50),
Published_Year INT,
Price	NUMERIC(10,2),
Stock INT)
;

create table IF NOT EXISTS customers(
Customer_ID int primary key,
Name varchar(100),
Email	varchar(100),
Phone	varchar(15),
City	varchar(50),
Country varchar(150)

);

create table IF NOT EXISTS orders(
Order_ID int primary key,
Customer_ID	int references customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date	Date,
Quantity	int,
Total_Amount NUMERIC(10,2)


);

 -- 1. Retrieve all the books in the 'Fiction' genre

 select * from books
 where genre = 'Fiction';

 -- 2. Find books published after the year 1950.
 select * from books 
 where published_year > 1950;


 -- 3. List * customers from the canada.
 select * from customers
 where
 	country = 'Canada';

-- 4. Show orders placed in November 2023.

select * from orders
where
	order_date between '2023-11-01' and '2023-11-30';

-- 5. Retrieve the total stock of books available.
select sum(stock) from books;

-- 6. Find the details of most expensive book
select * from books
where
	price = (select max(price) from books);

-- 7.  show all customers who ordered more then 1 quantity of a book.
select * from orders
where
	 quantity >1;

-- 8. Retrieve all the orders where the total amount exceeds 20$.
select * from orders
where
	total_amount > 20;

-- 9. list all genres available in the books table.
select DISTINCT genre as total_genre  from books;

-- 10. Find the books with the lowest stock.
select * from books
order by stock asc limit 1;


-- 11. Calculate the total revenue generated from all orders.
select sum(total_amount) from orders;

--                 LITTLE ADVANCE QUESTIONS !

-- 1. Retrieve the total number of books sold for each genre.
select genre , sum(quantity) from books join orders
on Books.book_ID = orders.book_ID
group by genre;

-- 2. Find the average price of books in the fantasy genre

Select avg(price) as avg_price from books
where
	genre = 'Fantasy';

-- 3. List customer who have placed at least 2 orders

select customer_ID,count(order_ID) from orders
group by customer_id
having count(order_ID) >=2;


-- 4. Find The most frequently ordered book.

select title, sum(quantity) from books t1
join orders t2
on t1.book_ID = t2.book_ID
group by title
order by sum(quantity) desc 
limit 1;


-- 5. Show the top 3 most expensive books of fantasy genre

select * from books
where genre = 'Fantasy'
order by price desc
limit 3;

-- 6. Retrieve the total quantity of books sold by each auther

select author , sum(quantity) as total_books from books t1
join orders t2
on t1.book_id = t2.book_ID
group by author
;
-- 7. List the cities where customers who spent over $30 are located
select distinct city,total_amount from customers t1 
join orders t2
on t1.customer_ID = t2.customer_ID
where total_amount >=30;


-- 8.Find The cutomer who spent the most on orders .
select * from customers t1
join orders t2
on t1.customer_ID = t2.customer_ID
where
	total_amount = (select max(total_amount) from orders);

-- 9. Calculate the stock remaining after fullfilling all order.

select t1.book_id,title,stock,coalesce(sum(quantity),0) as ordered_quntity,
t1.stock-coalesce(sum(quantity),0) as remaining_quantity
from books t1 left  join orders t2
on t1.book_ID = t2.book_ID
group by t1.book_id

--                             THANK YOU!