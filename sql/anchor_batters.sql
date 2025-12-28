-- Anchor Batters Identification
-- Criteria:
-- 1. Balls faced >= 500 (excluding wides)
-- 2. At least 1 dismissal
-- 3. Ranked by batting average
-- Note: Season-level data not used due to dataset constraints

SELECT
    batsman,
    COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) AS balls_faced,
    SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) AS runs_scored,
    SUM(CASE WHEN is_wicket = 1 THEN 1 ELSE 0 END) AS dismissals,
    ROUND(
        SUM(CASE WHEN extras_type != 'wides' THEN batsman_runs ELSE 0 END) * 1.0 /
        SUM(CASE WHEN is_wicket = 1 THEN 1 ELSE 0 END),
        2
    ) AS batting_average
FROM IPL_Ball
GROUP BY batsman
HAVING
    COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) >= 500
    AND SUM(CASE WHEN is_wicket = 1 THEN 1 ELSE 0 END) > 0
ORDER BY batting_average DESC;
