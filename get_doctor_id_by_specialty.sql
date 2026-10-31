CREATE OR REPLACE FUNCTION get_doctor_id_by_specialty (
    p_specialty IN doctors.specialty%TYPE
)
RETURN doctors.doctor_id%TYPE
AS
    v_doctor_id doctors.doctor_id%TYPE;
BEGIN
    SELECT doctor_id
    INTO v_doctor_id
    FROM (
        SELECT doctor_id
        FROM doctors
        WHERE UPPER(specialty) = UPPER(p_specialty)
        ORDER BY doctor_id
    )
    WHERE ROWNUM = 1;

    RETURN v_doctor_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20050, 'No doctor found for this specialty.');
END;
/
