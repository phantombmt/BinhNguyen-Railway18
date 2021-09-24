DROP DATABASE IF EXISTS Testing_System_Assignment_1; 

CREATE DATABASE  Testing_System_Assignment_1 ;

USE Testing_System_Assignment_1 ; 
-- ----------------------------------
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (DepartmentID)
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
    PositionID INT AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY (PositionID)
);

ALTER TABLE position MODIFY COLUMN PositionName ENUM ('Dev1','Dev2','Tester1','Tester2','PM',
'Dev_Leader','Tester_Leader','BrSE1','BrSE2','BrSE_Leader');

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    AccountID INT AUTO_INCREMENT,
    Email VARCHAR(50) UNIQUE,
    UserName VARCHAR(50) NOT NULL,
    FullName VARCHAR(50),
    DepartmentID INT,
    PositionID INT,
    CreatedDate DATETIME,
    PRIMARY KEY (AccountID),
    FOREIGN KEY (PositionID)
        REFERENCES Position (PositionID)
        ON DELETE CASCADE
);
-- ALTER TABLE `Account` ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE;

-- ALTER TABLE `Account` AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID INT AUTO_INCREMENT,
    GroupName VARCHAR(50) NOT NULL,
    CreatorID INT,
    CreatedDate DATETIME,
    PRIMARY KEY (GroupID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountID)
        ON DELETE CASCADE
);

-- ALTER TABLE `Group` DROP FOREIGN KEY group_ibfk_1;

-- ALTER TABLE `Group` ADD FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID) ON DELETE SET NULL ON UPDATE CASCADE;

DROP TABLE IF EXISTS Groupaccount;
CREATE TABLE Groupaccount (
    GroupID INT,
    AccountID INT,
    JoinDate DATETIME
);


DROP TABLE IF EXISTS Typequestion;
CREATE TABLE Typequestion (
    TypeID INT AUTO_INCREMENT,
    TypeName VARCHAR(50),
    PRIMARY KEY (TypeID)
);

DROP TABLE IF EXISTS Categoryquestion;
CREATE TABLE Categoryquestion (
    CategoryID INT AUTO_INCREMENT,
    CategoryName ENUM('Node JS','Java','SQL','HTML','CSS ',
		   '.NET','Python','Ruby','JavaScript','Ruby On Rails'),
    PRIMARY KEY (CategoryID)
);


DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    QuestionID INT AUTO_INCREMENT,
    Content VARCHAR(50),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreatedDate DATETIME,
    PRIMARY KEY (QuestionID),
    FOREIGN KEY (TypeID)
        REFERENCES Typequestion (TypeID)
        ON DELETE CASCADE,
    FOREIGN KEY (CategoryID)
        REFERENCES Categoryquestion (CategoryID)
        ON DELETE CASCADE,
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountID)
        ON DELETE CASCADE
);


DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    AnswerID INT AUTO_INCREMENT,
    Content VARCHAR(50),
    QuestionID INT NOT NULL,
    IsCorrect ENUM('TRUE', 'FALSE'),
    PRIMARY KEY (AnswerID),
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
        ON DELETE CASCADE
);


DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    ExamID INT AUTO_INCREMENT,
    `Code` VARCHAR(30) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID INT,
    Duration DATETIME,
    CreatorID INT,
    CreatedDate DATETIME,
    PRIMARY KEY (ExamID),
    FOREIGN KEY (CategoryID)
        REFERENCES Categoryquestion (CategoryID)
        ON DELETE CASCADE,
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountID)
        ON DELETE CASCADE
);

ALTER TABLE Exam MODIFY COLUMN Duration TINYINT UNSIGNED NOT NULL;


DROP TABLE IF EXISTS Examquestion;
CREATE TABLE Examquestion (
    ExamID INT,
    QuestionID INT,
    FOREIGN KEY (ExamID)
        REFERENCES Exam (ExamID)
        ON DELETE CASCADE,
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
        ON DELETE CASCADE
);

-- -----------------------------------
-- ------------------------------------------------------------------------ INSERT DATA ------------------------



-- --------------------------------------TABLE Department

INSERT INTO department 	(DepartmentName)
	VALUES 	('Technical 1'),('Technical 2'),('Development 1'),('Development 2'),('Sale 1 '),('Sale 2'),
    ('Marketing 1'),('Marketing 2'),('Human Resouces'),('Finance');
    
    
--  -------------------------------------TABLE Position     

INSERT INTO position (PositionName) VALUES 
('Dev1'),('Dev2'),('Tester1'),('Tester2'),('PM'),
('Dev_Leader'),('Tester_Leader'),('BrSE1'),('BrSE2'),('BrSE_Leader');


-- --------------------------------------TABLE Account


INSERT INTO `account` (Email, Username, Fullname, DepartmentID, PositionID, CreatedDate)
	VALUES ('account1@vtiacademy.com', 'account1', 'Sakura1', 1, 1, '2019-12-01'),
		   ('account2@vtiacademy.com', 'account2', 'Sakura12', 1, 2, '2020-12-01'),
		   ('account3@vtiacademy.com', 'account3', 'Sakura123', 1, 1, '2020-07-01'),
		   ('account4@vtiacademy.com', 'account4', 'Sakura1234', 1, 2, '2019-09-01'),
		   ('account5@vtiacademy.com', 'account5', 'Sakura12345', 3, 2, '2020-07-01'),
		   ('account6@vtiacademy.com', 'account6', 'Sakura123456', 3, 1, '2019-09-14'),
		   ('account7@vtiacademy.com', 'account7', 'Sakura1234567', 3, 3, '2020-10-01'),
		   ('account8@vtiacademy.com', 'account8', 'Sakura12345678', 3, 4, '2019-04-01'),
		   ('account9@vtiacademy.com', 'account9', 'Sakura123456789', 2, 1, '2018-03-02'),
		   ('account10@vtiacademy.com','account10', 'Sakura', 1, 5, '2019-10-01');
           


