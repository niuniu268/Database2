SELECT forename, surname
FROM Teacher
WHERE tpid NOT IN (
    SELECT DISTINCT does_teach
    FROM Course
);
