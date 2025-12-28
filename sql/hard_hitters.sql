-- Hard Hitter Identification
-- Based on Boundary Percentage

WITH batter_stats AS (
    SELECT
        batter,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
        SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) AS total_runs,
        SUM(
            CASE 
                WHEN batsman_runs IN (4,6) THEN batsman_runs 
                ELSE 0 
            END
        ) AS boundary_runs,
        COUNT(DISTINCT season) AS seasons_played
    FROM ipl_ball
    JOIN matches
        ON ipl_ball.match_id = matches.id
    GROUP BY batter
),

eligible_batters AS (
    SELECT *
    FROM batter_stats
    WHERE balls_faced >= 500
      AND total_runs > 0
      AND seasons_played > 2
)

SELECT
    batter,
    total_runs,
    boundary_runs,
    seasons_played,
    ROUND((boundary_runs * 100.0) / total_runs, 2) AS boundary_percentage
FROM eligible_batters
ORDER BY boundary_percentage DESC;
