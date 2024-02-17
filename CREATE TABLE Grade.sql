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