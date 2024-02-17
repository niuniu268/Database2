CREATE TRIGGER course_department_check
BEFORE INSERT ON Course
FOR EACH ROW
BEGIN
    DECLARE does_teach_dept CHAR(2);
    DECLARE responsible_dept CHAR(2);
    
    -- Get the department of does_teach
    SELECT dept INTO does_teach_dept FROM Teacher WHERE tpid = NEW.does_teach;
    
    -- Get the department of responsible
    SELECT dept INTO responsible_dept FROM Teacher WHERE tpid = NEW.responsible;
    
    -- Check if the departments are different
    IF does_teach_dept != responsible_dept THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: does_teach and responsible are not employed at the same department';
    END IF;
END;