-- Create DEPARTMENT table with primary key first
CREATE TABLE DEPARTMENT (
    DEPT_NUMBER CHAR(1) CONSTRAINT PK_DEPARTMENT PRIMARY KEY,
    DNAME VARCHAR2(50) CONSTRAINT NN_DEPARTMENT_DNAME NOT NULL,
    CAMPUS VARCHAR2(50),
    HOD_ID CHAR(4),
    HOD_START_DATE DATE
);

-- Create LECTURER table with primary key first
CREATE TABLE LECTURER (
    LECTURER_ID CHAR(4) CONSTRAINT PK_LECTURER PRIMARY KEY,
    FIRST_NAME VARCHAR2(50) CONSTRAINT NN_LECTURER_FNAME NOT NULL,
    LAST_NAME VARCHAR2(50) CONSTRAINT NN_LECTURER_LNAME NOT NULL,
    BDATE DATE,
    ADDRESS VARCHAR2(100),
    EMAIL VARCHAR2(50) CONSTRAINT UK_LECTURER_EMAIL UNIQUE,
    PHONE CHAR(10),
    SEX CHAR(1) CONSTRAINT CK_LECTURER_SEX CHECK (SEX IN ('M','F','O')),
    SALARY NUMBER(10,2),
    DEPT_NUMBER CHAR(1)
);

-- Create STUDENT table with primary key first
CREATE TABLE STUDENT (
    STUDENT_ID CHAR(4) CONSTRAINT PK_STUDENT PRIMARY KEY,
    FIRST_NAME VARCHAR2(50) CONSTRAINT NN_STUDENT_FNAME NOT NULL,
    LAST_NAME VARCHAR2(50) CONSTRAINT NN_STUDENT_LNAME NOT NULL,
    SEX CHAR(1) CONSTRAINT CK_STUDENT_SEX CHECK (SEX IN ('M','F','O')),
    DATE_OF_BIRTH DATE CONSTRAINT NN_STUDENT_DOB NOT NULL,
    EMAIL VARCHAR2(50) CONSTRAINT UK_STUDENT_EMAIL UNIQUE,
    PHONE CHAR(10),
    ADDRESS VARCHAR2(100),
    DEPT_NUMBER CHAR(1)
);

-- Create COURSE table with primary key first
CREATE TABLE COURSE (
    COURSE_CODE CHAR(9) CONSTRAINT PK_COURSE PRIMARY KEY,
    TITLE VARCHAR2(50) CONSTRAINT NN_COURSE_TITLE NOT NULL,
    CREDIT NUMBER(2,0) CONSTRAINT CK_COURSE_CREDIT CHECK (CREDIT > 0),
    DESCRIPTION VARCHAR2(200),
    DEPT_NUMBER CHAR(1)
);

-- Create ENROLLMENT table with primary key first
CREATE TABLE ENROLLMENT (
    ENROLLMENT_CODE CHAR(6) CONSTRAINT PK_ENROLLMENT PRIMARY KEY,
    STUDENT_ID CHAR(4),
    COURSE_CODE CHAR(9),
    ENROLLMENT_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(10) CONSTRAINT CK_ENROLLMENT_STATUS CHECK (STATUS IN ('ACTIVE','DROPPED','COMPLETED'))
);

-- Create GRADE table with primary key first
CREATE TABLE GRADE (
    GRADE_CODE CHAR(2) CONSTRAINT PK_GRADE PRIMARY KEY,
    ENROLLMENT_CODE CHAR(6),
    ASSIGNMENT_SCORE NUMBER(5,2) CONSTRAINT CK_ASSIGNMENT_SCORE CHECK (ASSIGNMENT_SCORE BETWEEN 0 AND 20),
    EXAM_SCORE NUMBER(5,2) CONSTRAINT CK_EXAM_SCORE CHECK (EXAM_SCORE BETWEEN 0 AND 70),
    QUIZ_SCORE NUMBER(5,2) CONSTRAINT CK_QUIZ_SCORE CHECK (QUIZ_SCORE BETWEEN 0 AND 10),
    FINAL_GRADE NUMBER(5,2) GENERATED ALWAYS AS (
        (QUIZ_SCORE*0.1 + EXAM_SCORE*0.7 + ASSIGNMENT_SCORE*0.2)
    ) VIRTUAL
);

