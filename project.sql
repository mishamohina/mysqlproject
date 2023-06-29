CREATE DATABASE Librarydb;
USE Librarydb;
CREATE TABLE Branch (Branch_no INT PRIMARY KEY,
Manager_Id VARCHAR(10),
Branch_address VARCHAR(250),
Contact_no INT(10));
INSERT INTO Branch(Branch_no,Manager_Id,Branch_address,Contact_no) VALUES
(123,'2445','123,Downing Street',678905),
(124,'1140','141 Beau Lane',678900),
(125,'2934','54 Private Lane',345678),
(126,'6789','23 Humming Street',234567),
(127,'5234','32 Harry Road',3456898);
CREATE TABLE Employee(Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(50),
Position VARCHAR (25),
Salary INT(20));
INSERT INTO Employee(Emp_Id,Emp_name,Position,Salary) VALUES
('2445','Harry Joe','Accountant',25000),
('1140','Manik Malhotra','Analyst',50000),
('2934','Jack Dawson','General',15000),
('6789','Gayatri Devi','Legal',75000),
('5234','Neha Solanki','Finance',25000);
CREATE TABLE Customer(Customer_Id INT PRIMARY KEY,
Customer_Name VARCHAR(50),
Customer_Address VARCHAR(100),
Reg_date DATE); 
INSERT INTO  Customer (Customer_Id,Customer_Name,Customer_Address,Reg_date) VALUES
(100,'Wade Austin','234 NW Bobcat Lane','2022-01-10'),
(101,'Dave Hallow','0210 Broadway Blvd','2020-12-06'),
(102,'Riley Wall','2880 Nulla St.Mankato','2021-12-28'),
(103,'Theodore Lowe','859 Sit Rd.Azusa New York','2021-03-13'),
(104,'Nyssa Vazquez','5762 At Rd.Chelsea ','2023-05-20');


CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY,
Issued_cust INT  ,
Issued_book_name VARCHAR(100),
Issue_date DATE,
Isbn_book INT(50), 
FOREIGN KEY(Issued_cust) REFERENCES Customer(customer_id),
FOREIGN KEY (Isbn_book) REFERENCES Books(isbn) );
INSERT INTO IssueStatus (Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_book) VALUES
(11,100,'Mike Tyson : Undisputed Truth','2023-05-01','0964'),
(12,101,'V for Vendetta','2023-05-06','6901'),
(13,102,'When Breath Becomes Air','2023-05-06','9094'),
(14,103,'The Great Gatsby','2023-05-05','8653'),
(15,104,'X-Men: God Loves, Man Kills','2023-05-03','9788');
CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,
Return_cust VARCHAR(50),
Return_book_name VARCHAR(150),
Return_date  DATE,
 Isbn_book2 INT(50),
 FOREIGN KEY (Isbn_book2) REFERENCES Books(isbn));
 INSERT INTO ReturnStatus(Return_Id,Return_cust,Return_book_name ,Return_date, Isbn_book2 ) VALUES
 (21,100,'Mike Tyson : Undisputed Truth','2023-05-11','0964'),
 (22,104,'X-Men: God Loves, Man Kills','2023-05-23','9788'),
 (23,102,'When Breath Becomes Air','2023-05-16','9094'),
 (24,101,'V for Vendetta','2023-05-26','6901'),
 (25,103,'The Great Gatsby','2023-05-15','8653');
CREATE TABLE Books(ISBN INT PRIMARY KEY,
Book_title VARCHAR(150),
Category VARCHAR(100),
Rental_Price int(5),
Status BIT NOT NULL,
Author VARCHAR(100),
Publisher VARCHAR(100)
); 
INSERT INTO Books (ISBN,Book_title,Category,Rental_Price,Status,Author,Publisher) VALUES
('9788', 'X-Men: God Loves, Man Kills','Comics',98,1,'Chris','Marvel Comics'),
('0964','Mike Tyson : Undisputed Truth','Sports',654,0, 'Larry Sloman, Mike Tyson','HarperCollins'),
('6901','V for Vendetta', 'Comics', 600,0,'Alan Moore','DC Comics'),
('9094', 'When Breath Becomes Air','Medical', 500,1,'Paul Kalanithi','‎Bodley Head'),
('8653', 'The Great Gatsby', 'Fiction', 432,1,'F. Scott Fitzgerald','C. Scribners Sons');

SELECT*from books;
SELECT*from branch;
SELECT*from customer;
SELECT*from employee;
SELECT*from issuestatus;
SELECT*from returnstatus;

--  1 Retrieve the book title, category, and rental price of all available books. 
select book_title,category,rental_price from books where status='yes';


-- 2   List the employee names and their respective salaries in descending order of salary. 
SELECT emp_name,salary from employee ORDER BY salary DESC;

-- 3 Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 3 Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;


-- 5 Retrieve the employee names and their positions for the employees whose salaries are above Rs.5000.
SELECT emp_name,position from employee where salary>=5000;

-- 6  List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7 Display the branch numbers and the total count of employees in each branch. 
SELECT b.Branch_no, COUNT(*) AS Total_Employees
FROM Branch b JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

-- 8  Display the names of customers who have issued books in the month of June 2023. 
SELECT c.Customer_name FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE i.Issue_date >= '2023-06-01' AND i.Issue_date < '2023-07-01';

-- 9  Retrieve book_title from book table containing history.
SELECT book_title from books where category ='crime'; 

-- 10 Retrieve the branch numbers along with the count of employees for branches having more than 5 employees. 

SELECT b.Branch_no, COUNT(*) AS Employee_Count FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no
HAVING COUNT(*) > 5;

-- 6  List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7 Display the branch numbers and the total count of employees in each branch. 
SELECT b.Branch_no, COUNT(*) AS Total_Employees
FROM Branch b JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

-- 8  Display the names of customers who have issued books in the month of June 2023. 
SELECT c.Customer_name FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE i.Issue_date >= '2023-06-01' AND i.Issue_date < '2023-07-01';

-- 9  Retrieve book_title from book table containing history.
SELECT book_title from books where category ='crime'; 

-- 10 Retrieve the branch numbers along with the count of employees for  branches having more than 5 employees. 

SELECT b.Branch_no, COUNT(*) AS Employee_Count FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no
HAVING COUNT(*) > 5;
