SELECT 
Course.name, Max(Stud_Course.grade_num), Min(Stud_Course.grade_num), Round(Avg(Stud_Course.grade_num),2)
FROM 
    Course
JOIN
    Teacher ON Course.does_teach = Teacher.tpid
JOIN Stud_Course ON Stud_Course.ccode = Course.ccode

WHERE 
    Teacher.dept LIKE 'CS'

GROUP BY Stud_Course.ccode

HAVING COUNT(Stud_Course.spid) >4
;
