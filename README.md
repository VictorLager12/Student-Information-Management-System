# Student Information Management System (SIMS) - Phase I

## Project Description

This project focuses on the development of a Student Information Management System (SIMS) using PL/SQL with an Oracle database. The primary goal of Phase I is to lay the foundation for a system designed to streamline and automate critical academic operations within universities, addressing the challenges associated with manual data management. This phase covers the initial design, definition of core entities, and outlining the system's architecture and anticipated benefits.

## Problem Definition

### Issue
Universities often rely on manual processes for managing essential student data, course enrollments, and academic records. These processes are often:
* ⏳ **Time-consuming**
* ❌ **Error-prone**
* 📉 **Inefficient**
* Resulting in delays, inaccuracies, and redundant data entries.

### Impact
Manual data management leads to significant negative consequences:
* 📊 **Poor data quality**
* ♻️ **Duplication of efforts**
* 💸 **Ineffective resource allocation**
* 🚧 **Hindered overall efficiency** of academic operations

## Context

* **Where:** The SIMS is intended for implementation within university settings to manage student-related academic operations.
* **How:** The system aims to automate key workflows, including student enrollment, grade calculation, timetable generation, and transcript management. It will serve as a centralized platform for students, lecturers, and administrators to access and manage academic information.

## Target Users

* **Students:** Will use the system to enroll in courses, view their grades, and access academic timetables.
* **Lecturers:** Will utilize the system for managing courses, assessing student performance, and tracking academic progress.
* **Administrators:** Will oversee academic operations, generate necessary reports, and ensure compliance with university regulations.

## Phase I Project Goals

* **Automate Workflows:** Begin streamlining processes like enrollment, grade tracking, and timetable generation.
* **Improve Accuracy:** Lay the groundwork to minimize errors in student data and academic records.
* **Enhance Data Security:** Define mechanisms for secure storage and management of sensitive student information.
* **Reduce Data Duplication:** Establish a structure to eliminate redundant data entries and ensure a single source of truth.
* **Provide Real-Time Access:** Design the system to enable students, lecturers, and administrators to access up-to-date information.

## Core Entities and Relationships (Phase I Design)

The SIMS architecture is built upon several interconnected core entities:

* **Students:** Enrolled individuals belonging to Departments, taking Courses via Enrollments, and making Payments.
* **Lecturers:** Academic staff belonging to Departments and teaching Courses.
* **Courses:** Subjects offered by Departments, taught by Lecturers, and enrolled by Students. Assessed via Grades.
* **Departments:** Academic units housing Students, Lecturers, and Courses.
* **Enrollments:** Link Students to specific Courses.
* **Grades:** Track student performance in Courses (including assignment, exam, and attendance scores).
* **Payments:** Records of tuition fees and other financial transactions made by Students.

These entities are linked through defined relationships to ensure data integrity and support efficient data querying.

## Anticipated Benefits 

The SIMS aims to offer a range of benefits by reducing manual effort and minimizing errors:

* ⚙️ **Efficiency:** Streamlines academic operations and reduces manual effort.
* ✅ **Accuracy:** Minimizes errors in student data and academic records.
* 🔍 **Transparency:** Provides clear and accessible information to students and lecturers.
* 📈 **Scalability:** Supports growing numbers of students and courses.
* 🔒 **Data Security:** Ensures secure storage and management of sensitive student and academic data, reducing the risk of data breaches.

---


# Phase II: Business Process Modeling (Management Information Systems - MIS)

## Objective

The primary goal of this phase is to model a business process relevant to Management Information Systems (MIS). This involves visualizing how information flows within the target system, detailing the interactions between different entities (actors, departments, systems), and illustrating how the MIS supports decision-making throughout the process. The specific process modeled is related to student course enrollment and subsequent fee processing within an academic institution's MIS.

---

## Tasks and Deliverables

### 1. Define the Scope

* **Business Process Modeled:**
    * The diagrams model the **Student Course Enrollment and Fee Payment Process**. It starts with the initiation of course enrollment and covers eligibility checks, course selection, validation, record updates, fee calculation, payment processing, and status updates, including handling unsuccessful paths or errors.
    * This process is highly relevant to MIS as it involves managing core student academic and financial data, automating workflows, ensuring data integrity across different modules (e.g., registration, finance), and providing status information to stakeholders (students, administrators).

* **Process Relevance to MIS:**
    * The process relies on an MIS (Student Information System - SIMS) to:
        * Check student eligibility based on existing records.
        * Validate course selections against prerequisites and available quotas.
        * Update student enrollment records and potentially generate timetables.
        * Calculate tuition fees based on enrollment.
        * Track payment status.
        * Manage student academic/financial holds.
        * Provide notifications and display status/error messages.