-- Create PAYMENT table with primary key first
CREATE TABLE PAYMENT (
    PAYMENT_CODE CHAR(8) CONSTRAINT PK_PAYMENT PRIMARY KEY,
    STUDENT_ID CHAR(4),
    AMOUNT NUMBER(10,2) CONSTRAINT NN_PAYMENT_AMOUNT NOT NULL,
    PAYMENT_DATE DATE DEFAULT SYSDATE,
    METHOD VARCHAR2(20) CONSTRAINT CK_PAYMENT_METHOD CHECK (METHOD IN ('CASH','CREDIT','DEBIT','TRANSFER')),
    TRANSACTION_ID CHAR(20) CONSTRAINT UK_PAYMENT_TXNID UNIQUE
);

-- Now add all foreign key constraints via ALTER TABLE
ALTER TABLE LECTURER 
ADD CONSTRAINT FK_LECTURER_DEPARTMENT 
FOREIGN KEY (DEPT_NUMBER) REFERENCES DEPARTMENT(DEPT_NUMBER);


ALTER TABLE STUDENT 
ADD CONSTRAINT FK_STUDENT_DEPARTMENT 
FOREIGN KEY (DEPT_NUMBER) REFERENCES DEPARTMENT(DEPT_NUMBER);

ALTER TABLE COURSE 
ADD CONSTRAINT FK_COURSE_DEPARTMENT 
FOREIGN KEY (DEPT_NUMBER) REFERENCES DEPARTMENT(DEPT_NUMBER);

ALTER TABLE ENROLLMENT 
ADD CONSTRAINT FK_ENROLLMENT_STUDENT 
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID);

ALTER TABLE ENROLLMENT 
ADD CONSTRAINT FK_ENROLLMENT_COURSE 
FOREIGN KEY (COURSE_CODE) REFERENCES COURSE(COURSE_CODE);

ALTER TABLE GRADE 
ADD CONSTRAINT FK_GRADE_ENROLLMENT 
FOREIGN KEY (ENROLLMENT_CODE) REFERENCES ENROLLMENT(ENROLLMENT_CODE);

ALTER TABLE PAYMENT 
ADD CONSTRAINT FK_PAYMENT_STUDENT 
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID);

-- Finally add the circular reference for HOD after all tables exist
ALTER TABLE DEPARTMENT 
ADD CONSTRAINT FK_DEPARTMENT_HOD 
FOREIGN KEY (HOD_ID) REFERENCES LECTURER(LECTURER_ID);

ALTER TABLE DEPARTMENT RENAME COLUMN CAMPUS TO FACULTY;

--  1. Insert into DEPARTMENT (without HOD initially)
-- ====================================================================
-- Note: HOD_ID and HOD_START_DATE will be updated after LECTURER data is inserted.
INSERT INTO DEPARTMENT (DEPT_NUMBER, DNAME, FACULTY)
VALUES ('1', 'Information Management', 'Information Technology');

INSERT INTO DEPARTMENT (DEPT_NUMBER, DNAME, FACULTY)
VALUES ('2', 'Software Engineering', 'Information Technology');

INSERT INTO DEPARTMENT (DEPT_NUMBER, DNAME, FACULTY)
VALUES ('3', 'Networking and Communication Systems', 'Information Technology');

--  2. Insert into LECTURER
-- ====================================================================
INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L001', 'Alice', 'Munyana', TO_DATE('1980-05-15', 'YYYY-MM-DD'), '12 KN St, Kigali', 'alice.m@university.ac.rw', '0788111222', 'F', 1500000, '1'); -- Belongs to Info Mgmt

INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L002', 'Bob', 'Kagame', TO_DATE('1978-11-20', 'YYYY-MM-DD'), '34 KG Ave, Kigali', 'bob.k@university.ac.rw', '0788333444', 'M', 1600000, '2'); -- Belongs to Soft Eng

INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L003', 'Charles', 'Uwase', TO_DATE('1985-01-30', 'YYYY-MM-DD'), '56 KK Rd, Kigali', 'charles.u@university.ac.rw', '0788555666', 'M', 1450000, '3'); -- Belongs to Networking

INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L004', 'Diane', 'Ingabire', TO_DATE('1988-09-05', 'YYYY-MM-DD'), '78 KN St, Kigali', 'diane.i@university.ac.rw', '0788777888', 'F', 1400000, '1'); -- Belongs to Info Mgmt

INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L005', 'Eric', 'Nshimiye', TO_DATE('1995-01-30', 'YYYY-MM-DD'), '97 KK Rd, Kigali', 'eric.u@university.ac.rw', '0799012643', 'M', 2000000, '3'); -- Belongs to Networking

