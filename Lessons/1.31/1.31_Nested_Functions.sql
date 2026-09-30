-- Array Intro
SELECT ['python', 'sql', 'r'];

SELECT 'python' AS Skill
UNION ALL
SELECT 'sql'
UNION ALL
SELECT 'r';


-- converting the above query into an array
WITH skills AS(
    SELECT 'python' AS Skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
)
SELECT ARRAY_AGG(skill) AS skills_array
FROM skills;

--  OR using LIST()
WITH skills AS(
    SELECT 'python' AS Skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
)
SELECT LIST(skill) AS skills_array
FROM skills;

-- Accessing via Index
WITH skills AS(
    SELECT 'python' AS Skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS(
    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
    FROM skills
)
SELECT
    skills [1] AS first_skill,
    skills [2] AS second_skill,
    skills [3] AS third_skill
FROM skills_array;



-- STRUCT
SELECT {skill: 'python', type: 'programming'} AS skill_struct;.


SELECT
    STRUCT_PACK(
        skill := 'python',
        type := 'programming'
    )AS s;

--wrapping it up in a CTE
WITH skill_struct AS (
SELECT
    STRUCT_PACK(
        skill := 'python',
        type := 'programming'
    )AS s
)
SELECT 
    s.skill,
    s.type
FROM skill_struct;


WITH skill_table AS (
    SELECT 'python' AS Skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT 
    STRUCT_PACK(
        skill := skills,
        type := types
    )
FROM skill_table;



-- ARRAY of STRUCT
SELECT [
    { skill: 'python', type: 'programming'},
    { skill: 'sql', type: 'query_language'}
] AS skills_array_of_structs;





WITH skill_table AS (
    SELECT 'python' AS Skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := skills,
            type := types
        )
    )
FROM skill_table;


-- Accessing the items in our Array STRUCT
WITH skill_table AS (
    SELECT 'python' AS Skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
), skills_array_struct AS (
    SELECT
        ARRAY_AGG(
            STRUCT_PACK(
                skill := skills,
                type := types
            )
        ) AS array_struct
    FROM skill_table
)
SELECT
    array_struct [1],
    array_struct [2],
    array_struct [3]
FROM
    skills_array_struct;

-- Accessing the content inside each struct we use the dot(.) notation
WITH skill_table AS (
    SELECT 'python' AS Skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
), skills_array_struct AS (
    SELECT
        ARRAY_AGG(
            STRUCT_PACK(
                skill := skills,
                type := types
            )
        ) AS array_struct
    FROM skill_table
)
SELECT
    array_struct [1].skill,
    array_struct [2].type,
    array_struct [3]
FROM
    skills_array_struct;




-- MAP (in mapping, the key must be unique)
SELECT MAP {
    'skill': 'python',
    'type' : 'programming'
};

-- Accessing the value inside of MAP

WITH skill_map AS (
    SELECT MAP {
    'skill': 'python',
    'type' : 'programming'
    } AS skill_type
)
SELECT
    skill_type ['skill'],
    skill_type ['type']
FROM
    skill_map;



--JSON (it need to  be  double quote (""))
SELECT
    '{"skill": "python", "type":"programming"}':: JSON AS skill_json;



-- Now transforming thw above query from json to another datatype

WITH raw_skill_json AS (
        SELECT {
        'skill': 'python',
        'type' : 'programming'
    } :: JSON AS skill_json
)
SELECT
    STRUCT_PACK(
        skill := json_extract_string(skill_json, '$.skill'),
        type := json_extract_string(skill_json, '$.type')
    )
FROM raw_skill_json;



-- How to use in SQL
-- JSON to array of structs
WITH raw_json AS (
    SELECT
    '[
        {"skill": "python", "type": "programming"},
        {"skill": "sql", "type": "query_language"},
        {"skill": "r", "type": "programming"}
   ]'::JSON AS skills_json
)
SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := json_extract_string(e.value, '$.skill'),
            type := json_extract_string(e.value, '$.type')
        )
        ORDER BY json_extract_string(e.value, '$.skill')
    ) AS skills
FROM raw_json, json_each(skills_json) AS e;



-- ARRAYs Final Example
-- Build a flat skill table for co-workers to acess job titles, salary info, and skills in one table

SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg;


-- Putting this in a TEMP TABLE
CREATE OR REPLACE TEMP TABLE job_skills_array AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg;


-- From the perspective of a Data Analyst, analyze the median salary per skill
WITH flat_skills AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_array) AS skill
    FROM job_skills_array
)
SELECT
    skill,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
GROUP BY
    skill
ORDER BY median_salary DESC;



-- ARRAY of STRUCTS -  Final Example
-- Build a flat skill & type table for co-workers to access job titles, salary info, skills, and type in one table

CREATE OR REPLACE TEMP TABLE job_skills_array_struct AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(
        STRUCT_PACK(
            skill_type := sd.type,
            skill_name := sd.skills
        )
    )  AS skills_type
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg
;





-- From the perspective of a Data Analyst, analyze the median salary per type of skill

WITH flat_skills AS (
    SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    UNNEST(skills_type).skill_type AS skill_type,
    UNNEST(skills_type).skill_name AS skill_name
FROM 
    job_skills_array_struct
)
SELECT
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
GROUP BY
    skill_type;
-- ORDER BY median_salary DESC;