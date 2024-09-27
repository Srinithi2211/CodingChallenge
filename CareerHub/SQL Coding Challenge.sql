CREATE DATABASE CareerHub;
USE CareerHub;

CREATE TABLE Companies (
CompanyID INT IDENTITY(1,1) PRIMARY KEY,
CompanyName VARCHAR(50),
Location VARCHAR(50)
);
INSERT INTO Companies(CompanyName,Location) VALUES 
('Hexaware','Chennai'),
('Min.AI', 'Bangalore'),
('ABC software solutions','Coimbatore'),
('TechWorld','Bangalore'),
('Telex','Pune'),
('skyhigh','Kochi'),
('Tred','Delhi'),
('Sri Tech','Lucknow'),
('FirstStep','Mumbai'),
('ReachGoal','Hyderabad');

SELECT *FROM Companies;

CREATE TABLE Jobs(
JobID INT IDENTITY(1,1) PRIMARY KEY,
CompanyID INT,
JobTitle VARCHAR(50),
JobDescription VARCHAR(MAX),
JobLocation VARCHAR(50),
Salary DECIMAL(10,2),
JobType VARCHAR(50),
PostedDate DATETIME
CONSTRAINT FK_Jobs_Companies FOREIGN KEY(CompanyID) REFERENCES Companies(CompanyID)
);
INSERT INTO Jobs(CompanyID,JobTitle,JobDescription,JobLocation,Salary,JobType,PostedDate) VALUES
(1,'Graduate Engineer Trainee','Strong Problem-solving skills, Excellent communication','Chennai','400000.00','Full-time','2024-09-09 11:30:00'),
(2,'full stack developer','coding proficiency, multi-tasking ability', 'Bangalore', '700000.00','Full-time','2024-10-22 10:00:00'),
(3,'System engineer','Understanding of SQL','Coimbatore','350000.00','Full-Time','2023-07-08 12:45:00'),
(4,'Software Development Intern','Python proficiency','Bangalore','100000.00','Internship','2023-03-20 09:30:00'),
(5,'Embedded systems engineer','Understanding of Embedded systems','Pune','400000.00','Full-time','2023-05-04 06:25:00'),
(6,'Financial Analyst', 'Analyze financial data and create reports.','Kochi','85000.00','Contract','2024-01-11 04:05:00'),
(7,'Sales executive','Excellent communication skills','Delhi','200000.00','Part-time','2024-02-05 12:15:00'),
(8,'Designer','UI/UX, Flutter','Lucknow','300000.00','Full-time','2024-08-04 03:29:00'),
(9,'Education Consultant', 'Design educational programs and curriculum','Kochi','300000.00','Part-time','2023-12-04 05:34:00'),
(10,'Language Trainer', 'Ability to train and manage large number of students','Hyderabad','500000.00','Contract','2024-03-09 10:30:00');

SELECT *FROM Jobs;

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY, 
    FirstName VARCHAR(255) NOT NULL, 
    LastName VARCHAR(255) NOT NULL, 
    Email VARCHAR(255) NOT NULL UNIQUE, 
    Phone VARCHAR(50), 
    Resume TEXT
);

INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume)
VALUES 
(1, 'Arun', 'Kumar', 'arun.kumar@email.com', '9876543210', 'Graduate in Computer Science with strong problem-solving skills.'),
(2, 'Priya', 'Raman', 'priya.raman@email.com', '8765432109', 'Experienced full stack developer skilled in JavaScript and Python.'),
(3, 'Vijay', 'Shankar', 'vijay.shankar@email.com', '7654321098', 'System Engineer with strong knowledge of SQL and database management.'),
(4, 'Meera', 'Lakshmi', 'meera.lakshmi@email.com', '6543210987', 'Software development intern with Python proficiency.'),
(5, 'Sundar', 'Raj', 'sundar.raj@email.com', '5432109876', 'Embedded systems engineer with expertise in microcontrollers.'),
(6, 'Deepa', 'Natarajan', 'deepa.natarajan@email.com', '4321098765', 'Financial analyst with experience in financial reporting and analysis.'),
(7, 'Karthik', 'Bala', 'karthik.bala@email.com', '3210987654', 'Sales executive with excellent communication and negotiation skills.'),
(8, 'Shalini', 'Devi', 'shalini.devi@email.com', '2109876543', 'Designer with experience in UI/UX design and Flutter development.'),
(9, 'Ravi', 'Murthy', 'ravi.murthy@email.com', '1098765432', 'Education consultant with a passion for designing educational programs.'),
(10, 'Anitha', 'Sivakumar', 'anitha.sivakumar@email.com', '9087654321', 'Language trainer with a talent for managing large groups of students.');
SELECT *FROM Applicants;

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY, 
    JobID INT, 
    ApplicantID INT,
    ApplicationDate DATETIME, 
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID), 
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES 
(1, 1, 1, '2024-09-10 09:00:00', 'I am excited to apply for the Graduate Engineer Trainee role.'),
(2, 2, 2, '2024-10-23 11:15:00', 'I believe my full stack development experience will benefit your company.'),
(3, 3, 3, '2023-07-09 13:00:00', 'I am proficient in SQL and would be a great fit for the System Engineer position.'),
(4, 4, 4, '2023-03-21 10:00:00', 'As an intern with strong Python skills, I am eager to contribute to your team.'),
(5, 5, 5, '2023-05-05 07:00:00', 'I have a strong understanding of embedded systems and microcontrollers.'),
(6, 6, 6, '2024-01-12 05:00:00', 'My financial analysis skills will be valuable for the role.'),
(7, 7, 7, '2024-02-06 13:00:00', 'I am excited to apply my sales skills to this executive role.'),
(8, 8, 8, '2024-08-05 04:00:00', 'I would love to contribute to the UI/UX design team.'),
(9, 9, 9, '2023-12-05 06:00:00', 'I have experience designing effective educational programs.'),
(10, 10, 10, '2024-03-10 11:30:00', 'My language training experience will help your students succeed.');
SELECT *FROM Applications;

--4 error handling
BEGIN TRY
    INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume)
    VALUES 
    (11, 'Ravi', 'Shankar', 'ravi@email.com', '1234567890', 'Experienced sales exceutive'),
    (12, 'Jeni', 'Menon', 'jeni@email.com', '9287654321', 'Experience in designing curriculum');
    
    PRINT 'New applicants inserted successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error occurred while inserting applicants: ' + ERROR_MESSAGE();
END CATCH;

--5 to count the number of applications received for each job listing
SELECT j.JobTitle,count(a.ApplicationID) as No_of_applications FROM Jobs J JOIN Applications a ON j.JobID = a.JobID 
GROUP BY j.JobTitle
ORDER BY No_of_applications DESC;

--6 to retrieve job listings from the "Jobs" table within a specified salaryrange by allowing parameters for the minimum and maximum salary values.
DECLARE @MinSalary DECIMAL(18,2) = 300000.00;  
DECLARE @MaxSalary DECIMAL(18,2) = 700000.00;  

SELECT j.JobTitle,c.CompanyName,j.JobLocation,j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN @MinSalary AND @MaxSalary
ORDER BY  j.Salary;  

--7 to retrieves the job application history for a specific applicant
DECLARE @ApplicantID INT = 1;  

SELECT  j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN  Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE  a.ApplicantID = @ApplicantID
ORDER BY a.ApplicationDate DESC;  

--8 to find average salary offered by all companies
SELECT AVG(Salary) AS AverageSalary FROM Jobs
WHERE Salary > 0;  

--9 to identify the company that has posted the most job listings
SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName
HAVING COUNT(j.JobID) = (SELECT  MAX(JobCount) FROM (
            SELECT COUNT(j2.JobID) AS JobCount
            FROM Companies c2
            LEFT JOIN Jobs j2 ON c2.CompanyID = j2.CompanyID
            GROUP BY c2.CompanyName
        ) AS SubQuery
    );


