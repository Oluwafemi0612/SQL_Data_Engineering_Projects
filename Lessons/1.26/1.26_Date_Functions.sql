SELECT
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestamptz
FROM
    job_postings_fact
LIMIT 10;


-- EXTRACT
SELECT
    job_posted_date,
    EXTRACT (YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT (MONTH FROM job_posted_date) AS job_posted_month,
    EXTRACT (DAY FROM job_posted_date) AS job_posted_day
FROM job_postings_fact
LIMIT 10;


-- Let sat we want to know the total number of job posting for a Specifit job title
SELECT
    EXTRACT (YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT (MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY 
    job_posted_year, --only DuckDB allow us to usr the alias here
    job_posted_month;


-- How i can write this above query in other Database like MySQL
SELECT
    EXTRACT (YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT (MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY 
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY
    job_posted_year,
    job_posted_month;



-- DATE _TRUNCATE or DATE TRUNC

SELECT
    job_posted_date,
    DATE_TRUNC('year', job_posted_date) AS truncated_year,
    DATE_TRUNC('quarter', job_posted_date) AS truncated_quarter,
    DATE_TRUNC('month', job_posted_date) AS truncated_month,
    DATE_TRUNC('week', job_posted_date) AS truncated_week,
    DATE_TRUNC('day', job_posted_date) AS truncated_day,
    DATE_TRUNC('hour', job_posted_date) AS truncated_hour
FROM
    job_postings_fact
ORDER BY RANDOM()
LIMIT 10;


-- Using the DATE_TRUNC on the EXTRACT query

SELECT
    DATE_TRUNC ('month',job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND
    EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY 
    DATE_TRUNC ('month',job_posted_date)
ORDER BY
    job_posted_month;


SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ;

SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'CST';

-- To EST
SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';


SELECT
    job_posted_date
FROM job_postings_fact
LIMIT 10;

-- Converting job_posted_date time zone  from 'UTC' to 'EST'
SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
LIMIT 10;


SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
WHERE job_location LIKE 'New York, NY';



SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS job_posted_hour,
    COUNT(job_id)
FROM job_postings_fact
WHERE job_location LIKE 'New York, NY'
GROUP BY EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')
ORDER BY job_posted_hour;