* **Objectives and Expected Outcomes:**
    * **Objectives:** To efficiently and accurately process student course enrollments, validate eligibility and course selections, update academic records, calculate and process tuition fees, and manage student enrollment status.
    * **Expected Outcomes:**
        * Successful enrollment of eligible students in selected courses.
        * Accurate and updated student academic records (enrollments, timetables).
        * Correct calculation and notification of tuition fees.
        * Efficient processing of student payments.
        * Clear communication of enrollment status, errors, or holds to students.
        * Reduced manual effort and errors compared to non-MIS processes.


### 2. Identify Key Entities

## Key Entities

| Entity | Role | BPMN Mapping |
|--------|------|--------------|
| **Student** | Initiates registration, takes exams | "Student Examined (Support)/Hands" |
| **Academic Hub** | Validates skills mastery | "Headup Course Examination" |
| **Finance System** | Processes certification fees | "Follow Foss Payment" path |
| **Notification Service** | Alerts on deadlines/results | "Notify Blower of Foss Due" |

### 4. Apply BPMN Notations and ensure a Logical Flow

![BPMN](<PhaseI to VII screenshots/phaseI.png>)



# Phase III: Database Schema Documentation

## 1. Introduction

This document details the conceptual database schema for the Student Information Management System (SIMS). The goal of this schema is to provide a structured, reliable, and efficient foundation for managing student-related academic and administrative data, thereby streamlining university operations as outlined in the system's objectives. This schema defines the core entities, their attributes, and the relationships between them, ensuring data integrity and supporting the various functionalities of the SIMS.



## 2. Entity-Relationship (ER) Model:
![er model](<PhaseI to VII screenshots/phase_III.png>)


## 3. Core Entities and Relationships

The database schema is composed of the following key entities, representing the main components of the university's academic structure:

* **`STUDENT`**
    * **Purpose:** Represents individual students enrolled in the university.
    * **Attributes:** `student_id` (PK - Unique Identifier), `first_name`, `last_name`, `sex`, `date_of_birth`, `email`, `phone`, `address`.
    * **Links:** Belongs to one `DEPARTMENT` (via `dept_number` FK).

* **`DEPARTMENT`**
    * **Purpose:** Represents academic departments within the university.
    * **Attributes:** `dept_number` (PK - Unique Identifier), `dname` (Department Name), `campus`.
    * **Links:** Headed by one `LECTURER` (via `HOD_ID` FK), associated with multiple `STUDENT`s, `LECTURER`s, and `COURSE`s.

* **`COURSE`**
    * **Purpose:** Represents academic courses offered by departments.
    * **Attributes:** `course_code` (PK - Unique Identifier), `title`, `credit`, `description`.
    * **Links:** Offered by one `DEPARTMENT` (via `dept_number` FK), can be taught by `LECTURER`s, and enrolled in by `STUDENT`s (via `ENROLLMENT`).

* **`LECTURER`**
    * **Purpose:** Represents academic staff responsible for teaching courses.
    * **Attributes:** `lecturer_id` (PK - Unique Identifier), `first_name`, `last_name`, `email`, `phone`, `salary`.
    * **Links:** Assigned to many `DEPARTMENT` (via `dept_number` FK), can teach multiple `COURSE`s. One lecturer can be assigned as Head of Department (`HOD_ID` in `DEPARTMENT`).

* **`ENROLLMENT`**
    * **Purpose:** Represents the registration of a specific `STUDENT` in a specific `COURSE` for a given period. This acts as a linking table between `STUDENT` and `COURSE`.
    * **Attributes:** `enrollment_code` (PK - Unique Identifier), `enrollment_date`, `status`.
    * **Links:** Connects one `STUDENT` (via `student_id` FK) to many `COURSEs` (via `course_code` FK). Each enrollment results in one `GRADE` record.

* **`GRADE`**
    * **Purpose:** Records the academic performance assessment for a student's enrollment in a course.
    * **Attributes:** `grade_code` (PK - Unique Identifier), `assignment_score`, `exam_score`, `attendance_score`, `final_grade`.
    * **Links:** Directly associated with  `ENROLLMENT` record (via `enrollment_code` FK).

* **`PAYMENT`**
    * **Purpose:** Tracks financial transactions made by students for tuition or other fees.
    * **Attributes:** `payment_code` (PK - Unique Identifier), `amount`, `payment_date`, `method`, `transaction_id`.
    * **Links:** Associated with one `STUDENT` (via `student_id` FK).

    

# Phase IV: Database (Pluggable Database) Creation and Naming    

## 1.Creating and connecting to (Pluggable Database)

![pdb_creation](<PhaseI to VII screenshots/pdb_creation.PNG>)

![connecting_user](<PhaseI to VII screenshots/creating&connectng user.PNG>)

![user_vscode](<PhaseI to VII screenshots/connecting_user_to_vscode.PNG>)

## 2.Oracle Enterprise Manager (OEM) set up

![OEM](<PhaseI to VII screenshots/OEM_SETUP.PNG>)