INSERT INTO LECTURER (LECTURER_ID, FIRST_NAME, LAST_NAME, BDATE, ADDRESS, EMAIL, PHONE, SEX, SALARY, DEPT_NUMBER)
VALUES ('L006', 'Danny', 'Ishimwe', TO_DATE('1987-01-30', 'YYYY-MM-DD'), '568 KN Rd, Kigali', 'danny.u@university.ac.rw', '0784567834', 'M', 1800000, '2'); -- Belongs to soft eng


--  3. UPDATE DEPARTMENT to assign HODs
-- ====================================================================
UPDATE DEPARTMENT
SET HOD_ID = 'L001', HOD_START_DATE = TO_DATE('2023-01-15', 'YYYY-MM-DD')
WHERE DEPT_NUMBER = '1'; -- Alice Munyana heads Info Mgmt

UPDATE DEPARTMENT
SET HOD_ID = 'L006', HOD_START_DATE = TO_DATE('2022-08-01', 'YYYY-MM-DD')
WHERE DEPT_NUMBER = '2'; -- Danny Ishimwe heads Soft Eng

UPDATE DEPARTMENT
SET HOD_ID = 'L005', HOD_START_DATE = TO_DATE('2024-02-01', 'YYYY-MM-DD')
WHERE DEPT_NUMBER = '3'; -- Eric Nshimiye  heads Networking


--  4. Insert into STUDENT
-- ====================================================================
INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S001', 'Eve', 'Mutoni', 'F', TO_DATE('2003-03-12', 'YYYY-MM-DD'), 'eve.m@student.university.ac.rw', '0781010101', '101 KK Ave, Kigali', '1'); -- Info Mgmt

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S002', 'Frank', 'Bizimana', 'M', TO_DATE('2002-07-25', 'YYYY-MM-DD'), 'frank.b@student.university.ac.rw', '0782020202', '102 KG Rd, Kigali', '2'); -- Soft Eng

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S003', 'Grace', 'Niwenshuti', 'F', TO_DATE('2004-01-18', 'YYYY-MM-DD'), 'grace.n@student.university.ac.rw', '0783030303', '103 KN St, Kigali', '3'); -- Networking

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S004', 'Henry', 'Gatete', 'M', TO_DATE('2003-09-30', 'YYYY-MM-DD'), 'henry.g@student.university.ac.rw', '0784040404', '104 KG Ave, Kigali', '1'); -- Info Mgmt

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S005', 'Irene', 'Mutesi', 'F', TO_DATE('2002-11-05', 'YYYY-MM-DD'), 'irene.m@student.university.ac.rw', '0785050505', '105 KN St, Kigali', '2'); -- Soft Eng

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S006', 'John', 'Habimana', 'M', TO_DATE('2004-05-22', 'YYYY-MM-DD'), 'john.h@student.university.ac.rw', '0786060606', '106 KK Rd, Kigali', '3'); -- Networking

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S007', 'jack', 'Burera', 'M', TO_DATE('2001-07-30', 'YYYY-MM-DD'), 'jack.b@student.university.ac.rw', '0784080909', '145 KG Ave, Kigali', '1'); -- Info Mgmt

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S008', 'Terry', 'Gatete', 'M', TO_DATE('2002-05-21', 'YYYY-MM-DD'), 'tery.g@student.university.ac.rw', '0785070606', '456 KN St, Kigali', '2'); -- Soft Eng

INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S009', 'Stalon', 'Keza', 'F', TO_DATE('2004-05-15', 'YYYY-MM-DD'), 'stalon.k@student.university.ac.rw', '0786060606', '106 KK Rd, Kigali', '3'); -- Networking



--  5. Insert into COURSE
-- ====================================================================
INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('INSY8222', 'Database Management Systems', 3, 'Fundamentals of relational databases.', '1'); -- Info Mgmt

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('STAT223', 'Probability and Statistics & Reliability', 3, 'Statistical methods and probability theory.', '2'); -- Info Mgmt (or general)

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('SENG325', 'Requirements Engineering', 3, 'Eliciting and managing software requirements.', '2'); -- Soft Eng

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('INSY8211', 'Computer Networks', 4, 'Principles of computer networking.', '3'); -- Networking

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('INSY8212', 'Programming with C', 4, 'Fundamentals of C programming language.', '2'); -- Soft Eng (or general)

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('INSY8311', 'Database development with PL/SQL', 4, 'Advanced database programming using PL/SQL.', '1'); -- Info Mgmt

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER)
VALUES ('MATH8214', 'Multivariable Calculus and ODE', 4, 'Advanced calculus and differential equations.', '2'); -- Soft Eng (or general)

INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('INSY310', 'DATA STRUCTURE AND ALGORITHM', 4, 'FUNDAMENTAL DATA STRUCTURES AND ALGORITHMS', '3');
  
INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('INSY8221', 'OBJECT-ORIENTED PROGRAMMING', 4, 'PRINCIPLES OF OBJECT-ORIENTED PROGRAMMING', '1');
  
INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('INSY8313', 'MANAGEMENT INFORMATION SYSTEMS', 3, 'DESIGN AND IMPLEMENTATION OF MIS', '1');
  
INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('INSY8314', 'WEB DESIGN', 3, 'PRINCIPLES OF WEB DESIGN AND DEVELOPMENT', '2');
  
  INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('INSY8312', 'JAVA PROGRAMMING', 4, 'PROGRAMMING USING JAVA LANGUAGE', '3');
  
INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('SENG8325', 'SOFTWARE TESTING TECHNIQUES', 3, 'METHODS AND TOOLS FOR SOFTWARE TESTING', '2');
  
  INSERT INTO COURSE (COURSE_CODE, TITLE, CREDIT, DESCRIPTION, DEPT_NUMBER) 
  VALUES ('SENG8414', 'SOFTWARE SECURITY', 3, 'PRINCIPLES OF SECURE SOFTWARE DEVELOPMENT', '2');


  --  6. Insert into ENROLLMENT
-- ====================================================================
-- Student S001 enrolling in 2 courses
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00001', 'S001', 'INSY8222', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'ACTIVE');

INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00002', 'S001', 'INSY8311', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'ACTIVE');

-- Student S002 enrollment
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00003', 'S002', 'SENG325', TO_DATE('2024-09-16', 'YYYY-MM-DD'), 'ACTIVE');

-- Student S003 enrollment (completed)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00004', 'S003', 'INSY8211', TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'COMPLETED');

-- Student S004 enrollment (dropped)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00005', 'S004', 'STAT223', TO_DATE('2024-09-18', 'YYYY-MM-DD'), 'DROPPED');

-- Student S005 enrollment
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00006', 'S005', 'INSY8212', TO_DATE('2024-09-19', 'YYYY-MM-DD'), 'ACTIVE');

-- Enroll student S006 (previously not enrolled)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00007', 'S006', 'MATH8214', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers S006 & MATH8214

-- Enroll student S007 (new student)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00008', 'S007', 'INSY310', TO_DATE('2024-09-21', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers S007 & INSY310

-- Enroll student S008 (new student)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00009', 'S008', 'INSY8221', TO_DATE('2024-09-22', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers S008 & INSY8221

-- Enroll student S009 (new student)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00010', 'S009', 'INSY8313', TO_DATE('2024-09-23', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers S009 & INSY8313

-- Enroll student S001 in another course (Web Design)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00011', 'S001', 'INSY8314', TO_DATE('2024-09-24', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers INSY8314

-- Enroll student S002 in another course (Java)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00012', 'S002', 'INSY8312', TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers INSY8312

-- Enroll student S003 in another course (SW Testing)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00013', 'S003', 'SENG8325', TO_DATE('2024-09-26', 'YYYY-MM-DD'), 'ACTIVE'); -- Covers SENG8325

-- Enroll student S005 in another course (SW Security) - completed
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00014', 'S005', 'SENG8414', TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'COMPLETED'); -- Covers SENG8414

-- Enroll student S008 in Statistics (already enrolled in OOP)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00015', 'S008', 'STAT223', TO_DATE('2024-09-22', 'YYYY-MM-DD'), 'ACTIVE'); -- Ensure STAT223 is covered (already done by E5, but good to have more enrollments)

-- Enroll student S009 in Networks (already enrolled in MIS)
INSERT INTO ENROLLMENT (ENROLLMENT_CODE, STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, STATUS)
VALUES ('E00016', 'S009', 'INSY8211', TO_DATE('2024-09-23', 'YYYY-MM-DD'), 'ACTIVE'); -- Ensure INSY8211 covered (already done by E4, but good to have more enrollments)

-- ====================================================================

