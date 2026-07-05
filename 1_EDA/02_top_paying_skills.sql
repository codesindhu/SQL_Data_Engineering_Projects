/*
Question: What are the highest-paying skills for data engineers in India?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS meadian_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'India'
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 4000
ORDER BY meadian_salary DESC
LIMIT 20;

/*
Here's a breakdown of the most in-demand skills for Data Engineers in India:

Key Insights:
- SQL is the most in-demand skill with 29,766 job postings, offering a median salary of $110K.
- Python ranks second in demand with 27,049 postings and commands one of the highest median salaries among core skills at $145K.
- Airflow and Git share the highest median salary on this list at $147.5K, with strong demand (Airflow: 7,529 postings; Git: 4,537 postings).
- Other notable skills with both high salaries and strong demand include:
  - Kafka: $135K median salary (7,470 postings)
  - Java: $134.6K median salary (8,552 postings)
  - Tableau: $134.2K median salary (4,556 postings)
  - NoSQL: $132.9K median salary (5,970 postings)
  - Spark: $131.6K median salary (15,744 postings)
  - Snowflake: $131K median salary (8,534 postings)
- Cloud platforms continue to dominate the market:
  - Azure: $110K median salary (16,189 postings)
  - GCP: $105K median salary (7,060 postings)
  - AWS: $96.8K median salary (17,026 postings)
- Databricks, Redshift, Scala, and PySpark all appear in the top 20, each with thousands of job postings, highlighting their growing importance in modern data engineering.
- Unlike niche technologies, nearly every skill on this list has thousands of job postings, indicating both high demand and broad industry adoption.

Takeaway: SQL and Python remain the foundational skills every Data Engineer should master due to their exceptional demand. Pairing them with technologies like Spark, Kafka, Snowflake, Airflow, and a major cloud platform (AWS, Azure, or GCP) provides the strongest combination of employability, salary potential, and long-term career growth.

┌────────────┬────────────────┬──────────────┐
│   skills   │ meadian_salary │ demand_count │
│  varchar   │     double     │    int64     │
├────────────┼────────────────┼──────────────┤
│ airflow    │       147500.0 │         7529 │
│ git        │       147500.0 │         4537 │
│ python     │       145025.0 │        27049 │
│ kafka      │       135000.0 │         7470 │
│ java       │       134621.0 │         8552 │
│ tableau    │       134241.0 │         4556 │
│ nosql      │       132911.0 │         5970 │
│ spark      │       131580.0 │        15744 │
│ snowflake  │       131040.0 │         8534 │
│ hadoop     │       120705.0 │         8563 │
│ power bi   │       119750.0 │         4318 │
│ mongodb    │       119750.0 │         4520 │
│ sql        │       110000.0 │        29766 │
│ azure      │       110000.0 │        16189 │
│ gcp        │       105000.0 │         7060 │
│ scala      │        96773.0 │         8009 │
│ redshift   │        96773.0 │         5965 │
│ aws        │        96773.0 │        17026 │
│ databricks │        79200.0 │         9186 │
│ pyspark    │        72050.0 │         8331 │
└────────────┴────────────────┴──────────────┘
  20 rows                          3 columns
*/