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