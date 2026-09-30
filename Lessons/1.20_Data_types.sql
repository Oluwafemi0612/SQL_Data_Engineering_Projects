SELECT
    table_name,
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'job_postings_fact';


DESCRIBE job_postings_fact;

DESCRIBE
SELECT
    job_title_short,
    salary_year_avg
FROM
    job_postings_fact;


-- CAST OPERATOR

SELECT CAST(123 AS VARCHAR);


SELECT CAST('123DEF' AS INTEGER);




SELECT
    CAST(job_id AS VARCHAR), --"more" Unique identifier
    CAST(company_id AS VARCHAR),
    CAST(job_work_from_home AS INT) AS job_work_from_home, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_posted_date, --from timestamp to date only 
    CAST(salary_year_avg AS DECIMAL (10, 0)) AS salary_year_avg  -- from double to no decimal places
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;



-- To concat the job_id and the company_id column after changing their data type from INT to VARCHAR

SELECT
    CAST(job_id AS VARCHAR)  || CAST(company_id AS VARCHAR), --"more" Unique identifier
    CAST(job_work_from_home AS INT) AS job_work_from_home, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_posted_date, --from timestamp to date only 
    CAST(salary_year_avg AS DECIMAL (10, 0)) AS salary_year_avg  -- from double to no decimal places
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;



SELECT
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), --"more" Unique identifier
    CAST(job_work_from_home AS INT) AS job_work_from_home, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_posted_date, --from timestamp to date only 
    CAST(salary_year_avg AS DECIMAL (10, 0)) AS salary_year_avg  -- from double to no decimal places
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;



-- Another way to cast on DuckDb below
SELECT
    job_id::VARCHAR || '-' || company_id::VARCHAR, --"more" Unique identifier
    job_work_from_home::INT AS job_work_from_home, -- from boolean to numeric value
    job_posted_date::DATE AS job_posted_date, --from timestamp to date only 
    salary_year_avg::DECIMAL (10, 0) AS salary_year_avg  -- from double to no decimal places
FROM
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;


SELECT (3 + 5.5)::FLOAT;

SELECT (3 + 5.5)::INT;