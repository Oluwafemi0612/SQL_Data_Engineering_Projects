/*
Question
- What are the most in demand skills for data engineers?
- Focus on remote job posting
- Why?
    - Retrives the top 10 skills with the highest demant in the remote job market, providing insights into the most valuable skills for data engineers seeking remote work */

SHOW TABLES;

SELECT DISTINCT *
FROM skills_job_dim;


SELECT DISTINCT *
FROM skills_dim;



SELECT sd.skills,
  COUNT(jfp.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
  ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
  ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' 
  AND jpf.job_work_from_home = TRUE
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are the most in-demand skills, with over 29000 for SQL and ~ 29000 for Python- nearly double the next skill.
Cloud platforms round out the top skills, with AWS leading at ~ 18000 postings, followed by Azure at ~14000.
Apache Spark makes the top 5 with nearly ~13000 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills


┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
*/