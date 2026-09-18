 SELECT
    jpf.*,
    cd.*
 FROM
    job_postings_fact AS jpf

LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;



 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf

LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;


SELECT
    COUNT(*)
FROM
    job_postings_fact;


 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf

LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;


 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf

RIGHT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;



 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf

INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;



 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf
-- inner Join is the default join (so writing only JOIN is thesame with INNER JOIN)
JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;



 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf
FULL OUTER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;



 SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
 FROM
    job_postings_fact AS jpf
FULL JOIN company_dim AS cd --FULL OUTER JOIN and FULL JOIN does thesame thing, it returns rows and columns in both table
    ON jpf.company_id = cd.company_id;


SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;


SELECT
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
LIMIT 10;




SELECT
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;



SELECT
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;


SELECT
jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills
FROM job_postings_fact AS jpf
FULL JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
FULL JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;


-- Query Processing