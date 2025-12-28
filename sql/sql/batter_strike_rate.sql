-- Batting Strike Rate Calculation
-- Wides excluded from balls faced and runs

WITH batter_stats AS (
    SELECT
        batter,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
        SUM(
            CASE 
                WHEN extras_type != 'wides' THEN batsman_runs 
                ELSE 0 
            END
        ) AS runs_scored
    FROM ipl_ball
    GROUP BY batter
    HAVING COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) >= 500
)

SELECT
    batter,
    balls_faced,
    runs_scored,
    ROUND((runs_scored * 100.0) / balls_faced, 2) AS strike_rate
FROM batter_stats
ORDER BY strike_rate DESC;
