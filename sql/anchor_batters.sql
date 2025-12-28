-- Anchor Batters Identification
-- Criteria:
-- 1. Balls faced >= 500 (excluding wides)
-- 2. At least 1 dismissal
-- 3. Played more than 2 seasons
-- 4. Ranked by batting average

WITH batsman_base AS (
    SELECT
        b.batsman,
        COUNT(CASE WHEN b.extras_type != 'wides' THEN 1 END) AS balls_faced,
        SUM(CASE WHEN b.extras_type != 'wides' THEN b.batsman_runs ELSE 0 END) AS runs_scored,
        SUM(CASE WHEN b.is_wicket = 1 THEN 1 ELSE 0 END) AS dismissals,
        COUNT(DISTINCT strftime('%Y', m.date)) AS seasons_played
    FROM IPL_Ball b
    JOIN IPL_matches m
        ON b.id = m.id
    GROUP BY b.batsman
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
