# plsql-assignment4--20251SEN137---29776-
# Hospital Management System Using Oracle PL/SQL

## Group members
- Student 1: `SENGA APHRODIS` ID: `20251SEN137`
- Student 2: `UHORANAYEZU Tertullien` ID: `29776`



## 1. Application description
This project is a small Hospital Management System implemented in Oracle SQL and PL/SQL. It manages:
- Patients and their contact details.
- Doctors and their medical specializations.
- Appointments connecting a patient to a doctor, including appointment date/time, reason, and status.

The project is an academic demonstration. It is not a production clinical-record system and does not store diagnoses, prescriptions, or other sensitive clinical details.

## 2. Database design
The database contains three related tables:

| `PATIENTS` | Stores patient identity and contact information | One patient can have many appointments |
| `DOCTORS` | Stores doctor details and specialization | One doctor can have many appointments |
| `APPOINTMENTS` | Stores each booking | Each appointment references one patient and one doctor |

`APPOINTMENTS.patient_id` references `PATIENTS.patient_id`; `APPOINTMENTS.doctor_id` references `DOCTORS.doctor_id`.


```

## 4. Requirements demonstrated
- User-defined PL/SQL records and table `%ROWTYPE`.
- A nested-table collection.
- Implicit cursor attributes: `SQL%ROWCOUNT`, `SQL%FOUND`, and `SQL%NOTFOUND`.
- Explicit cursor processing using `OPEN`, `FETCH`, and `CLOSE`.
- `BULK COLLECT` and `FORALL ... SAVE EXCEPTIONS`.
- Stored procedures with IN and OUT parameters.
- Stored functions returning meaningful values.
- Predefined exceptions, user-defined exceptions, and `RAISE_APPLICATION_ERROR`.

## 5. How to run
Run the scripts in Oracle SQL Developer or SQL*Plus, connected to a schema where you have permission to create tables and PL/SQL objects. Run each script using **Run Script (F5)** in SQL Developer, or use `@path/to/file.sql` in SQL*Plus.

1. `00_schema/01_create_tables.sql`
2. `00_schema/02_insert_sample_data.sql`
3. Compile every `.sql` file in `01_procedures/`.
4. Compile every `.sql` file in `02_functions/`.
5. Run `03_tests/test_success_cases.sql`.
6. Run `03_tests/test_error_cases.sql`.
7. Capture genuine execution output and save it in `screenshots/`.

Enable output before running PL/SQL blocks:
```sql
SET SERVEROUTPUT ON;
```

The scripts use Oracle identity columns and `FETCH FIRST`-independent SQL. Use Oracle Database 12c or later.

## 6. Expected test data
The sample data inserts patients with IDs 1,3 and doctors with IDs 10,12. It inserts appointments with IDs 100, 102. The success test creates an additional patient and appointment, so rerun the schema and sample-data scripts first if you want a clean repeatable test.

## 7. Screenshots
See `screenshots/README.md` for the required evidence and suggested image filenames.
## 8. Academic integrity and AI-use disclosure
An AI assistant was used to help structure the repository, draft example SQL/PLSQL code, and explain the implementation. The group must review, test, adapt, and understand every file, and must follow the instructor's academic-integrity requirements. Both members remain responsible for the submitted work and should be able to explain it during the presentation.
