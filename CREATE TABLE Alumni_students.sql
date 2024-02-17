CREATE TABLE Alumni_students  (

    spid CHAR(3) PRIMARY KEY,

    name VARCHAR(255) NOT NULL,

    year ENUM('S', 'F', 'J', 'E') NOT NULL,

    sup VARCHAR(255)

);