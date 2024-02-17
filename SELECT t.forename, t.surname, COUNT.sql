SELECT t.forename, t.surname, COUNT(c.ccode) AS num_courses
FROM Teacher t
JOIN Course c ON t.tpid = c.responsible
GROUP BY t.tpid
HAVING num_courses > 2;
