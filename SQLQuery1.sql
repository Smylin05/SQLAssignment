--Creating table for Customers

Create table Customers(
customers_id int not null primary key,
First_name varchar (20) not null ,
last_name varchar (10) not null ,
DOB date not null,
email varchar(20) not null,
phone_number bigint not null,
address varchar (20) not null)

--Creating table for Accounts

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
	customer_id int,
    account_type VARCHAR(50),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customers_id)
)

--Creating table for transactions

CREATE TABLE transactions(
transaction_id int not null Primary Key, 
account_id int not null,
Foreign Key (account_id) REFERENCES Accounts(account_id),
transaction_type varchar(20),
amount decimal(10,2),
transaction_date date)

insert into Customers values (1,'Christabell','Smylin','2004-04-12','chris@gmail.com',9443021233,'Chennai'),
                             (2,'Rubina','Sweetlin','2003-03-11','sweety@gmail.com',9435421233,'Bangalore'),
							 (3,'Peter','Mani','2004-02-12','petermani@gmail.com',489398929,'Chennai'),
							 (4,'priya','mohan','2004-12-3','priyamohan@gmail.com',347768839,'Hyderabad'),
							 (5,'Dany','joseph','2005-05-10','dany@gmail.com',9976848939,'Kerala'),
							 (6,'selvam','Raj','2002-03-06','selvaraj@gmail.com',684893922,'Chennai'),
							 (7,'wiliam','son','2007-07-11','william@gmail.com',8783622991,'Kerala'),
							 (8,'arul','rajjj','2005-08-08','arulraj@gmail.com',2193793929,'Bangalore'),
							 (9,'sam','joel','2003-02-21','samjoel@gmail.com',7638392992,'Chennai'),
							 (10,'harish','kumar','2003-04-22','harish@gmail.com',90329329,'Banglore')

insert into Accounts values(101,1,'savings', 50000.00),
                           (102,2,'current',10000.00),
                           (103,3,'savings',17500.00),
                           (104,4,'zero_balance',17500.50),
                           (105,5,'current',14000.00),
                           (106,6,'savings',18000.00),
                           (107,7,'savings',15000.00),
                           (108,8,'current',80000.00),
                           (109,9,'zero_balance',45000.00),
                           (110,10,'current',25000.00)

insert into transactions values(1,101,'Deposit',1000.00,'2024-04-01') ,
                               (2,102,'Deposit',5000.00,'2024-04-02'),
                               (3,103,'Transfer',3000.00,'2024-04-05'),
                               (4,104,'Withdraw',3000.00,'2024-04-04'),
                               (5,105,'Deposit',7000.00,'2024-04-05'), 
                               (6,106,'Transfer',4000.00,'2024-04-06'),
                               (7,107,'Withdraw',10000.00,'2024-04-07'),
                               (8,108,'Deposit',9000.00,'2024-04-08'),
                               (9,109,'Transfer',1000.00,'2024-04-09'),
                               (10,110,'Transfer',2000.00,'2024-04-10')

select * from Customers ;
select * from Accounts ;
select * from transactions ;

--Write a SQL query to retrieve the name, account type and email of all customers. 

select concat(Customers.First_name,Customers.last_name) as name , Accounts.account_type, Customers.email
from Customers, Accounts 
where Customers.customers_id=Accounts.customer_id



--Write a SQL query to list all transaction corresponding customer.

select c.First_name, t.transaction_id,t.transaction_date,t.transaction_type from Customers c ,Transactions t,Accounts a
where c.customers_id=a.customer_id AND a.account_id=t.account_id

--Write a SQL query to increase the balance of a specific account by a certain amount. 
update Accounts set balance=balance+2000 where account_id=107
 
 select * from Accounts

 --Write a SQL query to Combine first and last names of customers as a full_name. 

 select concat(Customers.First_name  ,' ' ,Customers.last_name) as full_name from Customers

-- Write a SQL query to remove accounts with a balance of zero where the account type is savings. 

delete  from Accounts where balance=0 and account_type='savings'

