
DROP DATABASE IF EXISTS thuctap;

CREATE DATABASE thuctap;

USE thuctap;

DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
    Country_id TINYINT PRIMARY KEY AUTO_INCREMENT,
    Country_name VARCHAR(50) UNIQUE NOT NULL
);


DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
    Location_id TINYINT PRIMARY KEY AUTO_INCREMENT,
    Street_address VARCHAR(100) NOT NULL,
    Postal_code VARCHAR(20) UNIQUE,
    Country_id TINYINT,
    FOREIGN KEY (Country_id)
        REFERENCES Country (Country_id) 
);


DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    Employee_id INT PRIMARY KEY AUTO_INCREMENT,
    Full_name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Location_id TINYINT,
        FOREIGN KEY (Location_id)
        REFERENCES Location (Location_id) 
);


-- --------------------------------------------------------Tạo table với các ràng buộc và kiểu dữ liệu Thêm ít nhất 3 bản ghi vào table


INSERT INTO	Country (Country_name ) VALUES  ('America'), 
											('Singapore'),
											('Japan'),
											('England'),
											('Viet Nam'), 
											('Jordan'),
											('Mexico'),
											('Colombia'),
											('Iceland' ),
                                            ('Romania');



insert into Location (Street_address, Postal_code, Country_id) 
					values  ( '5 Forest Street', '5070-175', 1),
							( '19 Graceland Trail', null, 2),
							( '533 Loftsgordon Road', null, 4),
							( '81272 Harper Hill', null, 4),
							( '39 Ho Tung Mau Tp.Sai Gon', null, 5),
							( '56402 Ridgeway Circle', null, 6),
							( '81399 Ohio Parkway', '238450', 2),
							( '9 Bunting Avenue', '73119', 8),
							('519 Milwaukee Place', null, 8),
							( '17720 Daystar Junction', '5020', 7);


INSERT INTO Employees (Employee_id, Full_name, Email, Location_id) 
VALUES 					(1, 'Horacio Dowsett', 'hdowsett0@npr.org', 2),
						(2, 'Terrell Carruthers', 'tcarruthers1@surveymonkey.com', 3),
						(3, 'Baily Gheerhaert', 'bgheerhaert2@wunderground.com', 3),
						(4, 'Sidonnie Scotter', 'sscotter3@imgur.com', 4),
						(5, 'Tran Van A', 'haha.tran@gmail.com', 5),
						(6, 'Elijah Banbrick', 'ebanbrick5@indiatimes.com', 6),
						(7, 'Sydney Eteen', 'seteen6@mozilla.com', 7),
						(8, 'Ferdy Kenward', 'nn03@gmail.com', 6),
						(9, 'Annalise Markwick', 'amarkwick8@soup.io', 3),
						(10, 'Jessica Andrag', 'jandrag9@amazonaws.com', 8);





-- --------------------------------------------------------2A : Lấy tất cả các nhân viên thuộc Việt nam



SELECT 
    *
FROM
    Employees
WHERE
    Employee_id IN (SELECT 
            e.Employee_id
        FROM
            Employees e
                LEFT JOIN
            Location l ON e.Location_id = l.Location_id
                JOIN
            Country c ON l.Country_id = c.Country_id
        WHERE
            c.Country_name = 'Viet Nam');



-- --------------------------------------------------------2B : Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"

SELECT 
    c.Country_name
FROM
    Employees e
        LEFT JOIN
    Location l ON e.Location_id = l.Location_id
        JOIN
    Country c ON l.Country_id = c.Country_id
WHERE
    e.Email = 'nn03@gmail.com';


-- --------------------------------------------------------2C : Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.

-- ------------Thống kê mỗi country có bao nhiêu employee đang làm việc :
SELECT 
    c.Country_name, COUNT(e.Employee_id) AS Emp_Total
FROM
    Country c
        LEFT JOIN
    Location l ON c.Country_id = l.Country_id
        LEFT JOIN
    Employees e ON l.Location_id = e.Location_id
GROUP BY c.Country_name
ORDER BY Emp_Total;


-- ------------Thống kê mỗi location có bao nhiêu employee đang làm việc :

SELECT 
    l.Location_id, COUNT(e.Employee_id) AS Emp_Total
FROM
    Location l
        LEFT JOIN
    Country c ON l.Country_id = c.Country_id
        LEFT JOIN
    Employees e ON l.Location_id = e.Location_id
GROUP BY l.Location_id
ORDER BY l.Location_id;




-- --------------------------------------------------------3 : Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employees


DROP TRIGGER IF EXISTS Trig_check_insert;
DELIMITER $$
CREATE TRIGGER Trig_check_insert
BEFORE INSERT ON Employees FOR EACH ROW
BEGIN
DECLARE location_over_10_emp INT;

SELECT 
    *
INTO location_over_10_emp FROM
    (SELECT DISTINCT
        e.Location_id
    FROM
        Country c
    JOIN Location l ON c.Country_id = l.Country_id
    JOIN Employees e ON l.Location_id = e.Location_id
    WHERE
        c.Country_name IN (SELECT 
                A.Country_name
            FROM
                (SELECT 
                c.Country_name, COUNT(e.Employee_id) AS Emp_Total
            FROM
                Country c
            LEFT JOIN Location l ON c.Country_id = l.Country_id
            LEFT JOIN Employees e ON l.Location_id = e.Location_id
            GROUP BY c.Country_name
            HAVING Emp_Total >= 10) AS A)) AS B
WHERE
    Location_id = NEW.Location_id;
    
    IF NEW.Location_id = location_over_10_emp THEN SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'INSERT FAILED (mỗi quốc gia chỉ có tối đa 10 employees)' ;
    END IF;
END$$
DELIMITER ; 



-- -----------------------------------------------4 : Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở location đó sẽ có location_id = null


ALTER TABLE Employees ADD FOREIGN KEY (Location_id)
        REFERENCES Location (Location_id) ON DELETE SET NULL;