--  7. Insert into GRADE
-- ====================================================================
-- Grade for Enrollment E00001 (S001 in INSY8222) - Active course, partial grades might exist
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G1', 'E00001', 15.5, NULL, 7.0); -- Exam not done yet

-- Grade for Enrollment E00002 (S001 in INSY8311) - Active course
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G2', 'E00002', 18.0, NULL, 8.5); -- Exam not done yet

-- Grade for Enrollment E00003 (S002 in SENG325) - Active course
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G3', 'E00003', 12.0, NULL, 6.0); -- Exam not done yet

-- Grade for Enrollment E00004 (S003 in INSY8211) - Completed course
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G4', 'E00004', 17.0, 60.5, 9.0); -- FINAL_GRADE will be calculated: (9*0.1 + 60.5*0.7 + 17*0.2) = 0.9 + 42.35 + 3.4 = 46.65

-- Grade for Enrollment E00005 (S004 in STAT223) - Dropped course, might have no grades or partial
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G5', 'E00005', 5.0, NULL, NULL); -- Dropped early

-- Grade for Enrollment E00006 (S005 in INSY8212) - Active course
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G6', 'E00006', 19.5, NULL, 9.5); -- Exam not done yet


--  7. Insert into GRADE
-- Ensure you are connected to the correct PDB before running these inserts
-- Example: ALTER SESSION SET CONTAINER = mon_27088_Mushimire_studentMS_db;

-- ====================================================================
--  Populate GRADE Table (Updated for more complete scores)
-- ====================================================================
-- Note: FINAL_GRADE is a virtual column and will be calculated automatically
--       based on the provided Assignment, Exam, and Quiz scores using the formula:
--       (QUIZ_SCORE*0.1 + EXAM_SCORE*0.7 + ASSIGNMENT_SCORE*0.2)

-- Grade for Enrollment E00001 (S001 in INSY8222) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G1', 'E00001', 15.5, 55.0, 7.0); 
-- Grade for Enrollment E00002 (S001 in INSY8311) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G2', 'E00002', 18.0, 62.5, 8.5); 
-- Grade for Enrollment E00003 (S002 in SENG325) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G3', 'E00003', 12.0, 48.0, 6.0); -- FINAL_GRADE = (6*0.1 + 48*0.7 + 12*0.2) = 0.6 + 33.6 + 2.4 = 36.6

-- Grade for Enrollment E00004 (S003 in INSY8211) - Completed course (As before)
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G4', 'E00004', 17.0, 60.5, 9.0); -- FINAL_GRADE = (9*0.1 + 60.5*0.7 + 17*0.2) = 0.9 + 42.35 + 3.4 = 46.65

-- Grade for Enrollment E00005 (S004 in STAT223) - Dropped course (Keeping as is)
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G5', 'E00005', 5.0, NULL, NULL); -- Dropped early, FINAL_GRADE is NULL

-- Grade for Enrollment E00006 (S005 in INSY8212) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G6', 'E00006', 19.5, 68.0, 9.5); -- FINAL_GRADE = (9.5*0.1 + 68*0.7 + 19.5*0.2) = 0.95 + 47.6 + 3.9 = 52.45

-- Grade for Enrollment E00007 (S006 in MATH8214) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G7', 'E00007', 14.0, 52.0, 7.5); -- FINAL_GRADE = (7.5*0.1 + 52*0.7 + 14*0.2) = 0.75 + 36.4 + 2.8 = 39.95

-- Grade for Enrollment E00008 (S007 in INSY310) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G8', 'E00008', 16.5, 58.0, 8.0); -- FINAL_GRADE = (8*0.1 + 58*0.7 + 16.5*0.2) = 0.8 + 40.6 + 3.3 = 44.7

-- Grade for Enrollment E00009 (S008 in INSY8221) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G9', 'E00009', 17.0, 61.0, 9.0); -- FINAL_GRADE = (9*0.1 + 61*0.7 + 17*0.2) = 0.9 + 42.7 + 3.4 = 47.0

-- Grade for Enrollment E00010 (S009 in INSY8313) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G10', 'E00010', 18.5, 66.0, 8.5); -- FINAL_GRADE = (8.5*0.1 + 66*0.7 + 18.5*0.2) = 0.85 + 46.2 + 3.7 = 50.75

-- Grade for Enrollment E00011 (S001 in INSY8314) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G11', 'E00011', 15.0, 50.0, 7.0); -- FINAL_GRADE = (7*0.1 + 50*0.7 + 15*0.2) = 0.7 + 35.0 + 3.0 = 38.7

