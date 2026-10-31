# Implementation Notes

- The system manages patients, doctors, and appointments.
- Oracle identity columns automatically generate primary key values.
- Primary keys, foreign keys, unique rules, NOT NULL rules, and CHECK rules are declared directly in `CREATE TABLE`.
- `REGISTER_PATIENT` and `ADD_DOCTOR` use `INSERT ... RETURNING ... INTO` to return generated IDs.
- `DISPLAY_PATIENT_APPOINTMENTS` demonstrates an explicit cursor and `%ROWTYPE`.
- `BULK_CONFIRM_APPOINTMENTS` demonstrates `BULK COLLECT`, `FORALL`, and bulk exception handling.
- Other procedures demonstrate implicit cursor attributes such as `SQL%ROWCOUNT` and `SQL%NOTFOUND`.
- Functions return the number of appointments for a patient and a doctor ID for a specialty.
- Test success and error cases separately.
- Capture your own screenshots after running the scripts in Oracle SQL Developer. Do not use fabricated output screenshots.
