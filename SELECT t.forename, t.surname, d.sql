SELECT t.forename, t.surname, d.name AS department
FROM Teach_Comm tc
JOIN Teacher t ON tc.tpid = t.tpid
JOIN Committee c ON tc.xcode = c.xcode
JOIN Department d ON t.dept = d.dcode
WHERE c.name LIKE '%Course Planning%' ;
