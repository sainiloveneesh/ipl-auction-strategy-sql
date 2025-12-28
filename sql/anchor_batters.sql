-- Anchor Batters Identification
-- Criteria:
-- 1. Balls faced >= 500
-- 2. At least 1 dismissal
-- 3. Played more than 2 seasons
-- 4. Ranked by batting average

WITH batsman_base AS (
    SELECT
        ipl_ball.batsman,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
        SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) AS runs_scored,
        SUM(wicket_ball) AS dismissals,
        COUNT(DISTINCT matches.season) AS seasons_played
    FROM ipl_ball
    JOIN matches
        ON ipl_ball.match_id = matches.id
    GROUP BY ipl_ball.batsman
),

eligible_batsmen AS (
    SELECT *
    FROM batsman_base
    WHERE balls_faced >= 500
      AND dismissals > 0
      AND seasons_played > 2
)

SELECT
    batsman,
    runs_scored,
    dismissals,
    seasons_played,
    ROUND(runs_scored * 1.0 / dismissals, 2) AS batting_average
FROM eligible_batsmen
ORDER BY batting_average DESC;
