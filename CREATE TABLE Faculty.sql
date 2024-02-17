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