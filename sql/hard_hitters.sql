-- Hard Hitters Identification
-- Based on Boundary Percentage
-- Criteria:
-- 1. Balls faced >= 500 (excluding wides)
-- 2. Boundary Percentage = (Runs from 4s and 6s / Total Runs) * 100

SELECT
    batsman,
    COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
    SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) AS total_runs,
    SUM(
        CASE 
            WHEN batsman_runs IN (4, 6) THEN batsman_runs 
            ELSE 0 
        END
    ) AS boundary_runs,
    ROUND(
        SUM(CASE WHEN batsman_runs IN (4, 6) THEN batsman_runs ELSE 0 END) * 100.0 /
        SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END),
        2
    ) AS boundary_percentage
FROM IPL_Ball
GROUP BY batsman
HAVING
    COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) >= 500
    AND SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) > 0
ORDER BY boundary_percentage DESC;
