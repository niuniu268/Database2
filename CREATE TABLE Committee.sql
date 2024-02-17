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
