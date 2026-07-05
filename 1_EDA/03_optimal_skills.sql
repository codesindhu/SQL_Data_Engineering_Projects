/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1_000_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_country = 'India'
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) >= 100
ORDER BY
    optimal_score DESC
LIMIT 25;
/*
/*
Here's a breakdown of the most optimal skills for Data Engineers in India, based on both high demand and high salaries:

Key Insights:
- Python ranks as the most optimal skill with the highest overall optimal score (0.80), combining a strong median salary of $145K with high demand (242 postings).
- Spark secures the second position with an optimal score of 0.64, offering a $131.6K median salary and 133 job postings, making it one of the best big data technologies to learn.
- SQL remains a foundational skill, ranking third with an optimal score of 0.60. Despite a lower median salary of $110K, its high demand (236 postings) makes it indispensable for Data Engineers.
- Azure follows closely with an optimal score of 0.54, providing a $110K median salary and 137 postings, highlighting the growing demand for cloud expertise.
- AWS rounds out the top five with an optimal score of 0.48. Although it has the lowest median salary on this list ($96.8K), its strong demand (142 postings) makes it a valuable cloud platform to master.

Takeaway:
Python stands out as the best overall skill, offering the strongest balance of salary and market demand. Pairing Python with SQL, Spark, and a major cloud platform such as Azure or AWS creates a highly marketable skill set that aligns with the core technologies most employers seek in modern data engineering roles.
*/
┌─────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│ skills  │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│ varchar │    double     │    int64     │     double      │    double     │
├─────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python  │      145025.0 │          242 │             5.5 │           0.8 │
│ spark   │      131580.0 │          133 │             4.9 │          0.64 │
│ sql     │      110000.0 │          236 │             5.5 │           0.6 │
│ azure   │      110000.0 │          137 │             4.9 │          0.54 │
│ aws     │       96773.0 │          142 │             5.0 │          0.48 │
└─────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
*/