-- ---------------------------------------TABLE Group


INSERT INTO `group` (GroupName, CreatorID, CreatedDate)
	VALUES ('Group1', '3', '2021-04-03'),
		   ('Group2', '3', '2019-01-03'),
		   ('Group3', '2', '2020-04-03'),
		   ('Group4', '1', '2020-07-14'),
		   ('Group5', '3', '2021-06-03'),
		   ('Group6', '1', '2020-04-03'),
		   ('Group7', '5', '2021-04-03'),
		   ('Group8', '5', '2019-05-03'),
		   ('Group9', '3', '2019-01-03'),
		   ('Group10', '1', '2019-09-14');


-- ---------------------------------------TABLE GroupAccount


INSERT INTO groupaccount (GroupID, AccountID, JoinDate)
	VALUES ('1', '1', '2021-06-01'),
		   ('1', '3', '2020-01-01'),
		   ('1', '2', '2020-09-14'),
		   ('1', '4', '2021-06-01'),
		   ('2', '1', '2021-06-01'),
		   ('2', '10', '2019-05-01'),
		   ('5', '1', '2021-06-01'),
		   ('5', '3', '2020-01-01'),
		   ('5', '4', '2021-07-01'),
		   ('3', '1', '2021-06-01'),
		   ('9', '2', '2021-06-01'),
		   ('10', '1', '2018-07-07');



-- --------------------------------------TABLE Typequestion


INSERT INTO typequestion (TypeName)
VALUES ('Objective_Test'),
       ('Subjective_Test');
       

-- --------------------------------------TABLE Categoryquestion


INSERT INTO CategoryQuestion (CategoryName)
	VALUES ('Node JS'),('Java'),('SQL'),('HTML'),('CSS '),
		   ('.NET'),('Python'),('Ruby'),('JavaScript'),('Ruby On Rails');
           
           
-- --------------------------------------TABLE Question


INSERT INTO `question` (Content, CategoryID, TypeID, CreatorID, CreatedDate)
	VALUES ('SQL 1', 3, 2, 1, '2021-04-01'),
		   ('SQL 2', 3, 2, 2, '2020-01-01'),
		   ('JAVA 1', 2, 1, 10, '2021-07-01'),
		   ('JAVA 2', 2, 2, 5, '2021-06-01'),
		   ('HTML 1', 4, 1, 2, '2020-01-01'),
		   ('HTML 2', 4, 2, 2, '2020-01-01'),
           ('Python 1', 7, 1, 2, '2020-01-01'),
           ('Python 2', 7, 1, 2, '2020-01-01'),
           ('Ruby 1', 10, 1, 2, '2020-01-01'),
           ('Ruby 2', 10, 1, 2, '2020-01-01');
           
           
-- ---------------------------------------TABLE Answer

delete from answer;
ALTER TABLE answer AUTO_INCREMENT = 1;

INSERT INTO answer (Content, QuestionID, IsCorrect)
	VALUES ('Answer 1 - question SQL 1', 1, 'True'),
		   ('Answer 2 - question SQL 1', 1, 'False'),
		   ('Answer 3 - question SQL 1', 1, 'False'),
		   ('Answer 4 - question SQL 1', 1, 'True'),
		   ('Answer 1 - question SQL 2', 2, 'False'),
		   ('Answer 2 - question SQL 2', 2, 'False'),
		   ('Answer 3 - question SQL 2', 2, 'False'),
		   ('Answer 4 - question SQL 2', 2, 'True'),
		   ('Answer 1 - question JAVA 1', 3, 'False'),
		   ('Answer 2 - question JAVA 1', 3, 'True'),
		   ('Answer 1 - question JAVA 2', 4, 'False'),
		   ('Answer 2 - question JAVA 2', 4, 'False'),
		   ('Answer 3 - question JAVA 2', 4, 'False'),
		   ('Answer 4 - question JAVA 2', 4, 'True'),
		   ('Answer 1 - question HTML 1', 5, 'True'),
		   ('Answer 2 - question HTML 2', 5, 'False');
           

-- -------------------------------------------TABLE Exam


INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreatedDate)
	VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
		   ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
		   ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
		   ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
		   ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
		   ('MS_06', 'De thi 06', 2, 90, 6, NOW()),
		   ('MS_07', 'De thi 07', 1, 60, 1, NOW()),
           ('MS_08', 'De thi 08', 2, 90, 4, NOW()),
           ('MS_09', 'De thi 09', 2, 90, 3, NOW()),
           ('MS_10', 'De thi 10', 2, 90, 7, NOW());
           
           
-- -------------------------------------------TABLE ExamQuestion

INSERT INTO examquestion
	VALUES (1, 10),
		   (2, 9),
		   (3, 8),
		   (4, 7),
		   (5, 6),
		   (6, 5),
		   (7, 4),
		   (8, 2),
		   (9, 3),
		   (10, 1);
		   