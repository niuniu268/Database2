CREATE TRIGGER course_department_check
BEFORE INSERT ON Course
FOR EACH ROW
BEGIN
    DECLARE does_teach_dept CHAR(2);
    DECLARE responsible_dept CHAR(2);
    
    SELECT dept INTO does_teach_dept FROM Teacher WHERE tpid = NEW.does_teach;
    

    SELECT dept INTO responsible_dept FROM Teacher WHERE tpid = NEW.responsible;
    

    IF does_teach_dept != responsible_dept THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error';
    END IF;
END;