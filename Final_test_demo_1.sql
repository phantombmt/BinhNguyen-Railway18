
-- --------------------------------Final_Testing_Exam1 -- 練習

DROP DATABASE IF EXISTS Final_Testing_Exam1;
CREATE DATABASE Final_Testing_Exam1;

USE Final_Testing_Exam1;

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    CustomerID TINYINT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(50) NOT NULL,
    Phone CHAR(10),
    Email VARCHAR(50) NOT NULL UNIQUE,
    Address VARCHAR(250),
    Note VARCHAR(100)
);


DROP TABLE IF EXISTS Car;
CREATE TABLE Car (
    CarID TINYINT PRIMARY KEY AUTO_INCREMENT,
    Maker ENUM('Honda', 'Toyota', 'Nissan'),
    Model VARCHAR(50),
    `Year` YEAR,
    Color VARCHAR(50),
    Note VARCHAR(100)
);


DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order` (
    OrderID TINYINT PRIMARY KEY AUTO_INCREMENT,
    CustomerID TINYINT,
    CarID TINYINT,
    Amount TINYINT DEFAULT 1,
    SalePrice INT,
    OrderDate DATETIME,
    DeliveryDate DATETIME,
    DeliveryAddress VARCHAR(255) NOT NULL,
    `Status` TINYINT DEFAULT 0,
    Note VARCHAR(100),
    FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID)
        ON DELETE CASCADE,
    FOREIGN KEY (CarID)
        REFERENCES Car (CarID)
        ON DELETE CASCADE
);



/* INSERT DATABASE */
-- customer
INSERT INTO	Customer 	(`Name`, 				Phone, 			Email, 					Address, 	Note)
			VALUES 		('Nguyen Van A', 		'0123456789',	'anguyen@gmail.com', 	'HN', 		'Thanh toan khi nhan hang'),
						('Tran Van B', 			'0902235500',	'btran@gmail.com', 		'HCM', 		'Da thanh toan'),
						('Ha Duc Chinh', 		'0975995669',	'chinhha@gmail.com', 	'ĐN', 		'Thanh toan truoc 30%'),
						('Nguyen Tuan Anh', 	'0862515616',	'anhtuan@gmail.com', 	'TB', 		'Thanh toan 50%'),
						('Nguyen Cong Phuong',	'0978555888',	'congphuong@gmail.com', 'NA', 		'Mua tra gop'),
						('Nguyen Quang Hai',	'0903456789',	'quanghai@gmail.com', 	'HN', 		'');
                        
-- car
INSERT INTO	Car (Maker,		Model, 		`Year`, Color,		Note)
	VALUES 		('HONDA', 	'Civic',	1990, 	'RED', 		'Sedan hang C'),
				('HONDA', 	'Accord',	1990, 	'BLACK', 	'Sedan hang D'),
                ('TOYOTA', 'CAMRY',	1990, 	'BLACK', 	'Sedan hang D'),
                ('NISSAN', 	'Altima',	1992, 	'GREY',		'Sedan hang C'),
                ('TOYOTA',	'Vios',		1990, 	'BLACK', 	'sedan hang C');
                
-- car_order
INSERT INTO	`Order` 	(CustomerID, 	CarID, 	Amount, 	SalePrice, 	OrderDate, 		DeliveryDate, 	DeliveryAddress, 	`Status`, 	Note)
	VALUES 				(1,				2,		1,			8000000, 	'2019-05-01',	'2019-05-26', 	'HN' ,				0,			'Da dat hang'),
						(2,				1,		2,			5000000, 	'2020-03-05',	'2020-03-21', 	'HCM' ,				1,			'Da giao hang'),
						(1,				2,		1,			8000000, 	'2021-03-01',	'2021-03-16', 	'DN' ,				0,			'Da dat hang'),
						(3,				1,		2,			5000000, 	'2020-08-06',	'2020-08-21', 	'HN' ,				0,			'Da dat hang'),
						(2,				2,		5,			8000000, 	'2021-03-01',	'2021-03-18', 	'HCM' ,				2,			'Da huy'),
						(4,				1,		2,			5000000, 	'2021-09-01',	'2021-09-20', 	'HCM' ,				1,			'Da giao hang'),
						(5,				3,		3,			10000000, 	'2021-03-02',	'2021-03-17', 	'NA' ,				1,			'Da giao hang'),
						(2,				2,		1,			8000000, 	'2020-06-01',	'2021-06-17', 	'HN' ,				2,			'Da huy'),
						(3,				3,		2,			10000000, 	'2020-03-01',	'2020-03-21', 	'NA' ,				1,			'Da giao hang'),
                        (1,				3,		4,			10000000, 	'2021-05-08',	'2021-05-20', 	'HCM' ,				1,			'Da giao hang'),
                        (3,				1,		1,			5000000, 	'2020-07-02',	'2020-07-15', 	'HN' ,				2,			'Da huy');




-- -----------------------------------Question B :  Write SQL script to list out information (Customer’s name, number of cars that customer bought) 
-- -----------------------------------and sort ascending by number of cars.


SELECT 
    c.`name` AS Customer_name, SUM(o.amount) AS Number_of_car
FROM
    customer c
        LEFT JOIN
    `order` o ON c.customerID = o.customerID
GROUP BY c.customerID
ORDER BY Number_of_car;


-- ----------------------------------Question C : Write a user function (without parameter) that return maker who has sale most cars in this year.

DELIMITER $$
CREATE FUNCTION Most_car_maker() RETURNS varchar(50)
DETERMINISTIC
BEGIN
DECLARE maker_name varchar(50);

SELECT 
    maker
INTO maker_name FROM
    (SELECT 
    c.maker, SUM(o.amount) AS total_cars
FROM
    car c
        JOIN
    `order` o ON c.carID = o.carID
WHERE
    o.`status` = 1
        AND o.DeliveryDate >= '2021-01-01'
GROUP BY c.maker
HAVING total_cars IN (SELECT 
        MAX(A.total_cars)
    FROM
        (SELECT 
            SUM(o.amount) AS total_cars
        FROM
            car c
        JOIN `order` o ON c.carID = o.carID
        WHERE
            o.`status` = 1
                AND o.DeliveryDate >= '2021-01-01'
        GROUP BY c.maker) AS A)) as B;
RETURN maker_name ; 
END $$
DELIMITER ; 

SELECT MOST_CAR_MAKER();


-- -------------------------------------------- Question D : Write a stored procedure (without parameter) to remove the orders have status is 
-- ------------------------------------------- canceled in the years before. Print out the number of records which are removed.

select * from `Order`;
commit;
rollback;

DROP PROCEDURE IF EXISTS remove_canceled_orders;
DELIMITER $$
CREATE PROCEDURE remove_canceled_orders()
BEGIN
SELECT 
    COUNT(orderID) AS Canceled_oder_total
FROM
    `Order`
WHERE
    orderDate < '2021-01-01'
        AND `status` = '2';		
        

DELETE FROM `Order` 
WHERE
    orderDate < '2021-01-01'
    AND `status` = '2';
    
END$$
DELIMITER ; 




    
-- -------------------------------------------- Question E : Write a stored procedure (with CustomerID parameter) to print out
-- ----------------------------------------information (Customer’s name, OrderID, Amount, Maker) that have status of the order is ordered.


SELECT 
    c.customerID, c.`name`, o.OrderID, o.Amount, cr.Maker
FROM
    Customer c
        JOIN
    `Order` o ON c.CustomerID = o.CustomerID
        JOIN
    Car cr ON o.CarID = cr.CarID
WHERE
    o.`status` = 0;

-- ---------------------
    
DROP PROCEDURE IF EXISTS Ordered_check;
DELIMITER $$
CREATE PROCEDURE Ordered_check(IN input_customerID INT)
BEGIN
	SELECT 
	c.`name`, o.OrderID, o.Amount, cr.Maker
FROM
    Customer c
        JOIN
    `Order` o ON c.CustomerID = o.CustomerID
        JOIN
    Car cr ON o.CarID = cr.CarID
WHERE
    o.`status` = 0 AND c.customerID = input_customerID;
END $$
DELIMITER ; 

CALL Ordered_check();




-- -------------------------------- Question F :Write the trigger(s) to prevent the case that the end user to input invalid
--                                    order information (DeliveryDate < OrderDate + 15).


DELIMITER $$
CREATE TRIGGER Trig_check_invalid_input
BEFORE INSERT ON `Oder` FOR EACH ROW
BEGIN

	IF NEW.DeliveryDate < NEW.OrderDate +15 THEN SET NEW.DeliveryDate = NULL,NEW.OrderDate =NULL ;
    END IF;

END$$
DELIMITER ; 




