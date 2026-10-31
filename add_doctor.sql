CREATE OR REPLACE PROCEDURE add_doctor (
    p_first_name IN  doctors.first_name%TYPE,
    p_last_name  IN  doctors.last_name%TYPE,
    p_specialty  IN  doctors.specialty%TYPE,
    p_phone      IN  doctors.phone%TYPE,
    p_email      IN  doctors.email%TYPE,
    p_doctor_id  OUT doctors.doctor_id%TYPE
)
AS
BEGIN
    INSERT INTO doctors (
        first_name, last_name, specialty, phone, email
    )
    VALUES (
        p_first_name, p_last_name, p_specialty, p_phone, p_email
    )
    RETURNING doctor_id INTO p_doctor_id;

    DBMS_OUTPUT.PUT_LINE('Doctor added. Rows inserted: ' || SQL%ROWCOUNT);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20005, 'A doctor with this email already exists.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20006, 'Doctor creation failed: ' || SQLERRM);
END;
/
