DROP DATABASE IF EXISTS Testing_System_Assignment_1; 

CREATE DATABASE IF NOT EXISTS Testing_System_Assignment_1 ;

USE Testing_System_Assignment_1 ; 

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
ALTER TABLE `Account` ADD FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE;



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
    CategoryName ENUM('Java', '.NET', 'SQL', 'Postman', 'Ruby'),
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

-----------------------------------
