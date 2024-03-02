# Database Assignment 2

## Introduction

According to the requirements and E-R diagram, we need to generate several tables in the database. The database consists of the following tables: faculty, department, teacher, course, student, committee, grade, can_teach, stud_course, and teach_comm. In the grade table, the letter grade is the primary key. Compared with the grade table, the teacher table plays an important role in this study. The attribute tpid is the primary key of the teacher table. The attributes rank and dept should be enumerated to avoid inputting incorrect values. Apart from tpid, the dept attribute is a foreign key associated with the department table. One tuple in the department table is associated with many tuples in the teacher table. The department table is associated with the faculty table by the attribute fcode. It is also clear that one tuple in the faculty table can match many tuples in the department table. The teacher table connects to the committee table through the teach_comm table. The teacher table is also associated with the course table through the can_teach table. In addition to the connection via can_teach, the course table is also connected to the teacher table through the does_teach and responsibility attributes. Finally, the course table also has a relation with the student table via the betyg attribute. After generating these tables, I will proceed to create the following queries.

## Edit the design of your tables
- Department

```
CREATE TABLE Department (
    dcode VARCHAR(2) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    fcode CHAR(1) NOT NULL,
    FOREIGN KEY (fcode) REFERENCES Faculty(fcode)
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/department.csv'
INTO TABLE Department
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dcode, name, fcode);
```

- Faculty

```
CREATE TABLE Faculty (
    fcode CHAR(1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/faculty.csv'
INTO TABLE Faculty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(fcode, name);
```

- Committee

```
CREATE TABLE Committee (
    xcode CHAR(4) PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/committee.csv'
INTO TABLE Committee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(xcode, name);
```

- Grade

```
CREATE TABLE Grade (
    letter ENUM('A', 'B', 'C', 'D', 'F') PRIMARY KEY,
    min INT UNSIGNED NOT NULL,
    max INT UNSIGNED NOT NULL
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/grade.csv'
INTO TABLE Grade
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(letter, min, max);
```

- Teacher

```
CREATE TABLE Teacher (
    tpid VARCHAR(3) PRIMARY KEY,
    forename VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    dept ENUM('CH', 'MU', 'FR', 'ST', 'EL', 'CS', 'PE', 'PH', 'DR', 'BI', 'MA','GE') NOT NULL,
    rank ENUM('assis prof', 'assoc prof', 'professor') NOT NULL
);

INSERT INTO Teacher (tpid, forename, surname, dept, rank)
SELECT LPAD(CAST(tpid AS CHAR), 3, '0') AS tpid,
       forename,
       surname,
       CASE
           WHEN dept = 'BI' THEN 'BI'
           WHEN dept = 'CH' THEN 'CH'
           WHEN dept = 'CS' THEN 'CS'
           WHEN dept = 'DR' THEN 'DR'
           WHEN dept = 'EL' THEN 'EL'
           WHEN dept = 'FR' THEN 'FR'
           WHEN dept = 'GE' THEN 'GE'
           WHEN dept = 'MA' THEN 'MA'
           WHEN dept = 'MU' THEN 'MU'
           WHEN dept = 'PE' THEN 'PE'
           WHEN dept = 'PH' THEN 'PH'
           WHEN dept = 'ST' THEN 'ST'
       END AS dept,
       CASE
           WHEN rank = 'assis prof' THEN 'assis prof'
           WHEN rank = 'assoc prof' THEN 'assoc prof'
           WHEN rank = 'professor' THEN 'professor'
       END AS rank
FROM ass.teacher;
```

- Student

```
CREATE TABLE Student (
    spid CHAR(3) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    year ENUM('S', 'F', 'J', 'E') NOT NULL,
    sup VARCHAR(255)
);


LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/students.csv'
INTO TABLE Student
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(spid, name, year, sup)
SET spid = LPAD(CAST(spid AS CHAR), 3, '0');
```

-Course
```
CREATE TABLE Course (
    ccode CHAR(5) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    does_teach CHAR(3),
    responsible CHAR(3),
    FOREIGN KEY (does_teach) REFERENCES Teacher(tpid),
    FOREIGN KEY (responsible) REFERENCES Teacher(tpid)
    
);


LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/course.csv'
INTO TABLE Course
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ccode, name,  does_teach, responsible)
SET ccode = LPAD(ccode, 5, '0'),
    responsible = LPAD(responsible, 3, '0'),
    does_teach = LPAD(does_teach, 3, '0');

```

- Can_Teach

```
CREATE TABLE Can_Teach (
    tpid VARCHAR(3),
    ccode CHAR(5),
    PRIMARY KEY (tpid, ccode),
    FOREIGN KEY (tpid) REFERENCES Teacher(tpid),
    FOREIGN KEY (ccode) REFERENCES Course(ccode)
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/can_teach.csv'
INTO TABLE Can_Teach
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tpid, ccode)
SET tpid = LPAD(CAST(tpid AS CHAR), 3, '0');

```

