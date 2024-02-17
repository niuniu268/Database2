SELECT d.name AS department, COUNT(c.ccode) AS num_courses
FROM Department d
LEFT JOIN Teacher t ON d.dcode = t.dept
LEFT JOIN Course c ON t.tpid = c.does_teach
GROUP BY d.name;