-- Grade for Enrollment E00012 (S002 in INSY8312) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G12', 'E00012', 19.0, 69.5, 9.5); -- FINAL_GRADE = (9.5*0.1 + 69.5*0.7 + 19*0.2) = 0.95 + 48.65 + 3.8 = 53.4

-- Grade for Enrollment E00013 (S003 in SENG8325) - Still missing Exam Score (Example of recently active)
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G13', 'E00013', 16.0, NULL, 8.0); -- Exam not done yet, FINAL_GRADE is NULL

-- Grade for Enrollment E00014 (S005 in SENG8414) - Completed (As before)
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G14', 'E00014', 18.0, 65.0, 9.0); -- FINAL_GRADE = (9*0.1 + 65*0.7 + 18*0.2) = 0.9 + 45.5 + 3.6 = 50.0

-- Grade for Enrollment E00015 (S008 in STAT223) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G15', 'E00015', 13.5, 45.0, 6.5); -- FINAL_GRADE = (6.5*0.1 + 45*0.7 + 13.5*0.2) = 0.65 + 31.5 + 2.7 = 34.85

-- Grade for Enrollment E00016 (S009 in INSY8211) - Now with Exam Score
INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G16', 'E00016', 17.5, 59.0, 8.5); -- FINAL_GRADE = (8.5*0.1 + 59*0.7 + 17.5*0.2) = 0.85 + 41.3 + 3.5 = 45.65

-- ====================================================================
-- Payments for each of the 6 students
INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000001', 'S001', 500000, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 'TRANSFER', 'TXN1001ABC');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000002', 'S002', 550000, TO_DATE('2024-09-11', 'YYYY-MM-DD'), 'CREDIT', 'TXN1002DEF');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000003', 'S003', 480000, TO_DATE('2024-09-12', 'YYYY-MM-DD'), 'DEBIT', 'TXN1003GHI');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000004', 'S004', 510000, TO_DATE('2024-09-13', 'YYYY-MM-DD'), 'CASH', 'TXN1004JKL');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000005', 'S005', 530000, TO_DATE('2024-09-14', 'YYYY-MM-DD'), 'TRANSFER', 'TXN1005MNO');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('P0000006', 'S006', 495000, TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'CREDIT', 'TXN1006PQR');


-- Payments for each of the 6 students
INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PERYPDL1', 'S001', 500000, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 'TRANSFER', 'TXN1001ABC');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PRUOFHK2', 'S002', 550000, TO_DATE('2024-09-11', 'YYYY-MM-DD'), 'CREDIT', 'TXN1002DEF');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PXCMJRU3', 'S003', 480000, TO_DATE('2024-09-12', 'YYYY-MM-DD'), 'DEBIT', 'TXN1003GHI');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PWELPFO4', 'S004', 510000, TO_DATE('2024-09-13', 'YYYY-MM-DD'), 'CASH', 'TXN1004JKL');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PRTEOKY5', 'S005', 530000, TO_DATE('2024-09-14', 'YYYY-MM-DD'), 'TRANSFER', 'TXN1005MNO');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PDFGQIH6', 'S006', 495000, TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'CREDIT', 'TXN1006PQR');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PAERTDF7', 'S007', 525000, TO_DATE('2024-09-16', 'YYYY-MM-DD'), 'DEBIT', 'TXN1007STU');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PSDFGCB8', 'S008', 545000, TO_DATE('2024-09-17', 'YYYY-MM-DD'), 'CASH', 'TXN1008VWX');

INSERT INTO PAYMENT (PAYMENT_CODE, STUDENT_ID, AMOUNT, PAYMENT_DATE, METHOD, TRANSACTION_ID)
VALUES ('PFKMOPD9', 'S009', 490000, TO_DATE('2024-09-18', 'YYYY-MM-DD'), 'TRANSFER', 'TXN1009YZA');

SELECT * FROM STUDENT;

-- Verify DEPARTMENT table
SELECT * FROM DEPARTMENT;

-- Verify COURSE table
SELECT * FROM COURSE;

-- Verify INSTRUCTOR table
SELECT * FROM LECTURER;


-- Verify ENROLLMENT table
SELECT * FROM ENROLLMENT;

-- Verify GRADE table (after fixing the GRADE_CODE issue)
SELECT * FROM GRADE;

SELECT * FROM PAYMENT;
UPDATE COURSE
SET DESCRIPTION = 'Comprehensive study of relational database design, SQL, and management.'
WHERE COURSE_CODE = 'INSY8222';

