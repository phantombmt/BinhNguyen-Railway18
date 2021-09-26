USE testingsystem;

-- ------------------------------------------------------- Question 1 : Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT 
    a.AccountID, a.Fullname, d.DepartmentName
FROM
    `account` a
        INNER JOIN
    department d ON a.DepartmentID = d.DepartmentID;
    
    
-- -------------------------------------------------------Question 2 :Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

SELECT 
    *
FROM
    `account`
WHERE
    CreatedDate > '2010-12-20';
    
    
-- -------------------------------------------------------Question 3 :Viết lệnh để lấy ra tất cả các developer

SELECT 
    a.AccountID, a.FullName, p.PositionName
FROM
    `Account` a
        INNER JOIN
    Position p ON a.PositionID = p.PositionID
WHERE
    p.PositionName LIKE 'Dev%';
    
-- -----------------------------------------------------Question 4 : Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên


SELECT 
    A.DepartmentName, COUNT(A.DepartmentName) AS Total_emp
FROM
    (SELECT 
        a.AccountID, a.Fullname, d.DepartmentName
    FROM
        `account` a
    INNER JOIN department d ON a.DepartmentID = d.DepartmentID) AS A
GROUP BY DepartmentName
HAVING Total_emp > 3;


-- ---------------------------------------------------- Question 5 : Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
 
 
 -- ------------------------------ 1
 SELECT 
    *
FROM
    question
WHERE
    questionID IN (SELECT 
            A.questionID
        FROM
            ((SELECT 
                ex.questionID, COUNT(ex.questionID) AS Total_question
            FROM
                examquestion ex
            INNER JOIN question q ON ex.questionID = q.questionID
            GROUP BY ex.questionID
            HAVING Total_question = (SELECT 
                    COUNT(questionID) AS count_question
                FROM
                    examquestion
                GROUP BY questionID
                ORDER BY count_question DESC
                LIMIT 1))) AS A);




-- SELECT 
--     COUNT(questionID) AS count_question
-- FROM
--     examquestion
-- GROUP BY questionID
-- ORDER BY count_question DESC
-- LIMIT 1;


-- -------------------------------------------- 2

SELECT 
    *
FROM
    question
WHERE
    questionID IN (SELECT 
            B.questionID
        FROM
            (SELECT 
                questionID, COUNT(questionID) AS total_question_times
            FROM
                examquestion
            GROUP BY questionID
            HAVING total_question_times = (SELECT 
                    MAX(A.total_question_times)
                FROM
                    (SELECT 
                    COUNT(questionID) AS total_question_times
                FROM
                    examquestion
                GROUP BY questionID) AS A)) AS B);
    

-- -------------------------------------------------------Question 6 :Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT 
    A.CategoryName,
    COUNT(DISTINCT (A.questionID)) AS Total_question
FROM
    (SELECT 
        cq.CategoryName, exq.questionID
    FROM
        CategoryQuestion cq
    LEFT JOIN exam ex ON cq.CategoryID = ex.CategoryID
    LEFT JOIN ExamQuestion exq ON ex.examID = exq.examID) AS A
GROUP BY A.CategoryName;