# Phase V: Table Implementation and Data Insertion

##  Table Creation and Data Insertion
*Table Creation and Data Insertion code can be found in Table Creation and Data Insertion.sql*

**1.DEPARTMENT TABLE**
 ![alt text](<PhaseI to VII screenshots/DEPARTMENT_TABLE.PNG>)


**2.ENROLLMENT TABLE**
 ![alt text](<PhaseI to VII screenshots/ENROLLMENT_TABLE.PNG>)

**3.GRADE TABLE**
 ![alt text](<PhaseI to VII screenshots/GRADE_TABLE.PNG>)

**4.LECTURER TABLE**
![alt text](<PhaseI to VII screenshots/LECTURER_TABLE.PNG>)

**5.PAYMENT TABLE**
![alt text](<PhaseI to VII screenshots/PAYMENT_TABLE.PNG>)

**6.STUDENT TABLE**
![alt text](<PhaseI to VII screenshots/STUDENT_TABLE.PNG>)

**7.COURSE TABLE**
![alt text](<PhaseI to VII screenshots/COURSE_TABLE.PNG>)



# Phase VI: Database Interaction and Transactions

## Tasks and Deliverables
## 1. Database Operations:
**▪ Perform DML (Data Manipulation Language)**
```SQL
 UPDATE COURSE
SET DESCRIPTION = 'Comprehensive study of relational database design, SQL, and management.'
WHERE COURSE_CODE = 'INSY8222';

```
![alt text](<PhaseI to VII screenshots/update_course.PNG>)

```sql
UPDATE LECTURER
SET SALARY = SALARY * 1.10  -- Increase salary by 10%
WHERE LECTURER_ID = 'L002';
```
![alt text](<PhaseI to VII screenshots/update_lecturer.PNG>)

note: DDL operations already implemented during table creation

## 2. Task Requirements:

**Problem Description:**
The university administration wants to understand how students are performing academically within each department. Specifically, they need a report that ranks students within their respective departments based on their average final grade. This will help identify top-performing students in each academic area and potentially students who might need additional support. university administration also want to know course popularity among students such that they can know courses that interests students more than others.

**Window functions analysis**
```sql
WITH StudentAverageGrades AS (
    -- Step 1: Calculate average final grade for each student.
    -- We only consider enrollments where a FINAL_GRADE is not NULL,
    -- implying the grading components were complete enough for the virtual column to calculate.
    SELECT
        S.STUDENT_ID,
        S.FIRST_NAME,
        S.LAST_NAME,
        S.DEPT_NUMBER, -- To link with DEPARTMENT table later
        AVG(G.FINAL_GRADE) AS AVG_FINAL_GRADE
    FROM
        STUDENT S
    JOIN
        ENROLLMENT E ON S.STUDENT_ID = E.STUDENT_ID
    JOIN
        GRADE G ON E.ENROLLMENT_CODE = G.ENROLLMENT_CODE
    WHERE
        G.FINAL_GRADE IS NOT NULL -- Ensure we only average actual calculated final grades
        -- Optional: You might also want to filter by E.STATUS = 'COMPLETED'
        -- if only officially completed enrollments should count towards this ranking.
        -- For example: AND E.STATUS = 'COMPLETED'
    GROUP BY
        S.STUDENT_ID,
        S.FIRST_NAME,
        S.LAST_NAME,
        S.DEPT_NUMBER
),
RankedStudentsByDepartment AS (
    -- Step 2: Join with Department information and apply the ranking.
    SELECT
        SAG.STUDENT_ID,
        SAG.FIRST_NAME,
        SAG.LAST_NAME,
        D.DNAME AS DEPARTMENT_NAME, -- Using DNAME for Department Name
        SAG.AVG_FINAL_GRADE,
        RANK() OVER (PARTITION BY D.DNAME ORDER BY SAG.AVG_FINAL_GRADE DESC) AS DEPT_RANK
        -- You could also use DENSE_RANK() if you don't want gaps in ranks for ties:
        -- DENSE_RANK() OVER (PARTITION BY D.DNAME ORDER BY SAG.AVG_FINAL_GRADE DESC) AS DEPT_DENSE_RANK
    FROM
        StudentAverageGrades SAG
    JOIN
        DEPARTMENT D ON SAG.DEPT_NUMBER = D.DEPT_NUMBER
)
-- Step 3: Final selection and ordering for the report.
SELECT
    STUDENT_ID,
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_NAME,
    ROUND(AVG_FINAL_GRADE, 2) AS AVG_FINAL_GRADE, -- Rounding for cleaner presentation
    DEPT_RANK
FROM
    RankedStudentsByDepartment
ORDER BY
    DEPARTMENT_NAME ASC, -- Group results by department
    DEPT_RANK ASC;       -- Show top-ranked students first within each department
```    
![alt text](<PhaseI to VII screenshots/grade_report.PNG>)