UPDATE LECTURER
SET SALARY = SALARY * 1.10  -- Increase salary by 10%
WHERE LECTURER_ID = 'L002';


-- Ensure you are connected to the correct PDB
-- Example: ALTER SESSION SET CONTAINER = mon_27088_Mushimire_studentMS_db;

CREATE OR REPLACE PACKAGE SIMS_Audit_Pkg IS

    PROCEDURE Log_DML_Attempt (
        p_target_table  IN VARCHAR2,
        p_dml_type      IN VARCHAR2,
        p_action_status IN VARCHAR2,
        p_row_key_info  IN VARCHAR2 DEFAULT NULL,
        p_error_message IN VARCHAR2 DEFAULT NULL
    );

END SIMS_Audit_Pkg;
/


CREATE OR REPLACE PACKAGE BODY SIMS_Audit_Pkg IS

    PROCEDURE Log_DML_Attempt (
        p_target_table  IN VARCHAR2,
        p_dml_type      IN VARCHAR2,
        p_action_status IN VARCHAR2,
        p_row_key_info  IN VARCHAR2 DEFAULT NULL,
        p_error_message IN VARCHAR2 DEFAULT NULL
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- Ensures this procedure commits independently
    BEGIN
        INSERT INTO SIMS_AUDIT_LOG (
            TARGET_TABLE_NAME,
            DML_TYPE,
            ACTION_STATUS,
            ROW_KEY_INFO,
            ERROR_MESSAGE,
            CLIENT_INFO
        ) VALUES (
            UPPER(p_target_table),
            UPPER(p_dml_type),
            UPPER(p_action_status),
            p_row_key_info,
            p_error_message,
            SYS_CONTEXT('USERENV', 'CLIENT_INFO')
        );
        COMMIT; -- Commit the autonomous transaction for the audit log
    EXCEPTION
        WHEN OTHERS THEN
            -- In a production system, you might write to DBMS_OUTPUT or an alert log.
            -- Avoid raising an exception here to prevent the main transaction from failing
            -- solely due to an audit log issue, unless audit logging is absolutely critical.
            -- For now, we'll let it be. If the INSERT fails, the audit record isn't written.
            NULL;
            -- Consider alternative logging for audit failure, e.g., DBMS_ALERT.
    END Log_DML_Attempt;

END SIMS_Audit_Pkg;
/

CREATE OR REPLACE TRIGGER TRG_Restrict_DML_STUDENT
BEFORE INSERT OR UPDATE OR DELETE ON STUDENT
DECLARE
    v_dml_type VARCHAR2(10);
    v_error_msg VARCHAR2(200) := 'Data manipulation on STUDENT table is not allowed at this time (restricted weekday or an upcoming month''s public holiday).';
BEGIN
    -- Determine DML type
    IF INSERTING THEN
        v_dml_type := 'INSERT';
    ELSIF UPDATING THEN
        v_dml_type := 'UPDATE';
    ELSIF DELETING THEN
        v_dml_type := 'DELETE';
    END IF;

    IF NOT SIMS_Security_Pkg.Is_DML_Allowed THEN
        -- Log the DENIED attempt
        SIMS_Audit_Pkg.Log_DML_Attempt(
            p_target_table  => 'STUDENT',
            p_dml_type      => v_dml_type,
            p_action_status => 'DENIED',
            p_error_message => v_error_msg
        );
        -- Raise the application error to prevent the DML
        RAISE_APPLICATION_ERROR(-20001, v_error_msg);
    ELSE
        -- Optionally log ALLOWED attempts for statement-level actions here if desired
        -- For this example, we will focus on logging denied attempts in this trigger
        -- and log specific data changes with separate AFTER ROW triggers (see next step).
        NULL;
    END IF;
END TRG_Restrict_DML_STUDENT;
/


CREATE OR REPLACE TRIGGER TRG_Audit_Grade_Changes
AFTER INSERT OR UPDATE OR DELETE ON GRADE
FOR EACH ROW
DECLARE
    v_dml_type      VARCHAR2(10);
    v_row_key_info  VARCHAR2(255);
    v_change_details VARCHAR2(4000); -- To store details about what changed for UPDATE
BEGIN
    IF INSERTING THEN
        v_dml_type := 'INSERT';
        v_row_key_info := 'GRADE_CODE=' || :NEW.GRADE_CODE;
        v_change_details := 'New Scores: ASGN=' || :NEW.ASSIGNMENT_SCORE ||
                            ', EXAM=' || :NEW.EXAM_SCORE || ', QUIZ=' || :NEW.QUIZ_SCORE;

    ELSIF UPDATING THEN
        v_dml_type := 'UPDATE';
        v_row_key_info := 'GRADE_CODE=' || :NEW.GRADE_CODE;
        v_change_details := 'Old Scores: ASGN=' || :OLD.ASSIGNMENT_SCORE ||
                            ', EXAM=' || :OLD.EXAM_SCORE || ', QUIZ=' || :OLD.QUIZ_SCORE ||
                            ' -> New Scores: ASGN=' || :NEW.ASSIGNMENT_SCORE ||
                            ', EXAM=' || :NEW.EXAM_SCORE || ', QUIZ=' || :NEW.QUIZ_SCORE;
        -- Only log if a relevant score actually changed
        IF :OLD.ASSIGNMENT_SCORE = :NEW.ASSIGNMENT_SCORE AND
           :OLD.EXAM_SCORE = :NEW.EXAM_SCORE AND
           :OLD.QUIZ_SCORE = :NEW.QUIZ_SCORE THEN
            RETURN; -- No change in scores, so don't log (or log minimal info)
        END IF;

    ELSIF DELETING THEN
        v_dml_type := 'DELETE';
        v_row_key_info := 'GRADE_CODE=' || :OLD.GRADE_CODE;
        v_change_details := 'Deleted Scores: ASGN=' || :OLD.ASSIGNMENT_SCORE ||
                            ', EXAM=' || :OLD.EXAM_SCORE || ', QUIZ=' || :OLD.QUIZ_SCORE;
    END IF;

    SIMS_Audit_Pkg.Log_DML_Attempt(
        p_target_table  => 'GRADE',
        p_dml_type      => v_dml_type,
        p_action_status => 'ALLOWED', -- This trigger fires after successful DML
        p_row_key_info  => v_row_key_info,
        p_error_message => v_change_details -- Using error_message to store change details
    );

EXCEPTION
    WHEN OTHERS THEN
        -- Log the error from the audit trigger itself (e.g., to a separate error log or using DBMS_OUTPUT for debug)
        -- To prevent the main DML from failing due to an audit trigger error.
        DBMS_OUTPUT.PUT_LINE('Error in TRG_Audit_Grade_Changes: ' || SQLERRM);
        -- In a production system, you might want to alert an administrator here.
END TRG_Audit_Grade_Changes;
/
 
 -- Current date is Thursday, May 15, 2025 (a weekday)
INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, PHONE, ADDRESS, DEPT_NUMBER)
VALUES ('S999', 'Test', 'DeniedUser', 'O', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 'denied.user@example.com', '0780000999', '1 Test Rd', '1');

