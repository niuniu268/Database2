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