```sql
SELECT 
    c.COURSE_CODE,
    c.TITLE,
    COUNT(e.ENROLLMENT_CODE) AS ENROLLMENT_COUNT,
    ROUND(AVG(g.FINAL_GRADE), 2) AS AVG_GRADE,
    RANK() OVER (ORDER BY COUNT(e.ENROLLMENT_CODE) DESC) AS POPULARITY_RANK
FROM 
    COURSE c
LEFT JOIN 
    ENROLLMENT e ON c.COURSE_CODE = e.COURSE_CODE
LEFT JOIN 
    GRADE g ON e.ENROLLMENT_CODE = g.ENROLLMENT_CODE
GROUP BY 
    c.COURSE_CODE, c.TITLE
ORDER BY 
    POPULARITY_RANK;
```
![alt text](<PhaseI to VII screenshots/course_popularity.PNG>)


## Procedures and Functions:
**1.Procedures and Functions implementation**
```sql
CREATE OR REPLACE PROCEDURE Get_Student_Details (
    p_student_id IN STUDENT.STUDENT_ID%TYPE
)
IS
    v_first_name    STUDENT.FIRST_NAME%TYPE;
    v_last_name     STUDENT.LAST_NAME%TYPE;
    v_email         STUDENT.EMAIL%TYPE;
    v_phone         STUDENT.PHONE%TYPE;
    v_dept_number   STUDENT.DEPT_NUMBER%TYPE;
    v_dname         DEPARTMENT.DNAME%TYPE;
BEGIN
    -- Fetch student basic details
    SELECT
        S.FIRST_NAME,
        S.LAST_NAME,
        S.EMAIL,
        S.PHONE,
        S.DEPT_NUMBER
    INTO
        v_first_name,
        v_last_name,
        v_email,
        v_phone,
        v_dept_number
    FROM
        STUDENT S
    WHERE
        S.STUDENT_ID = p_student_id;

    -- Fetch department name based on dept_number from student
    IF v_dept_number IS NOT NULL THEN
        SELECT
            D.DNAME
        INTO
            v_dname
        FROM
            DEPARTMENT D
        WHERE
            D.DEPT_NUMBER = v_dept_number;
    ELSE
        v_dname := 'N/A'; -- Or handle as per requirements
    END IF;

    -- Display the details
    DBMS_OUTPUT.PUT_LINE('Student Details for ID: ' || p_student_id);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || NVL(v_email, 'N/A'));
    DBMS_OUTPUT.PUT_LINE('Phone: ' || NVL(v_phone, 'N/A'));
    DBMS_OUTPUT.PUT_LINE('Department: ' || NVL(v_dname, 'N/A'));
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Student with ID ' || p_student_id || ' not found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Multiple records found for student ID ' || p_student_id || '. This should not happen for a primary key lookup.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END Get_Student_Details;
/
```
```sql
-- Test Case 1: Valid Student ID
BEGIN
    Get_Student_Details('S001'); -- Assuming S001 exists
END;
/
```
![alt text](<PhaseI to VII screenshots/valid_student.PNG>)

```sql
-- Test Case 2: Non-existent Student ID
BEGIN
    Get_Student_Details('S999'); -- Assuming S999 does not exist
END;
/
```
![alt text](<PhaseI to VII screenshots/id_notfound.PNG>)

```sql
CREATE OR REPLACE PROCEDURE List_Courses_By_Department (
    p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
)
IS
    -- Explicit cursor declaration
    CURSOR c_courses IS
        SELECT
            C.COURSE_CODE,
            C.TITLE,
            C.CREDIT,
            D.DNAME AS DEPARTMENT_NAME -- Include Department Name for context
        FROM
            COURSE C
        JOIN
            DEPARTMENT D ON C.DEPT_NUMBER = D.DEPT_NUMBER
        WHERE
            C.DEPT_NUMBER = p_dept_number;

    v_course_code   COURSE.COURSE_CODE%TYPE;
    v_title         COURSE.TITLE%TYPE;
    v_credit        COURSE.CREDIT%TYPE;
    v_dname         DEPARTMENT.DNAME%TYPE;
    v_found_courses BOOLEAN := FALSE; -- Flag to check if any courses were found

BEGIN
    -- Attempt to fetch department name once to validate p_dept_number
    -- and to display it as a header.
    BEGIN
        SELECT DNAME INTO v_dname FROM DEPARTMENT WHERE DEPT_NUMBER = p_dept_number;
        DBMS_OUTPUT.PUT_LINE('Courses for Department: ' || v_dname || ' (ID: ' || p_dept_number || ')');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Department with ID ' || p_dept_number || ' not found.');
            RETURN; -- Exit if department not found
    END;

    -- Open the cursor
    OPEN c_courses;

    -- Loop through the fetched rows
    LOOP
        FETCH c_courses INTO v_course_code, v_title, v_credit, v_dname; -- v_dname is re-fetched here for completeness inside loop, though already fetched above
        EXIT WHEN c_courses%NOTFOUND; -- Exit loop if no more rows

        v_found_courses := TRUE; -- Set flag to true as at least one course is found
        DBMS_OUTPUT.PUT_LINE('Code: ' || v_course_code || ', Title: ' || v_title || ', Credits: ' || v_credit);
    END LOOP;

    -- Close the cursor
    CLOSE c_courses;

    IF NOT v_found_courses THEN
        DBMS_OUTPUT.PUT_LINE('No courses found for this department.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');

EXCEPTION
    WHEN OTHERS THEN
        IF c_courses%ISOPEN THEN
            CLOSE c_courses; -- Ensure cursor is closed in case of error during fetch
        END IF;
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END List_Courses_By_Department;
/
```
```sql
-- Test Case 1: Valid Department ID with courses
BEGIN
    List_Courses_By_Department('1'); -- Assuming Department '1' exists and has courses
END;
/
```
![alt text](<PhaseI to VII screenshots/valid_Did.PNG>)

