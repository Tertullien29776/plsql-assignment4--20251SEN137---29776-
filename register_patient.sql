CREATE OR REPLACE PROCEDURE register_patient (
    p_first_name    IN  patients.first_name%TYPE,
    p_last_name     IN  patients.last_name%TYPE,
    p_date_of_birth IN  patients.date_of_birth%TYPE,
    p_gender        IN  patients.gender%TYPE,
    p_phone         IN  patients.phone%TYPE,
    p_email         IN  patients.email%TYPE,
    p_patient_id    OUT patients.patient_id%TYPE
)
AS
BEGIN
    INSERT INTO patients (
        first_name, last_name, date_of_birth, gender, phone, email
    )
    VALUES (
        p_first_name, p_last_name, p_date_of_birth, p_gender, p_phone, p_email
    )
    RETURNING patient_id INTO p_patient_id;

    DBMS_OUTPUT.PUT_LINE('Patient registered. Rows inserted: ' || SQL%ROWCOUNT);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20002, 'A patient with this email already exists.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Patient registration failed: ' || SQLERRM);
END;
/
