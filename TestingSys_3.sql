USE Testing_System_Assignment_1;

-- -------------------------------Question 2: Lấy ra tất cả các phòng ban 

SELECT 
    *
FROM
    Department;

-- -------------------------------Question 3: Lấy ra id của phòng ban "Sale"

SELECT 
    DepartmentID, DepartmentName
FROM
    Department
WHERE
    DepartmentName LIKE '%sale%';

-- -------------------------------Question 4: Lấy ra thông tin account có full name dài nhất


SELECT 
    *
FROM
    `account`
WHERE
    fullname IN (SELECT 
            MAX(fullname)
        FROM
            `Account`);

-- -------------------------------Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3


SELECT 
    *
FROM
    `account`
WHERE
    fullname IN (SELECT 
            MAX(fullname)
        FROM
            `account`
        WHERE
            departmentID = 3);


-- -------------------------------Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019

SELECT 
    GroupName
FROM
    `Group`
WHERE
    CreatedDate < '2019-12-20';


-- -------------------------------Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT 
    *
FROM
    answer;
    
    
SELECT 
    a.questionID, COUNT(a.questionID) AS count_questionID
FROM
    answer AS a
GROUP BY questionID
HAVING count_questionID >= 4;


SELECT 
    a.questionID
FROM
    answer AS a
GROUP BY questionID
HAVING COUNT(a.questionID) >= 4;


-- -------------------------------Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019

SELECT 
    e.`code`
FROM
    exam AS e
WHERE
    e.duration >= 60
        AND e.createdDate < '2019-12-20';
        

-- -------------------------------Question 9: Lấy ra 5 group được tạo gần đây nhất

SELECT 
    *
FROM
    `group`
ORDER BY createdDate DESC
LIMIT 5;


-- -------------------------------Question 10: Đếm số nhân viên thuộc department có id = 2

SELECT 
    DepartmentID, COUNT(accountID) AS Total_emp
FROM
    `account`
WHERE
    departmentID = 2;
    
-- -------------------------------Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT 
    fullname
FROM
    `account`
WHERE
    fullname LIKE 'd%o';
    
    
-- -------------------------------Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019


DELETE FROM exam WHERE CreatedDate < '2019-12-20';



-- -------------------------------Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"


DELETE FROM Question WHERE Content LIKE 'câu hỏi%';


-- -------------------------------Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn


UPDATE `account` 
SET 
    fullName = 'Nguyen Ba Loc',
    email = 'loc.nguyenba@vti.com.vn'
WHERE
    accountID = 5;

-- -------------------------------Question 15: Update account có id = 5 sẽ thuộc group có id = 4

UPDATE GroupAccount SET AccountID = 5 WHERE GroupID = 4;