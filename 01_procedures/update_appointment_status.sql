CREATE OR REPLACE PROCEDURE update_appointment_status (
    p_appointment_id IN appointments.appointment_id%TYPE,
    p_new_status     IN appointments.status%TYPE
)
AS
BEGIN
    IF p_new_status IS NULL OR
       p_new_status NOT IN ('SCHEDULED', 'CONFIRMED', 'COMPLETED', 'CANCELLED') THEN
        RAISE_APPLICATION_ERROR(-20020, 'Invalid appointment status.');
    END IF;

    UPDATE appointments
    SET status = p_new_status
    WHERE appointment_id = p_appointment_id;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20021, 'Appointment not found.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Appointment status updated. Rows: ' || SQL%ROWCOUNT);
END;
/
