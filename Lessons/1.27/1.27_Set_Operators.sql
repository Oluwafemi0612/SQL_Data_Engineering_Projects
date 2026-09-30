-- UNION
SELECT UNNEST([1, 1, 1, 2])
UNION
SELECT UNNEST([1, 1, 3]);


-- UNION ALL
SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]);


-- INTERSECT
SELECT UNNEST([1, 1, 1, 2])
INTERSECT
SELECT UNNEST([1, 1, 3]);


-- INTERSECT ALL
SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);


-- EXCEPT also known as Minus in some Database (e.g oracle)
SELECT UNNEST([1, 1, 1, 2])
EXCEPT
SELECT UNNEST([1, 1, 3]);


-- EXCEPT ALL
SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);


-- Final Example
CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE(job_id, job_posted_date) -- this EXCLUDE clause is specific to DuckDB at the time of writing this query
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT *
FROM jobs_2023;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE(job_id, job_posted_date) -- this EXCLUDE clause is specific to DuckDB at the time of writing this query
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT *
FROM jobs_2024;

-- Which Unique job postings appeared in either 2023 0r 2024
SELECT 
    'jobs_2023' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2023
UNION
SELECT
    'jobs_2024' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2024;


SELECT *
FROM jobs_2023
UNION
SELECT *
FROM jobs_2024;

-- Which job Postings appeared across both years, counting duplicates

SELECT *
FROM jobs_2023
UNION ALL
SELECT *
FROM jobs_2024;


-- Which job posting appeared in 2023 byut not in 2024

SELECT *
FROM jobs_2023
EXCEPT
SELECT *
FROM jobs_2024;


-- Which job postings from 2023 remain after substracting matching 2024 postings, one-for-one?

SELECT *
FROM jobs_2023
EXCEPT ALL
SELECT *
FROM jobs_2024;

-- Which job postings appear in both 2023 and 2024?
SELECT *
FROM jobs_2023
INTERSECT
SELECT *
FROM jobs_2024;


-- which job postings appeared in both years, preserving duplictaes counts?
SELECT *
FROM jobs_2023
INTERSECT ALL
SELECT *
FROM jobs_2024;