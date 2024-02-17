-- Step 1: Create the Course table
CREATE TABLE Course (
    ccode CHAR(5) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    does_teach CHAR(3),
    responsible CHAR(3),
    FOREIGN KEY (does_teach) REFERENCES Teacher(tpid),
    FOREIGN KEY (responsible) REFERENCES Teacher(tpid)
    
);

-- Step 2: Load data into the Course table
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
