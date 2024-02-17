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