CREATE OR REPLACE PROCEDURE delete_appointment (
    p_appointment_id IN appointments.appointment_id%TYPE
)
AS
BEGIN
    DELETE FROM appointments
    WHERE appointment_id = p_appointment_id;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20040, 'Appointment not found; nothing was deleted.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Appointment deleted. Rows deleted: ' || SQL%ROWCOUNT);
END;
/
