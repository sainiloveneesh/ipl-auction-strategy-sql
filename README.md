# IPL Auction Strategy Using SQL

## Business Problem
A new IPL franchise is entering the league and must build a strong, balanced squad within a fixed auction budget.
The objective is to design a data-driven auction strategy by analyzing historical IPL data to identify high-value
players across different roles (batters, bowlers, all-rounders, wicketkeepers).

## Dataset
The analysis uses publicly available IPL datasets covering seasons from 2008 to 2020, including:
- Match-level data (venues, dates, teams)
- Ball-by-ball delivery data (runs, wickets, extras)

Source: Public IPL datasets (Kaggle)

## Key Metrics & Assumptions
- **Batting Strike Rate** = Total runs / Balls faced  
  (Wides excluded from balls faced and runs)
- **Batting Average** = Total runs / Number of dismissals
- **Boundary Percentage** = Runs scored via boundaries / Total runs
- **Bowling Economy** = Runs conceded / Overs bowled
- **Bowling Strike Rate** = Balls bowled / Wickets taken

Minimum eligibility thresholds were applied (e.g., balls faced/bowled ≥ 500) to ensure consistency and reliability.

## Analysis Approach
1. Cleaned and prepared IPL match and delivery-level data
2. Defined role-specific criteria for player evaluation
3. Used SQL queries to calculate performance metrics
4. Shortlisted players based on role requirements and value-for-money logic
5. Generated summary tables to support auction decision-making

## Player Shortlisting Logic
- **Aggressive Batters**: High strike rate, sufficient balls faced
- **Anchor Batters**: Strong batting average and experience
- **Hard Hitters**: High boundary contribution
- **Economical Bowlers**: Low economy rate with sufficient workload
- **Wicket-Taking Bowlers**: Low bowling strike rate
- **All-Rounders**: Balanced batting and bowling contributions
- **Wicketkeepers**: Defined based on batting impact and consistency

## Key Insights
- A small group of players contribute disproportionately to match impact
- Several value-for-money players outperform higher-priced alternatives
- Balanced squads require mixing high-impact stars with consistent performers

## Final Recommendation
The analysis recommends a diversified auction strategy that prioritizes:
- Performance consistency
- Role balance
- Budget efficiency

This approach helps the franchise maximize on-field impact while maintaining financial discipline.

## Tools Used
- SQL
- Excel (for validation and summaries)

## Sample Outputs

Below are sample outputs from the analysis:

- **Batsman Eligibility**: Identifies players with sufficient sample size (500+ balls).
- **Strike Rate Analysis**: Highlights aggressive scorers suitable for power roles.
- **Aggressive Batters**: Batters with strike rate ≥ 140.
- **Anchor Batters**: Consistent batters ranked by batting average.
- **Hard Hitters**: Players with high boundary contribution percentage.

These outputs demonstrate how different batting roles were identified using
role-specific performance metrics.

