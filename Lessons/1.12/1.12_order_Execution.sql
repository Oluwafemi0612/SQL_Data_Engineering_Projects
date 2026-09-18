SELECT *
FROM job_postings_fact
LIMIT 10;

/*
Find the top 10 companies for posting jobs
They must have greater than (>)3000 posting
LIMIT this to only US jobs
*/

SHOW TABLES;

SELECT *
FROM company_dim;



SELECT 
    cd.name AS company_name,
    COUNT(jpf.*)
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id ) > 3000;



SELECT 
    cd.name AS company_name,
    COUNT(*)
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id ) > 3000;



SELECT 
    cd.name AS company_name,
    COUNT(*) AS job_posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id ) > 3000
ORDER BY job_posting_count DESC;



EXPLAIN
SELECT 
    cd.name AS company_name,
    COUNT(jpf) AS job_posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id ) > 3000
ORDER BY job_posting_count DESC;


EXPLAIN ANALYSE
SELECT 
    cd.name AS company_name,
    COUNT(jpf.*) AS job_posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id ) > 3000
ORDER BY job_posting_count DESC
LIMIT 10;