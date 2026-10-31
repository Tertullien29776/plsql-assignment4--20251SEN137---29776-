CREATE OR REPLACE PROCEDURE display_patient_appointments (
    p_patient_id IN patients.patient_id%TYPE
)
AS
    CURSOR c_appointments IS
        SELECT a.appointment_id,
               a.appointment_datetime,
               a.reason,
               a.status,
               d.first_name || ' ' || d.last_name AS doctor_name,
               d.specialty
        FROM appointments a
        JOIN doctors d ON d.doctor_id = a.doctor_id
        WHERE a.patient_id = p_patient_id
        ORDER BY a.appointment_datetime;

    v_row c_appointments%ROWTYPE;
BEGIN
    OPEN c_appointments;
    LOOP
        FETCH c_appointments INTO v_row;
        EXIT WHEN c_appointments%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Appointment: ' || v_row.appointment_id ||
            ' | Date: ' || TO_CHAR(v_row.appointment_datetime, 'YYYY-MM-DD HH24:MI') ||
            ' | Doctor: ' || v_row.doctor_name ||
            ' | Specialty: ' || v_row.specialty ||
            ' | Status: ' || v_row.status ||
            ' | Reason: ' || v_row.reason
        );
    END LOOP;

    IF c_appointments%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No appointments found for this patient.');
    END IF;

    CLOSE c_appointments;
EXCEPTION
    WHEN OTHERS THEN
        IF c_appointments%ISOPEN THEN
            CLOSE c_appointments;
        END IF;
        RAISE;
END;
/
