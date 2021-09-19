create database Testing_System_Assignment_1 ;
use Testing_System_Assignment_1 ; 

CREATE TABLE department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NULL
);

CREATE TABLE Position (
    PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

CREATE TABLE account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) UNIQUE,
    UserName VARCHAR(50) NOT NULL,
    FullName VARCHAR(50),
    DepartmentID INT UNSIGNED,
    PositionID INT UNSIGNED,
    CreatedDate DATETIME
);

CREATE TABLE `group` (
    GroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(50) NOT NULL,
    CreatorID MEDIUMINT UNSIGNED,
    CreatedDate DATETIME
);

CREATE TABLE groupaccount (
    GroupID INT,
    AccountID INT,
    JoinDate DATETIME
);

CREATE TABLE typequestion (
    TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(50)
);

CREATE TABLE categoryquestion (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby')
);

CREATE TABLE question (
    QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreatedDate DATETIME
);

CREATE TABLE answer (
    AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(50),
    QuestionID INT,
    IsCorrect ENUM('TRUE', 'FALSE')
);


CREATE TABLE exam (
    ExamID INT PRIMARY KEY AUTO_INCREMENT,
    `Code` VARCHAR(30) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID INT UNSIGNED,
    Duration DATETIME,
    CreatorID INT,
    CreatedDate DATETIME
);


CREATE TABLE examquestion (
    ExamID INT PRIMARY KEY,
    QuestionID INT
);