```sql
-- Test Case 3: Non-existent Department ID
BEGIN
    List_Courses_By_Department('9'); -- Assuming Department '9' does not exist
END;
/
```
![alt text](<PhaseI to VII screenshots/invalid_Did.PNG>)

```sql
CREATE OR REPLACE FUNCTION Get_Student_Count_By_Dept (
    p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
)
RETURN NUMBER
IS
    v_student_count NUMBER;
    v_dept_exists   NUMBER;
BEGIN
    -- Check if department exists to provide a more specific error
    -- rather than just returning 0 if department is invalid
    SELECT COUNT(*) INTO v_dept_exists FROM DEPARTMENT WHERE DEPT_NUMBER = p_dept_number;

    IF v_dept_exists = 0 THEN
        -- Raise a custom exception or return a specific value like -1 or NULL
        -- For simplicity, let's raise an application error.
        RAISE_APPLICATION_ERROR(-20001, 'Department ID ' || p_dept_number || ' does not exist.');
    END IF;

    -- Count students in the specified department
    SELECT
        COUNT(*)
    INTO
        v_student_count
    FROM
        STUDENT S
    WHERE
        S.DEPT_NUMBER = p_dept_number;

    RETURN v_student_count;

EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or re-raise. For simplicity, returning NULL or a specific error code.
        -- For a function, DBMS_OUTPUT might not be visible to the calling SQL.
        -- Consider logging to a table or returning an error indicator.
        -- For this example, let's re-raise to show exception propagation if not handled inside.
        -- Or return NULL if that's how you want to signal an error from a function to SQL.
        DBMS_OUTPUT.PUT_LINE('Error in Get_Student_Count_By_Dept: ' || SQLERRM); -- For debugging if called from PL/SQL
        RETURN NULL; -- Or RAISE; to propagate the original error
END Get_Student_Count_By_Dept;
/
```
```sql
-- Test Case 1: Valid Department ID (using anonymous block)
DECLARE
    v_count NUMBER;
BEGIN
    v_count := Get_Student_Count_By_Dept('1'); -- Assuming Dept '1' exists
    IF v_count IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Student count for department 1: ' || v_count);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error occurred or department not found for department 1.');
    END IF;
END;
/
```
![alt text](<PhaseI to VII screenshots/valid_stuC.PNG>)

```sql
-- Test Case 2: Valid Department ID (using SELECT statement)
SELECT Get_Student_Count_By_Dept('2') AS Student_Count_Dept2 FROM DUAL; -- Assuming Dept '2' exists

-- Test Case 3: Non-existent Department ID
DECLARE
    v_count NUMBER;
BEGIN
    v_count := Get_Student_Count_By_Dept('3'); -- Assuming Dept '9' does not exist
    IF v_count IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Student count for department 3: ' || v_count);
    ELSE
         DBMS_OUTPUT.PUT_LINE('Function call for department 3 handled an error or returned NULL.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught exception from function call: ' || SQLERRM);
END;
/
```
![alt text](<PhaseI to VII screenshots/valid_by_select.PNG>)

```sql
SELECT Get_Student_Count_By_Dept('9') AS Student_Count_Dept9_Error FROM DUAL;
```
![alt text](<PhaseI to VII screenshots/error_f.PNG>)


## Apply Packages:

**1. Create the Package Specification**

```sql
CREATE OR REPLACE PACKAGE SIMS_Query_Pkg IS

    -- Procedure to fetch and display details for a specific student
    PROCEDURE Get_Student_Details (
        p_student_id IN STUDENT.STUDENT_ID%TYPE
    );

    -- Procedure to list all courses offered by a specific department
    PROCEDURE List_Courses_By_Department (
        p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
    );

    -- Function to get the total number of students in a specific department
    FUNCTION Get_Student_Count_By_Dept (
        p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
    ) RETURN NUMBER;

END SIMS_Query_Pkg;
/
```
***2. Create the Package Body***

