CREATE OR REPLACE FUNCTION get_patient_appointment_count (
    p_patient_id IN patients.patient_id%TYPE
)
RETURN NUMBER
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM appointments
    WHERE patient_id = p_patient_id;

    RETURN v_count;
END;
/
