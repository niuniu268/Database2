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