```sql
CREATE OR REPLACE PACKAGE BODY SIMS_Query_Pkg IS

    -- Procedure to fetch and display details for a specific student
    PROCEDURE Get_Student_Details (
        p_student_id IN STUDENT.STUDENT_ID%TYPE
    )
    IS
        v_first_name    STUDENT.FIRST_NAME%TYPE;
        v_last_name     STUDENT.LAST_NAME%TYPE;
        v_email         STUDENT.EMAIL%TYPE;
        v_phone         STUDENT.PHONE%TYPE;
        v_dept_number   STUDENT.DEPT_NUMBER%TYPE;
        v_dname         DEPARTMENT.DNAME%TYPE;
    BEGIN
        -- Fetch student basic details
        SELECT
            S.FIRST_NAME,
            S.LAST_NAME,
            S.EMAIL,
            S.PHONE,
            S.DEPT_NUMBER
        INTO
            v_first_name,
            v_last_name,
            v_email,
            v_phone,
            v_dept_number
        FROM
            STUDENT S
        WHERE
            S.STUDENT_ID = p_student_id;

        -- Fetch department name
        IF v_dept_number IS NOT NULL THEN
            SELECT
                D.DNAME
            INTO
                v_dname
            FROM
                DEPARTMENT D
            WHERE
                D.DEPT_NUMBER = v_dept_number;
        ELSE
            v_dname := 'N/A';
        END IF;

        DBMS_OUTPUT.PUT_LINE('Student Details for ID: ' || p_student_id);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || NVL(v_email, 'N/A'));
        DBMS_OUTPUT.PUT_LINE('Phone: ' || NVL(v_phone, 'N/A'));
        DBMS_OUTPUT.PUT_LINE('Department: ' || NVL(v_dname, 'N/A'));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Student with ID ' || p_student_id || ' or their department not found.');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Error: Multiple records found. Data integrity issue.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An unexpected error occurred in Get_Student_Details: ' || SQLERRM);
    END Get_Student_Details;


    -- Procedure to list all courses offered by a specific department
    PROCEDURE List_Courses_By_Department (
        p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
    )
    IS
        CURSOR c_courses IS
            SELECT
                C.COURSE_CODE,
                C.TITLE,
                C.CREDIT
            FROM
                COURSE C
            WHERE
                C.DEPT_NUMBER = p_dept_number;

        v_course_code   COURSE.COURSE_CODE%TYPE;
        v_title         COURSE.TITLE%TYPE;
        v_credit        COURSE.CREDIT%TYPE;
        v_dname         DEPARTMENT.DNAME%TYPE;
        v_found_courses BOOLEAN := FALSE;
    BEGIN
        BEGIN
            SELECT DNAME INTO v_dname FROM DEPARTMENT WHERE DEPT_NUMBER = p_dept_number;
            DBMS_OUTPUT.PUT_LINE('Courses for Department: ' || v_dname || ' (ID: ' || p_dept_number || ')');
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Error: Department with ID ' || p_dept_number || ' not found.');
                RETURN;
        END;

        OPEN c_courses;
        LOOP
            FETCH c_courses INTO v_course_code, v_title, v_credit;
            EXIT WHEN c_courses%NOTFOUND;
            v_found_courses := TRUE;
            DBMS_OUTPUT.PUT_LINE('Code: ' || v_course_code || ', Title: ' || v_title || ', Credits: ' || v_credit);
        END LOOP;
        CLOSE c_courses;

        IF NOT v_found_courses THEN
            DBMS_OUTPUT.PUT_LINE('No courses found for this department.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');

    EXCEPTION
        WHEN OTHERS THEN
            IF c_courses%ISOPEN THEN
                CLOSE c_courses;
            END IF;
            DBMS_OUTPUT.PUT_LINE('An unexpected error occurred in List_Courses_By_Department: ' || SQLERRM);
    END List_Courses_By_Department;


    -- Function to get the total number of students in a specific department
    FUNCTION Get_Student_Count_By_Dept (
        p_dept_number IN DEPARTMENT.DEPT_NUMBER%TYPE
    ) RETURN NUMBER
    IS
        v_student_count NUMBER;
        v_dept_exists   NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_dept_exists FROM DEPARTMENT WHERE DEPT_NUMBER = p_dept_number;

        IF v_dept_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Department ID ' || p_dept_number || ' does not exist.');
        END IF;

        SELECT
            COUNT(*)
        INTO
            v_student_count
        FROM
            STUDENT S
        WHERE
            S.DEPT_NUMBER = p_dept_number;

        RETURN v_student_count;

    EXCEPTION
        -- For RAISE_APPLICATION_ERROR, the error will propagate out.
        -- The OTHERS handler here would catch different unexpected errors.
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in Get_Student_Count_By_Dept: ' || SQLERRM);
            RETURN NULL; -- Or simply RAISE; to propagate the original unhandled error
    END Get_Student_Count_By_Dept;

END SIMS_Query_Pkg;
/
```
***3. Testing the Packaged Procedures and Functions***

