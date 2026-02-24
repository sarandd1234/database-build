/* =====================================================
   DATABASE BUILD SCRIPT – COURSE REGISTRATION SYSTEM
   ===================================================== */


/* ================= SCHEMA DEFINITION - SARAN ================= */
CREATE DATABASE IF NOT EXISTS course_registration_db;
USE course_registration_db

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

-- INSERT INTO statements go below, make sure to delete this line before commiting



/* ================= VALIDATION QUERIES -JEREMY ================= */

-- QA queries go below, make sure to delete this line before commiting