--10 to find the applicants who have applied for positions in companies located in 'COIMBATORE' and have atleast 3 years of experience.
ALTER TABLE Applicants
ADD YearOfExperience INT;
UPDATE Applicants
SET YearOfExperience=5
WHERE ApplicantID = 3;
SELECT  a.ApplicantID, a.FirstName,a.LastName, a.Email, a.Phone, a.Resume
FROM  Applicants a
JOIN  Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN  Companies c ON j.CompanyID = c.CompanyID
WHERE  c.Location = 'Coimbatore'  AND a.YearOfExperience >= 3;  

--11 Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.
SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 600000 AND 800000;

--12 Find the jobs that have not received any applications.
SELECT j.JobID, j.JobTitle,j.CompanyID,j.JobLocation,j.Salary,j.JobType,j.PostedDate
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;  

-- In database all the jobs recieved application

--13 Retrieve a list of job applicants along with the companies they have applied to and the position they have applied for.
SELECT a.ApplicantID,
    a.FirstName,
    a.LastName,
    c.CompanyName,
    j.JobTitle
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
ORDER BY a.LastName, a.FirstName;  

--14 Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications.
SELECT c.CompanyID,
    c.CompanyName,
    COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName;

--15 List all applicants along with the companies and positions they have applied for, including those who have not applied.
SELECT a.ApplicantID,
    a.FirstName,
    a.LastName,
    c.CompanyName,
    j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID
ORDER BY a.LastName, a.FirstName;

--16 Find companies that have posted jobs with a salary higher than the average salary of all jobs.
SELECT DISTINCT c.CompanyID,c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

--17 Display a list of applicants with their names and a concatenated string of their city and state.
ALTER TABLE Applicants
ADD City VARCHAR(50);
    
UPDATE Applicants
SET City = CASE 
    WHEN ApplicantID = 1 THEN 'Chennai'
    WHEN ApplicantID = 2 THEN 'Bangalore'
    WHEN ApplicantID = 3 THEN 'Mumbai'
    WHEN ApplicantID = 4 THEN 'Kochi'
    WHEN ApplicantID = 5 THEN 'Chennai'
    WHEN ApplicantID = 6 THEN 'Coimbatore'
    WHEN ApplicantID = 7 THEN 'Mumbai'
    WHEN ApplicantID = 8 THEN 'Coimbatore'
    WHEN ApplicantID = 9 THEN 'Bangalore'
    WHEN ApplicantID = 10 THEN 'Hyderabad'
END;
ALTER TABLE Applicants
ADD State_ VARCHAR(50);
UPDATE Applicants
SET State_ = CASE
WHEN ApplicantID = 1 THEN 'Tamil Nadu'
    WHEN ApplicantID = 2 THEN 'Karnataka'
    WHEN ApplicantID = 3 THEN 'Maharashtra'
    WHEN ApplicantID = 4 THEN 'Kerala'
    WHEN ApplicantID = 5 THEN 'Tamil Nadu'
    WHEN ApplicantID = 6 THEN 'Tamil Nadu'
    WHEN ApplicantID = 7 THEN 'Maharashtra'
    WHEN ApplicantID = 8 THEN 'Tamil Nadu'
    WHEN ApplicantID = 9 THEN 'Karnataka'
    WHEN ApplicantID = 10 THEN 'Andhra Pradesh'
END;



SELECT a.FirstName, a.LastName, CONCAT(a.City, ', ', a.State_) AS Location
FROM Applicants a;



--18 Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
SELECT JobID, JobTitle,CompanyID,Salary,JobLocation
FROM Jobs 
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

--19 Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants.
SELECT a.ApplicantID,a.FirstName,a.LastName,j.JobTitle
FROM  Applicants a
FULL OUTER JOIN  Applications ap ON a.ApplicantID = ap.ApplicantID
FULL OUTER JOIN Jobs j ON ap.JobID = j.JobID
ORDER BY  a.LastName, a.FirstName, j.JobTitle;

--20 List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chennai.
SELECT a.ApplicantID, a.FirstName,a.LastName,c.CompanyName
FROM Applicants a
CROSS JOIN Companies c
WHERE  c.Location = 'Chennai'  AND a.YearOfExperience >2;
    