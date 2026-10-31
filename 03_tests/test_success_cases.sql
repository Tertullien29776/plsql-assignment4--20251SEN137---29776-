-- Successful tests. Each run creates new unique emails.
SET SERVEROUTPUT ON;

DECLARE
    v_patient_id      patients.patient_id%TYPE;
    v_doctor_id       doctors.doctor_id%TYPE;
    v_appointment_id  appointments.appointment_id%TYPE;
    v_count           NUMBER;
    v_updated         NUMBER;
    v_suffix          VARCHAR2(30);
BEGIN
    v_suffix := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    DBMS_OUTPUT.PUT_LINE('--- TEST 1: Register a patient ---');
    register_patient(
        'Kevin', 'Rukundo', DATE '1995-06-15', 'Male',
        '+250780000099', 'kevin' || v_suffix || '@example.com', v_patient_id
    );
    DBMS_OUTPUT.PUT_LINE('New patient ID: ' || v_patient_id);

    DBMS_OUTPUT.PUT_LINE('--- TEST 2: Add a doctor ---');
    add_doctor(
        'Alice', 'Mutesi', 'Dermatology', '+250781000099',
        'alice' || v_suffix || '@example.com', v_doctor_id
    );
    DBMS_OUTPUT.PUT_LINE('New doctor ID: ' || v_doctor_id);

    DBMS_OUTPUT.PUT_LINE('--- TEST 3: Schedule an appointment ---');
    schedule_appointment(
        v_patient_id, v_doctor_id, CAST(SYSTIMESTAMP AS TIMESTAMP) + INTERVAL '2' DAY,
        'Skin consultation', v_appointment_id
    );
    DBMS_OUTPUT.PUT_LINE('New appointment ID: ' || v_appointment_id);

    DBMS_OUTPUT.PUT_LINE('--- TEST 4: Update appointment status ---');
    update_appointment_status(v_appointment_id, 'CONFIRMED');

    DBMS_OUTPUT.PUT_LINE('--- TEST 5: Display patient appointments ---');
    display_patient_appointments(v_patient_id);

    DBMS_OUTPUT.PUT_LINE('--- TEST 6: Call patient appointment-count function ---');
    v_count := get_patient_appointment_count(v_patient_id);
    DBMS_OUTPUT.PUT_LINE('Patient appointment count: ' || v_count);

    DBMS_OUTPUT.PUT_LINE('--- TEST 7: Bulk-confirm sample appointments ---');
    bulk_confirm_appointments(TRUNC(SYSDATE) + 2, TRUNC(SYSDATE) + 3, v_updated);
    DBMS_OUTPUT.PUT_LINE('Bulk update count returned: ' || v_updated);

    DBMS_OUTPUT.PUT_LINE('--- TEST 8: Delete the test appointment ---');
    delete_appointment(v_appointment_id);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('All success tests completed.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Success test failed: ' || SQLERRM);
        RAISE;
END;
/
