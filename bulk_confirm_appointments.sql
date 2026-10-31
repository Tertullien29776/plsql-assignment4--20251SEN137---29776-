CREATE OR REPLACE PROCEDURE bulk_confirm_appointments (
    p_start_date    IN  DATE,
    p_end_date      IN  DATE,
    p_updated_count OUT NUMBER
)
AS
    TYPE t_appointment_ids IS TABLE OF appointments.appointment_id%TYPE;
    v_appointment_ids t_appointment_ids;

    e_bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_bulk_errors, -24381);
BEGIN
    p_updated_count := 0;

    SELECT appointment_id
    BULK COLLECT INTO v_appointment_ids
    FROM appointments
    WHERE appointment_datetime >= CAST(TRUNC(p_start_date) AS TIMESTAMP)
      AND appointment_datetime <  CAST(TRUNC(p_end_date) + 1 AS TIMESTAMP)
      AND status = 'SCHEDULED';

    IF v_appointment_ids.COUNT > 0 THEN
        FORALL i IN 1 .. v_appointment_ids.COUNT SAVE EXCEPTIONS
            UPDATE appointments
            SET status = 'CONFIRMED'
            WHERE appointment_id = v_appointment_ids(i);

        p_updated_count := SQL%ROWCOUNT;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Bulk confirmation completed. Rows updated: ' || p_updated_count);
EXCEPTION
    WHEN e_bulk_errors THEN
        FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Bulk error for collection item ' ||
                SQL%BULK_EXCEPTIONS(i).ERROR_INDEX ||
                ': ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE)
            );
        END LOOP;
        RAISE_APPLICATION_ERROR(-20030, 'One or more bulk appointment updates failed.');
END;
/
