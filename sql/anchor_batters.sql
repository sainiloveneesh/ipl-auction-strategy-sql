-- Anchor Batters Identification
-- Criteria:
-- 1. Balls faced >= 500
-- 2. Played more than 2 IPL seasons
-- 3. At least 1 dismissal
-- 4. Ranked by batting average

WITH batter_base AS (
    SELECT
        batter,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
        SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) AS runs_scored,
        SUM(wicket_ball) AS dismissals,
        COUNT(DISTINCT season) AS seasons_played
    FROM ipl_ball
    JOIN matches
        ON ipl_ball.match_id = matches.id
    GROUP BY batter
),

eligible_batters AS (
    SELECT *
    FROM batter_base
    WHERE balls_faced >= 500
      AND dismissals > 0
      AND seasons_played > 2
)

SELECT
    batter,
    runs_scored,
    dismissals,
    seasons_played,
    ROUND(runs_scored * 1.0 / dismissals, 2) AS batting_average
FROM eligible_batters
ORDER BY batting_average DESC;
