SET SERVEROUTPUT ON;

DECLARE
    v_patient_id patients.patient_id%TYPE;
    v_doctor_id doctors.doctor_id%TYPE;
    v_appointment_id appointments.appointment_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- ERROR TEST 1: Invalid appointment status ---');
    BEGIN
        update_appointment_status(-999, 'WRONG_STATUS');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('--- ERROR TEST 2: Appointment with missing patient ---');
    BEGIN
        schedule_appointment(
            -999, 1, CAST(SYSTIMESTAMP AS TIMESTAMP) + INTERVAL '3' DAY,
            'Invalid patient test', v_appointment_id
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('--- ERROR TEST 3: Unknown doctor specialty ---');
    BEGIN
        v_doctor_id := get_doctor_id_by_specialty('Unknown Specialty');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('Error tests completed.');
END;
/