```sql
-- Test Case 1: Valid Student ID
BEGIN
    SIMS_Query_Pkg.Get_Student_Details('S001'); 
END;
/

-- Test Case 2: Non-existent Student ID
BEGIN
    SIMS_Query_Pkg.Get_Student_Details('S999'); -- Assuming S999 does not exist
END;
/
```
![alt text](<PhaseI to VII screenshots/test_package1.PNG>)

![alt text](<PhaseI to VII screenshots/test_package2.PNG>)

```sql
-- Test Case 1: Valid Department ID with courses
BEGIN
    SIMS_Query_Pkg.List_Courses_By_Department('1'); -- Assuming Department '1' exists and has courses
END;
/

-- Test Case 2: Non-existent Department ID
BEGIN
    SIMS_Query_Pkg.List_Courses_By_Department('9'); -- Assuming Department '9' does not exist
END;
/
```
![alt text](<PhaseI to VII screenshots/test_package3.PNG>)

![alt text](<PhaseI to VII screenshots/test_package4.PNG>)

```sql
-- Test Case 1: Valid Department ID (using anonymous block)
DECLARE
    v_count NUMBER;
BEGIN
    v_count := SIMS_Query_Pkg.Get_Student_Count_By_Dept('1'); -- Assuming Dept '1' exists
    IF v_count IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Student count for department 1 (from package): ' || v_count);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error or department not found for dept 1 (from package).');
    END IF;
END;
/

-- Test Case 2: Valid Department ID (using SELECT statement)
SELECT SIMS_Query_Pkg.Get_Student_Count_By_Dept('2') AS Pkg_Student_Count_Dept2 FROM DUAL;

-- Test Case 3: Non-existent Department ID (will raise custom error or return NULL based on implementation)
-- Using anonymous block to catch the potential custom error
BEGIN
    DBMS_OUTPUT.PUT_LINE(SIMS_Query_Pkg.Get_Student_Count_By_Dept('9'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error calling packaged function for dept 9: ' || SQLERRM);
END;
/
```
![alt text](<PhaseI to VII screenshots/test_package5.PNG>)

![alt text](<PhaseI to VII screenshots/test_package6.PNG>)


# Phase VII: Advanced Database Programming and Auditing

## 1. Problem Statement Development
The Student Information Management System (SIMS) requires strict controls over data modifications to prevent unauthorized or untimely changes that could compromise data integrity, disrupt academic operations, or violate compliance policies. Currently, there is no automated mechanism to enforce "data modification blackout periods"—restricting DML operations (INSERT, UPDATE, DELETE) on core tables during weekdays (Monday–Friday) and upcoming public holidays. Additionally, the system lacks a comprehensive audit trail for tracking DML attempts, whether successful or blocked.

Justification for Advanced Database Features
**Triggers**

**Necessity**: To automatically intercept and validate DML operations before execution, enforcing time-based restrictions without relying on application-level checks.

**Value**: Ensures consistent, real-time enforcement of business rules (e.g., blocking changes on holidays/weekdays) directly at the database level.

**Packages**

**Necessity**: Complex logic (e.g., holiday lookups, rule validations) requires modular, reusable code.

**Value**: Encapsulates related procedures/functions (e.g., checking blackout periods, logging attempts) for cleaner triggers and easier maintenance.

**Auditing**

**Necessity**: Compliance and security demand tracking all DML attempts (allowed/denied).

**Value**: Provides an audit trail for accountability, security reviews, and troubleshooting by logging user actions, timestamps, and operation outcomes.

**Conclusion**
Using triggers, packages, and auditing ensures automated, secure, and compliant data management in SIMS, addressing critical gaps in access control and accountability.

## 2. Trigger Implementation