- Teach_Comm

```
CREATE TABLE Teach_Comm (
    xcode CHAR(4),
    tpid VARCHAR(3),
    PRIMARY KEY (xcode,tpid),
    FOREIGN KEY (xcode) REFERENCES Committee(xcode),
    FOREIGN KEY (tpid) REFERENCES Teacher(tpid)
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/teach_comm.csv'
INTO TABLE Teach_Comm
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(xcode,tpid)
SET tpid = LPAD(CAST(tpid AS CHAR), 3, '0');
```

- Stud_Couse

```
CREATE TABLE Stud_Course (
    spid CHAR(3),
    ccode CHAR(5),
    grade_num INT,
    grade ENUM('A', 'B', 'C', 'D', 'F') NOT NULL,
    PRIMARY KEY (spid, ccode),
    FOREIGN KEY (spid) REFERENCES Student(spid),
    FOREIGN KEY (ccode) REFERENCES Course(ccode)
);

LOAD DATA LOCAL INFILE '/home/niuniu/Documents/DatabaseAssignment2/stud_course.csv'
INTO TABLE Stud_Course
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(spid, ccode, @grade_num)
SET 
    spid = LPAD(CAST(spid AS CHAR), 3, '0'),
    grade_num = @grade_num,
    grade = 
        CASE 
            WHEN @grade_num >= 75 THEN 'A'
            WHEN @grade_num BETWEEN 65 AND 74 THEN 'B'
            WHEN @grade_num BETWEEN 55 AND 64 THEN 'C'
            WHEN @grade_num BETWEEN 40 AND 54 THEN 'D'
            ELSE 'F'
        END;
```

- Alumni_student

```
CREATE TABLE Alumni_students  (

    spid CHAR(3) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    year ENUM('S', 'F', 'J', 'E') NOT NULL,
    sup VARCHAR(255)

);
```
## Create the following queries in SQL
1. Howmanycoursesdoeseachdepartmentgives?Includedepartments(if any) that does not give any courses
![image1](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2011.45.56.png?raw=true)
2. Listtheteachersthatdoesnotteachthissemester
![image2](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2012.18.27.png?raw=true)
3. Listthemembersinthecommittee"CoursePlanning"(name,
department)
![image3](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2012.41.04.png?raw=true)
4. Listtheteachersthatareresponsibleformorethantwocourses
![image4](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2012.53.51.png?raw=true)
5. Listtheteachersthatcanteachthecourse"LinearAlgebra"
![image5](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2012.55.38.png?raw=true)
6. List,foreachstudent,thenumberofcoursethestudenttakes.
![image6](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2012.57.31.png?raw=true)
7. ListforeachcourseinComputerSciencethathasmorethanfour
students: the name of the course, the highest grade, the lowest grade,
and the average grade on the course.
![image7](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2014.07.49.png?raw=true)
8. Listnameand(numeric)gradeforthestudentsonthecourse"CS
Introduction" that have received the grade 'C'.
![image8](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2014.10.42.png?raw=true)
9. ListforeachcourseinMathematics:thenameofthecourse,the
number of students and the teacher that does teach the course
![image9](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2014.47.39.png?raw=true)
10. List for each student that has failed a course: the student’s name, the
name of the course and the grade
![image10](https://github.com/niuniu268/Database2/blob/master/imgs/Screenshot%202024-02-17%20at%2015.08.32.png?raw=true)
## Create the following triggers in SQL
- A trigger for UPDATE of the field grade: if the new value > 100 an error message should be printed

```
CREATE TRIGGER grade_check
BEFORE UPDATE ON Stud_Course
FOR EACH ROW
BEGIN
    IF NEW.grade_num > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Grade cannot be greater than 100';
    END IF;
END;

```
- A trigger for INSERT of a new course: if does_teach and responsible are not employed at the same department an error message should be printed

```
CREATE TRIGGER course_department_check
BEFORE INSERT ON Course
FOR EACH ROW
BEGIN
    DECLARE does_teach_dept CHAR(2);
    DECLARE responsible_dept CHAR(2);
    
    SELECT dept INTO does_teach_dept FROM Teacher WHERE tpid = NEW.does_teach;
    

    SELECT dept INTO responsible_dept FROM Teacher WHERE tpid = NEW.responsible;
    

    IF does_teach_dept != responsible_dept THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error';
    END IF;
END;
```

- A trigger for DELETE of a student: the deleted student should be added to the table Alumni_students (which you create in advance)

```
CREATE TRIGGER delete_student
AFTER DELETE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Alumni_students (spid, name) VALUES (OLD.spid, OLD.name);
END;
```

# Summary

Through this assignment, we thoroughly practiced SQL queries and PL/SQL. Upon completing this assignment, we gained an understanding of how to construct a proper database based on an E-R diagram. This experience has been valuable.