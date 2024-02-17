CREATE TABLE Stud_Course (
    spid CHAR(3),
    ccode CHAR(5),
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
    grade = 
        CASE 
            WHEN @grade_num >= 75 THEN 'A'
            WHEN @grade_num BETWEEN 65 AND 74 THEN 'B'
            WHEN @grade_num BETWEEN 55 AND 64 THEN 'C'
            WHEN @grade_num BETWEEN 40 AND 54 THEN 'D'
            ELSE 'F'
        END;
