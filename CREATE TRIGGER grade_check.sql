CREATE TRIGGER grade_check
BEFORE UPDATE ON Stud_Course
FOR EACH ROW
BEGIN
    IF NEW.grade_num > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Grade cannot be greater than 100';
    END IF;
END;