SELECT USERNAME, ACTION_TIMESTAMP, TARGET_TABLE_NAME, DML_TYPE, ACTION_STATUS, ERROR_MESSAGE
FROM SIMS_AUDIT_LOG
ORDER BY ACTION_TIMESTAMP DESC;



CREATE OR REPLACE PACKAGE SIMS_Security_Pkg IS

    -- Function to check if DML operations are allowed based on day and holidays
    -- Returns TRUE if DML is allowed, FALSE otherwise.
    FUNCTION Is_DML_Allowed RETURN BOOLEAN;

END SIMS_Security_Pkg;
/


-- Temporary modification in SIMS_Security_Pkg BODY
CREATE OR REPLACE PACKAGE BODY SIMS_Security_Pkg IS
    FUNCTION Is_DML_Allowed RETURN BOOLEAN IS
        -- ... original declarations ...
    BEGIN
        RETURN TRUE; -- << TEMPORARY CHANGE FOR TESTING ALLOWED DML
        -- ... rest of original logic commented out or removed for the test ...
    END Is_DML_Allowed;
END SIMS_Security_Pkg;
/





INSERT INTO GRADE (GRADE_CODE, ENROLLMENT_CODE, ASSIGNMENT_SCORE, EXAM_SCORE, QUIZ_SCORE)
VALUES ('G12', 'E00001', 17.0, 65.0, 9.0);

UPDATE GRADE
SET GRADE_CODE = 10,
 ENROLLMENT_CODE = 'E00010'
WHERE GRADE_CODE = 'G99';

DELETE FROM GRADE
WHERE GRADE_CODE = 'G12';

SELECT * FROM SIMS_AUDIT_LOG;





