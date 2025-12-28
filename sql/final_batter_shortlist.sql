-- Final Batter Shortlist
-- Combine Aggressive, Anchor, and Hard Hitters
-- Select top players from each category for auction consideration

WITH aggressive AS (
    SELECT batter
    FROM aggressive_batters
),

anchors AS (
    SELECT batter
    FROM anchor_batters
),

hard_hitters AS (
    SELECT batter
    FROM hard_hitters
)

SELECT DISTINCT batter
FROM (
    SELECT batter FROM aggressive
    UNION
    SELECT batter FROM anchors
    UNION
    SELECT batter FROM hard_hitters
) shortlisted_batters
ORDER BY batter;
