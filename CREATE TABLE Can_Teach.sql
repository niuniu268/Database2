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