--Write a SQL query to Find customers living in a specific city. 

select * from customers where address='Chennai'

--Write a SQL query to Get the account balance for a specific account.

select balance from Accounts where account_id=104

--Write a SQL query to List all current accounts with a balance greater than $1,000. 

select * from Accounts where balance > 1000

--Write a SQL query to Retrieve all transactions for a specific account. 

select * from transactions where account_id=102

-- Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
SELECT 
    account_id,
    balance * (120/ 100) AS interest_accrued
FROM 
    Accounts
WHERE 
    account_type = 'savings';

--Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit. 
select * from Accounts where balance<30000

--Write a SQL query to Find customers not living in a specific city.

select * from Customers where  address!='Chennai';

--TASK 3

--1.Write a SQL query to Find the average account balance for all customers. 

select AVG(balance) from Accounts 

--2.Write a SQL query to Retrieve the top 10 highest account balances

SELECT top 10 customer_id, balance
FROM Accounts
ORDER BY balance DESC

--3.Write a SQL query to Calculate Total Deposits for All Customers in specific date. 

SELECT amount as total from transactions
where transaction_type='deposit'
AND transaction_date='2024-04-02'

--4. Write a SQL query to Find the Oldest and Newest Customers. 

select MIN(DOB) AS old_customers,
       MAX(DOB) AS new_customers
From Customers;

--5. Write a SQL query to Retrieve transaction details along with the account type. 

select  t.transaction_id,
        t.transaction_type,
		t.transaction_date,
		t.amount,
        a.account_type 
from Accounts  as a
join transactions as t
on a.account_id=t.account_id

--6.Write a SQL query to Get a list of customers along with their account details. 

SELECT 
    c.customers_id,
    c.First_name,
    c.last_name,
    c.DOB,
    c.email,
    c.phone_number,
    c.address,
    a.account_id,
    a.account_type,
    a.balance
FROM 
    Customers c
INNER JOIN 
    Accounts a ON c.customers_id = a.customer_id;

--7.Write a SQL query to Retrieve transaction details along with customer information for a specific account. 

select    
    c.customers_id,
    c.First_name,
    c.last_name,
    c.DOB,
    c.email,
    c.phone_number,
    c.address,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
	from Customers c
    join Accounts a
    on c.customers_id=a.customer_id
    join transactions t 
    on a.account_id=t.account_id
    where a.account_id=103

--8.Write a SQL query to Identify customers who have more than one account.

SELECT c.customers_id,c.First_name from Customers as c
join Accounts a
on c.customers_id=a.customer_id
group by c.customers_id,c.First_name
having COUNT(a.account_id )>1 

--9.Write a SQL query to Calculate the difference in transaction amounts between deposits and  withdrawals. 

SELECT 
(Select SUM(amount) from transactions
where transaction_type='deposit') -
(SELECT SUM(amount) from transactions
where transaction_type ='withdraw') as difference

--10.Write a SQL query to Calculate the average daily balance for each account over a specified period. 

SELECT 
    account_id,
    AVG(daily_balance) AS average_daily_balance
FROM (
    SELECT 
        t.account_id,
        SUM(t.amount) AS daily_balance
    FROM 
        Transactions t
    JOIN 
        Accounts a ON t.account_id = a.account_id
    WHERE 
        t.transaction_date BETWEEN '2024-04-05' AND '2024-04-10'
    GROUP BY 
        t.account_id, t.transaction_date) AS daily_balances
    GROUP BY 
        account_id;

--11.Calculate the total balance for each account type.

select account_type,SUM(balance) as total_balance
from Accounts
group by account_type


--12. Identify accounts with the highest number of transactions order by descending order. 

 SELECT 
    a.account_id,
    COUNT(t.transaction_id) AS num_transactions
FROM 
    Accounts a
JOIN 
    transactions t ON a.account_id = t.account_id
GROUP BY 
    a.account_id
ORDER BY 
    num_transactions DESC;


--13.List customers with high aggregate account balances, along with their account types. 

