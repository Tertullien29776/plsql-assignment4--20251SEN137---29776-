CREATE OR REPLACE PROCEDURE schedule_appointment (
    p_patient_id            IN  appointments.patient_id%TYPE,
    p_doctor_id             IN  appointments.doctor_id%TYPE,
    p_appointment_datetime  IN  appointments.appointment_datetime%TYPE,
    p_reason                IN  appointments.reason%TYPE,
    p_appointment_id        OUT appointments.appointment_id%TYPE
)
AS
    v_patient_count NUMBER;
    v_doctor_count  NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_patient_count
    FROM patients
    WHERE patient_id = p_patient_id;

    IF v_patient_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Patient does not exist.');
    END IF;

    SELECT COUNT(*) INTO v_doctor_count
    FROM doctors
    WHERE doctor_id = p_doctor_id;

    IF v_doctor_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Doctor does not exist.');
    END IF;

    IF p_appointment_datetime <= SYSTIMESTAMP THEN
        RAISE_APPLICATION_ERROR(-20012, 'Appointment date and time must be in the future.');
    END IF;

    INSERT INTO appointments (
        patient_id, doctor_id, appointment_datetime, reason
    )
    VALUES (
        p_patient_id, p_doctor_id, p_appointment_datetime, p_reason
    )
    RETURNING appointment_id INTO p_appointment_id;

    DBMS_OUTPUT.PUT_LINE('Appointment scheduled. Rows inserted: ' || SQL%ROWCOUNT);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20013, 'The patient or doctor already has an appointment at that time.');
    WHEN OTHERS THEN
        IF SQLCODE BETWEEN -20099 AND -20000 THEN
            RAISE;
        ELSE
            RAISE_APPLICATION_ERROR(-20014, 'Appointment scheduling failed: ' || SQLERRM);
        END IF;
END;
/
