SELECT Course.name AS course_name, Student.name AS student_name, Stud_Course.grade, Stud_Course.grade_num 
FROM Stud_Course
JOIN Course ON Stud_Course.ccode = Course.ccode
JOIN Student ON Student.spid = Stud_Course.spid
WHERE Stud_Course.grade = 'F';
