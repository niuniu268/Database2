SELECT 
    s.name AS student_name,
    sc.grade_num AS numeric_grade
FROM 
    Student s
JOIN 
    Stud_Course sc ON s.spid = sc.spid
JOIN 
    Course c ON sc.ccode = c.ccode
WHERE 
    c.name LIKE '%CS Introduction%' AND sc.grade = 'C';
