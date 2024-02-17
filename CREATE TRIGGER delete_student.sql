CREATE TRIGGER delete_student
AFTER DELETE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Alumni_students (spid, name) VALUES (OLD.spid, OLD.name);
END;
