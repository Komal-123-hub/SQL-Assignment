---Create Salesman table---
CREATE TABLE salesman
(salesman_id int,namee varchar(20),city varchar(10),commission float(7))

---Insert into Salesman table---
INSERT INTO [AssigSql].[dbo].[salesman]
			([salesman_id]
			,[namee]
			,[city]
			,[commission])
     VALUES  
           (5001,'James Hoog','New York',0.15),   
           (5002,'Nail Knite','Paris',0.13),  
           (5005,'Pit Alex','London',0.11),
		   (5006,'Mc Lyon','Paris',0.14),
		   (5007,'Paul Adam','Rome',0.13),
		   (5003,'Lauson Hen','San Jose',0.12);

---Create Orders Table---
CREATE TABLE Orders
(ord_no int,purch_amt float(10),ord_date date,customer_id int,salesman_id int);

---Insert into Orders table---
INSERT INTO [AssigSql].[dbo].[Orders]
			([ord_no]
			,[purch_amt]
			,[ord_date]
			,[customer_id]
			,[salesman_id])
     VALUES  
            (70001,150.5,'10/5/2012',3005,5002)
		   ,(70009,270.65,'9/10/2012',3001,5005)
		   ,(70002,65.26,'10/5/2012',3002,5001)
		   ,(70004,110.5,'8/17/2012',3009,5003)
		   ,(70007,948.5,'9/10/2012',3005,5002)
		   ,(70005,2400.6,'9/10/2012',3007,5001)
		   ,(70008,5760,'9/10/2012',3002,5001)
		   ,(70010,1983.43,'10/10/2012',3004,5006)
		   ,(70003,2480.4,'10/10/2012',3009,5003)
		   ,(70012,250.45,'6/27/2012',3008,5002)
		   ,(70011,75.29,'8/17/2012',3003,507)
		   ,(70013,3045.6,'4/25/2012',3002,5001);

---Create Customer Table---
CREATE TABLE Customer
(customer_id int,cust_namee varchar(20),city varchar(10),grade int,salesman_id int)

---Insert into Customer table---
INSERT INTO [AssigSql].[dbo].[Customer]
			([customer_id]
			,[cust_namee]
			,[city]
			,[grade]
			,[salesman_id])
     VALUES  
            (3002,'Nick Rimando','New York',100,5001)
		   ,(3007,'Brad Davis','New York',200,5001)
		   ,(3005,'Graham Zusi','California',200,5001)
		   ,(3008,'Julian Green','London',300,5002)
		   ,(3004,'Fabian Johnson','Paris',300,5006)
		   ,(3009,'Geoff Cameron','Berlin',100,5003)
		   ,(3003,'Jozy Altidor','Moscow',200,5007)
		   ,(3001,'Brad Guzan','London',0,5005);

---Que 1 : Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome.---
SELECT * FROM salesman WHERE city='Paris' OR city='Rome'

---Que 2 : Write down query to find total number of salesman from city ‘Paris’---
SELECT COUNT(*) FROM salesman WHERE city='Paris'

---Que 3 : Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14. ---
SELECT * FROM salesman WHERE commission BETWEEN 0.12 AND 0.14

---Que 4 : Write a SQL statement to find those salesmen with all other information and name started with letter 'P'---
SELECT * FROM salesman WHERE namee LIKE 'P%'

---Que 5 : Write a SQL statement to find the total purchase amount of all orders.---
SELECT SUM(purch_amt) FROM Orders

---Que 6 : Write a SQL statement to find the average purchase amount of all orders.---
SELECT AVG(purch_amt) FROM Orders

---Que 7 : Write a SQL statement to find the number of salesmen currently listing for all of their customers.---
SELECT COUNT(DISTINCT salesman_id) FROM Orders

---Que 8 : Write a SQL statement to get the maximum purchase amount among all the orders.---
SELECT MAX(purch_amt) FROM Orders

---Que 9 : Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.---
SELECT salesman_id,MAX(purch_amt) FROM Orders WHERE ord_date='2012-08-17' GROUP BY salesman_id

---Q.10- Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.---
SELECT o.ord_no,o.purch_amt,c.cust_namee,c.city
FROM Orders o,Customer c
WHERE o.customer_id=c.customer_id
AND o.purch_amt BETWEEN 500 AND 2000

---Q.11- Write a SQL statement to know which salesman are working for which customer.---
SELECT c.cust_namee AS "CustomerName"
,c.city,s.namee AS "Salesman",s.commission
FROM Customer c
INNER JOIN salesman s
ON c.salesman_id=s.salesman_id


---Q.12 - Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12% ---
SELECT c.cust_namee AS "CustomerName",
s.namee AS "Salesman",s.commission
FROM Customer c
INNER JOIN salesman s
ON c.salesman_id=s.salesman_id
WHERE s.commission>0.12

---Q.13- Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.--- 
SELECT o.ord_no,o.ord_date,o.purch_amt,
c.cust_namee AS "Customer Name",c.grade,s.namee AS "Salesman",s.commission 
FROM Orders o INNER JOIN Customer c ON o.customer_id=c.customer_id
INNER JOIN salesman s ON o.salesman_id=s.salesman_id

---Q14. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own. ---
SELECT c.cust_namee,c.city,c.grade,s.namee
AS "Salesman",s.city FROM Customer c LEFT JOIN salesman s 
ON c.salesman_id=s.salesman_id ORDER BY c.customer_id

---Q15. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.---
SELECT c.cust_namee,c.city,c.grade,s.namee AS "Salesman",
o.ord_no,o.ord_date,o.purch_amt FROM Customer c
RIGHT OUTER JOIN salesman s ON s.salesman_id=c.salesman_id
RIGHT OUTER JOIN Orders o ON o.customer_id=c.customer_id


