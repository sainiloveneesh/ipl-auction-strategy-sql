-- Batter Eligibility
-- Minimum balls faced: 500 (excluding wides)

SELECT
    batsman,
    COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
    SUM(batsman_runs) AS total_runs
FROM ipl_ball
GROUP BY batsman
HAVING COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) >= 500
ORDER BY total_runs DESC;
