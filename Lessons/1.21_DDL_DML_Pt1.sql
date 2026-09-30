-- CREATE DATABASE jobs_mart;

-- SHOW DATABASES;

-- .read Lessons/1.21_DDL_DML_Pt1.sql
USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE  IF NOT EXISTS jobs_mart;

SHOW DATABASES;

-- DROP DATABASE jobs_mart;


SHOW DATABASES;

-- DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE  IF NOT EXISTS jobs_mart;

SHOW DATABASES;


SELECT *
FROM information_schema.schemata;

CREATE SCHEMA IF NOT EXISTS jobs_mart.staging;

SELECT *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;


SELECT *
FROM information_schema.schemata;

-- DROP SCHEMA staging;

SELECT *
FROM information_schema.schemata;


CREATE TABLE IF NOT EXISTS staging.preferred_roles (
   role_id INTEGER PRIMARY KEY,
   role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- DROP TABLE preferred_roles;


SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
   (1, 'Data Engineer'),
   (2, 'Senior Data Engineer'),
   (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;
   




-- ALTER TABLE

-- Add column
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

SELECT *
FROM staging.preferred_roles;


-- -- Drop Column
-- ALTER TABLE staging.preferred_roles
-- DROP COLUMN preferred_role;




-- UPDATE 
UPDATE  staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

SELECT *
FROM staging.preferred_roles;


UPDATE  staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;


SELECT *
FROM staging.preferred_roles;


ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;


SELECT *
FROM staging.priority_roles;


ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

SELECT *
FROM staging.priority_roles;


ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

SELECT *
FROM staging.priority_roles;


UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;
