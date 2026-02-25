/* =====================================================
   DATABASE BUILD SCRIPT – COURSE REGISTRATION SYSTEM
   ===================================================== */

CREATE DATABASE IF NOT EXISTS course_registration_db;
USE course_registration_db;
   
/* ================= SCHEMA DEFINITION - SARAN ================= */
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseNum VARCHAR(20) NOT NULL,
    CreditHours INT NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Session (
    SessionID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    InstructorID INT,
    Modality VARCHAR(50),
    MaxCapacity INT,
    Term VARCHAR(50),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    CurrentYear INT,
    Program VARCHAR(100),
    StudentNum VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SessionID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (SessionID) REFERENCES Session(SessionID)
);

/* ================= TEST DATA - TIFFANY ================= */

/* -------------------------
   DEPARTMENT
   ------------------------- */
INSERT INTO Department (DepartmentName)
VALUES
('Information Systems'),
('Marketing');


/* -------------------------
   COURSE
   ------------------------- */
INSERT INTO Course (CourseNum, CreditHours, DepartmentID)
VALUES
('INFO 465', 3, 1),
('INFO 360', 3, 1),
('INFO 361', 3, 1),
('MKTG 302', 3, 2),
('MKTG 410', 3, 2);


/* -------------------------
   INSTRUCTOR
   ------------------------- */
INSERT INTO Instructor (FirstName, LastName, DepartmentID)
VALUES
('Daniel', 'Kim', 1),
('Lisa', 'Lopez', 1),
('Sarah', 'Lee', 1),
('Michael', 'Brown', 2),
('Emily', 'Davis', 2);


/* -------------------------
   SESSION
   ------------------------- */
INSERT INTO Session (CourseID, InstructorID, Modality, MaxCapacity, Term)
VALUES
(1, 1, 'In-Person', 30, 'Fall 2026'),
(2, 2, 'Online', 40, 'Fall 2026'),
(3, 3, 'Hybrid', 25, 'Fall 2026'),
(4, 4, 'In-Person', 35, 'Fall 2026'),
(5, 5, 'Online', 50, 'Fall 2026');


/* -------------------------
   STUDENT
   ------------------------- */
INSERT INTO Student
(FirstName, LastName, DateOfBirth, CurrentYear, Program, StudentNum, Email)
VALUES
('Tiffany','Nguyen','2003-04-12',3,'Information Systems','S1001','tnguyen@vcu.edu'),
('Alex','Johnson','2002-07-21',4,'Information Systems','S1002','ajohnson@vcu.edu'),
('Maria','Garcia','2004-01-10',2,'Marketing','S1003','mgarcia@vcu.edu'),
('James','Wilson','2003-03-18',3,'Marketing','S1004','jwilson@vcu.edu'),
('Sophia','Lee','2004-09-02',2,'Information Systems','S1005','slee@vcu.edu'),
('David','Chen','2003-12-11',3,'Information Systems','S1006','dchen@vcu.edu'),
('Olivia','Martinez','2002-05-05',4,'Marketing','S1007','omartinez@vcu.edu'),
('Ethan','Clark','2003-08-14',3,'Information Systems','S1008','eclark@vcu.edu'),
('Ava','Hall','2004-02-20',2,'Marketing','S1009','ahall@vcu.edu'),
('Noah','Young','2003-06-30',3,'Information Systems','S1010','nyoung@vcu.edu');


/* -------------------------
   ENROLLMENT 
   ------------------------- */

INSERT INTO Enrollment (StudentID, SessionID)
VALUES
-- Student 1 enrolled in TWO sessions
(1,1),
(1,2),

-- Five students enrolled in one session
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),

-- Remaining students enrolled in one session
(7,2),
(8,3),
(9,4),
(10,5);

/* ================= VALIDATION QUERIES -JEREMY ================= */

-- List all students registered for a specific course session (SessionID = 1)
SELECT s.StudentID, s.FirstName, s.LastName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
WHERE e.SessionID = 1;

-- Find all instructors teaching in the Information Systems department
SELECT i.FirstName, i.LastName
FROM Instructor i
JOIN Department d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Information Systems';

-- Retrieve the number of available slots in a specific session (SessionID = 1)
SELECT (s.MaxCapacity - COUNT(e.StudentID)) AS AvailableSlots
FROM Session s
LEFT JOIN Enrollment e ON s.SessionID = e.SessionID
WHERE s.SessionID = 1
GROUP BY s.SessionID, s.MaxCapacity;

-- Identify students registered for more than one session
SELECT s.StudentID, s.FirstName, s.LastName, COUNT(e.SessionID) AS NumberOfSessions
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(e.SessionID) > 1;
