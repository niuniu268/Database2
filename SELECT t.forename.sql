SELECT t.forename, t.surname
FROM Teacher t
JOIN Can_Teach ct ON t.tpid = ct.tpid
JOIN Course c ON ct.ccode = c.ccode
WHERE c.name LIKE '%Linear Algebra%';
