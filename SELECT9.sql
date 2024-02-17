SELECT 
    Course.name AS course_name,
    COUNT(Stud_Course.spid) AS num_students,
    Teacher.forename AS teacher_forename,
    Teacher.surname AS teacher_surname
FROM 
    Stud_Course
JOIN 
    Course ON Course.ccode = Stud_Course.ccode
JOIN 
    Teacher ON Course.does_teach = Teacher.tpid
JOIN 
    Department ON Department.dcode = Teacher.dept
WHERE 
    Department.name = 'Mathematics'
GROUP BY 
    Stud_Course.ccode;