SELECT 
    c.customers_id,
    c.First_name,
    c.last_name,
    a.account_type,
    SUM(a.balance) AS total
FROM 
    Customers c
JOIN 
    Accounts a ON c.customers_id = a.customer_id
GROUP BY 
    c.customers_id, c.First_name, c.last_name, a.account_type
ORDER BY 
    total DESC;  

--14.Identify and list duplicate transactions based on transaction amount, date, and account

SELECT t.transaction_id,
       t.amount,
       t.transaction_date,
       t.account_id
FROM Transactions t
JOIN Transactions t1 ON t.amount = t1.amount
                      AND t.transaction_date = t1.transaction_date
                      AND t.account_id = t1.account_id
WHERE t.transaction_id <> t1.transaction_id
ORDER BY t.amount, t.transaction_date, t.account_id;




--Task 4

-- 1.Retrieve the customer(s) with the highest account balance. 

select c.customers_id,c.First_name  from Customers c
join accounts a
on c.customers_id=a.customer_id
where a.balance in (select top 1 balance from Accounts 
order by balance desc)

--2. Calculate the average account balance for customers who have more than one account. 

(SELECT 
    AVG(avg_balance) AS average_balance_for_multi_account_customers
FROM (
    SELECT 
        c.customers_id,
        COUNT(a.account_id) AS num_accounts,
        SUM(a.balance) AS total_balance,
        SUM(a.balance) / COUNT(a.account_id) AS avg_balance
    FROM 
        Customers c
    JOIN 
        Accounts a ON c.customers_id = a.customer_id
    GROUP BY 
        c.customers_id
    HAVING 
        COUNT(a.account_id) > 1)
 AS multi_account_customers)

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount. 

SELECT 
    account_id,
    transaction_id,
    transaction_type,
    amount
FROM 
    Transactions
WHERE 
    amount > (
        SELECT 
            AVG(amount)
        FROM 
            Transactions
    );


--4. Identify customers who have no recorded transactions. 
SELECT 
    c.customers_id,
    c.First_name,
    c.last_name
FROM 
    Customers c
LEFT JOIN 
    transactions t ON c.customers_id = t.account_id
WHERE 
    t.account_id IS NULL;

--5. Calculate the total balance of accounts with no recorded transactions. 

select 
    SUM(balance) as total_balance
from
    Accounts
where
    account_id NOT IN (SELECT DISTINCT account_id FROM transactions);

--6. Retrieve transactions for accounts with the lowest balance. 

SELECT 
    t.transaction_id,
    t.account_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    a.account_id
FROM 
    transactions t
JOIN 
    Accounts a ON a.account_id = t.account_id 
WHERE 
    a.balance in (SELECT MIN(balance) FROM Accounts);

--7. Identify customers who have accounts of multiple types. 

SELECT 
    customers_id,
    first_name,
    last_name
FROM 
    Customers
WHERE 
    customers_id IN (
        SELECT 
            customers_id
        FROM 
            Accounts
        GROUP BY 
            customer_id
        HAVING 
            COUNT(DISTINCT account_type) > 1
    );


--8. Calculate the percentage of each account type out of the total number of accounts.

SELECT 
    account_type,
    COUNT(account_type) AS num_accounts,
    (COUNT(account_type) * 100.0 / (SELECT COUNT(*) FROM Accounts)) AS percentage
FROM 
    Accounts
GROUP BY 
    account_type;

--9. Retrieve all transactions for a customer with a given customer_id. 
SELECT 
    t.transaction_id,
    t.account_id,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM 
    Transactions t
JOIN 
    (SELECT account_id FROM Accounts WHERE customer_id = 5) AS a_subquery 
ON 
    t.account_id = a_subquery.account_id;

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
SELECT 
    account_type,
    (
        SELECT 
            SUM(balance) 
        FROM 
            Accounts a_sub
        WHERE 
            a_sub.account_type = a.account_type
    ) AS total_balance
FROM 
    Accounts a
GROUP BY 
    account_type;




	
	




   

