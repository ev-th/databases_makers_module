-- (file: spec/seeds_albums.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts, students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, starting_date) VALUES ('cohort_1', '2023-03-15');
INSERT INTO cohorts (name, starting_date) VALUES ('cohort_2', '2023-04-21');

INSERT INTO students (name, cohort_id) VALUES ('name_1', 1);
INSERT INTO students (name, cohort_id) VALUES ('name_2', 1);