```SQL
CREATE OR REPLACE PACKAGE SIMS_Security_Pkg IS

    -- Function to check if DML operations are allowed based on day and holidays
    -- Returns TRUE if DML is allowed, FALSE otherwise.
    FUNCTION Is_DML_Allowed RETURN BOOLEAN;

END SIMS_Security_Pkg;
/


CREATE OR REPLACE PACKAGE BODY SIMS_Security_Pkg IS

    FUNCTION Is_DML_Allowed RETURN BOOLEAN IS
        v_current_day VARCHAR2(3); -- To store 'MON', 'TUE', etc.
        v_is_holiday NUMBER := 0; -- Flag to check if today is a holiday in June 2025
        v_upcoming_month NUMBER := 6; -- June
        v_upcoming_year NUMBER := 2025; -- Year for upcoming month
    BEGIN
        -- Get the current day of the week (English abbreviation)
        SELECT TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') INTO v_current_day FROM DUAL;

        -- 1. Check for weekday restriction (Block DML Mon-Fri)
        IF v_current_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') THEN
            RETURN FALSE; -- DML not allowed on weekdays
        END IF;

        -- 2. If it's a weekend (Sat or Sun), then check for upcoming month's holiday restriction
        -- Check if today is a public holiday in the defined upcoming month (June 2025)
        BEGIN
            SELECT 1
            INTO v_is_holiday
            FROM SIMS_PUBLIC_HOLIDAYS
            WHERE TRUNC(HOLIDAY_DATE) = TRUNC(SYSDATE)
              AND EXTRACT(MONTH FROM HOLIDAY_DATE) = v_upcoming_month
              AND EXTRACT(YEAR FROM HOLIDAY_DATE) = v_upcoming_year;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_is_holiday := 0; -- Not a defined holiday for June 2025
        END;

        IF v_is_holiday = 1 THEN
            RETURN FALSE; -- DML not allowed on this specific holiday in June 2025
        END IF;

        -- If none of the above restrictions apply, DML is allowed
        RETURN TRUE;

    EXCEPTION
        WHEN OTHERS THEN
            -- Log error or handle appropriately. For safety, deny DML if an error occurs in check.
            DBMS_OUTPUT.PUT_LINE('Error in SIMS_Security_Pkg.Is_DML_Allowed: ' || SQLERRM);
            RETURN FALSE; -- Default to not allowing DML if there's an unexpected error in the check
    END Is_DML_Allowed;

END SIMS_Security_Pkg;
/
```

```SQL
CREATE OR REPLACE TRIGGER TRG_Restrict_DML_STUDENT
BEFORE INSERT OR UPDATE OR DELETE ON STUDENT
-- FOR EACH STATEMENT -- This is implied if FOR EACH ROW is not specified
DECLARE
    -- No local variables needed for this simple statement-level trigger
BEGIN
    IF NOT SIMS_Security_Pkg.Is_DML_Allowed THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data manipulation on STUDENT table is not allowed at this time (restricted weekday or an upcoming month''s public holiday).');
    END IF;
END TRG_Restrict_DML_STUDENT;
/

CREATE OR REPLACE TRIGGER TRG_Restrict_DML_COURSE
BEFORE INSERT OR UPDATE OR DELETE ON COURSE
DECLARE
BEGIN
    IF NOT SIMS_Security_Pkg.Is_DML_Allowed THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data manipulation on COURSE table is not allowed at this time (restricted weekday or an upcoming month''s public holiday).');
    END IF;
END TRG_Restrict_DML_COURSE;
/
```
**testing triggers**
```sql
INSERT INTO STUDENT (STUDENT_ID, FIRST_NAME, LAST_NAME, SEX, DATE_OF_BIRTH, EMAIL, DEPT_NUMBER)
VALUES ('S999', 'Test', 'User', 'M', TO_DATE('2000-01-01','YYYY-MM-DD'), 'test.user@example.com', '1');
```
![alt text](<PhaseI to VII screenshots/test_trigger1.PNG>)

# Auditing with Restrictions and Tracking

![alt text](<PhaseI to VII screenshots/TRACK&AUDIT1.PNG>)

![alt text](<PhaseI to VII screenshots/TRACK_AUDIT2.PNG>)

![alt text](<PhaseI to VII screenshots/TRACK_AUDIT3.PNG>)

![alt text](<PhaseI to VII screenshots/TRACK_AUDIT4.PNG>)

![alt text](<PhaseI to VII screenshots/Auditing attempts.PNG>)


This Approach Enhances Security and Aligns with System Objectives by ensuring:


🔒 Security & Compliance Summary 🔍
🛡️ Proactive Prevention
🚫 TRG_Restrict_DML_... triggers block unauthorized data changes during weekdays/holidays.

✅ Ensures data accuracy and system stability by limiting high-risk modifications.

📜 Accountability & Tracking
📋 SIMS_AUDIT_LOG records all DML attempts (user, timestamp, action, outcome).

🎯 Directly supports "Track user actions for accountability".

🔎 Detection & Investigation
⚠️ Audit logs help identify suspicious patterns or breaches.

🕵️‍♂️ Critical for forensics and incident response.

✋ Deterrence
📢 Visibility of logging discourages malicious/careless behavior.

🔄 Sensitive Data Monitoring
📈 TRG_Audit_Grade_Changes logs modifications to sensitive tables (e.g., GRADE).

🔄 Tracks data evolution and supports compliance.

⚙️ Modular & Maintainable
📦 SIMS_Audit_Pkg centralizes audit logic for easy updates.

🎯 Alignment with SIMS Objectives
🔐 Secure data management

📊 Integrity & stability

🛡️ Proactive security + reactive auditing

💡 Key Takeaway: Combines prevention + logging for robust security!




