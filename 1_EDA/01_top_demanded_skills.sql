/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to their required skills via the skills bridge and dimension tables
- Identify the top 10 in-demand skills for data engineers
- Focus on job postings in India
- Why? Retrieves the top 10 skills with the highest demand in the Indian job market,
    providing insights into the most valuable skills for data engineers seeking work
*/

SELECT 
    sd.skills,
    COUNT(*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'India'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers in India:
SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~17,000 postings, followed by Azure at ~16,000.
Apache Spark completes the top 5 with nearly 15,000 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark,Hadoop,Pyspark continue to be highly valued
- Data pipeline tools (Databricks,Snowflake) show growing demand
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29766 │
│ python     │        27049 │
│ aws        │        17026 │
│ azure      │        16189 │
│ spark      │        15744 │
│ databricks │         9186 │
│ hadoop     │         8563 │
│ java       │         8552 │
│ snowflake  │         8534 │
│ pyspark    │         8331 │
└────────────┴──────────────┘
  10 rows         2 columns
*/