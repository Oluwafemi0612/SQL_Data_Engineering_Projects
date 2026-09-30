-- LENGTH COUNT
SELECT LENGTH ('SQL');

SELECT CHAR_LENGTH ('SQL');

-- Case conversion
SELECT LOWER('SQL');

SELECT UPPER('sql');


-- Substring/Extraction
SELECT LEFT('SQL', 2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('SQL', 2, 2);

SELECT SUBSTRING('SQL', 2, 1);


-- Concatenation
SELECT CONCAT('SQL', '-', 'Functions');

SELECT 'SQL' || '-' || 'Functions';


-- Trimming

SELECT ' SQL ';

SELECT TRIM(' SQL ');

-- Replacement
SELECT REPLACE('SQL', 'Q', '_');

SELECT REGEXP_REPLACE('data.guru@gmail.com', '^.*(@)', '\1');



-- Final Example -Cleanup this using Text Functions
WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;


-- NULL Function
SELECT NULLIF(10,10);

SELECT NULLIF(10,20);

SELECT NULLIF(5 + 5, 20);


-- Use case
SELECT
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;



SELECT
    salary_year_avg,
    salary_hour_avg
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY salary_year_avg
LIMIT 10;


-- COALESCE
SELECT COALESCE (0, 1, 2);

SELECT COALESCE (NULL, 1, 2);

SELECT COALESCE (NULL, NULL, 2);


SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;


-- FINAL EXAMPLE - simplify with COALESCE


SELECT 
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
        CASE
            WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing'
            WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75_000 THEN 'Low'
            WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 150_000 THEN 'Medium'
            ELSE 'High'
        END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC;