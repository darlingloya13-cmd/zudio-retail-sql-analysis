USE zudio_retail_db;

-- Q1: Regional Footprint & Store Distribution by State
SELECT 
    state,
    COUNT(store_id) AS total_stores,
    COUNT(DISTINCT city) AS cities_covered,
    ROUND(AVG(estimated_population), 0) AS avg_city_population
FROM zudio_stores
GROUP BY state
ORDER BY total_stores DESC;

-- Q2: Top High-Priority Expansion Cities
SELECT 
    city,
    state,
    ROUND(AVG(priority_index), 4) AS avg_priority_index,
    ROUND(AVG(potential_location), 2) AS avg_potential,
    SUM(estimated_population) AS total_population
FROM zudio_stores
GROUP BY city, state
ORDER BY avg_priority_index DESC
LIMIT 10;

-- Q3: Economic Correlation (Per Capita Income vs. Buyer Base)
SELECT 
    CASE 
        WHEN per_capita_income < 150000 THEN 'Low Income (<150k)'
        WHEN per_capita_income BETWEEN 150000 AND 250000 THEN 'Mid Income (150k-250k)'
        ELSE 'High Income (>250k)'
    END AS income_bracket,
    COUNT(store_id) AS store_count,
    ROUND(AVG(buyers_count), 2) AS avg_buyers_count,
    ROUND(AVG(estimated_population), 0) AS avg_population
FROM zudio_stores
GROUP BY income_bracket
ORDER BY avg_buyers_count DESC;

-- Q4: Mall Density vs. Store Presence Analysis
SELECT 
    city,
    state,
    SUM(malls) AS total_malls,
    COUNT(store_id) AS zudio_store_count,
    ROUND(SUM(buyers_count), 0) AS total_buyers
FROM zudio_stores
GROUP BY city, state
HAVING total_malls > 0
ORDER BY total_malls DESC, zudio_store_count DESC
LIMIT 15;

-- Q5: Underserved High-Potential Markets
SELECT 
    city,
    state,
    ROUND(AVG(norm_potential), 4) AS avg_norm_potential,
    ROUND(AVG(norm_stores), 4) AS avg_norm_stores,
    ROUND(AVG(norm_potential - norm_stores), 4) AS untapped_opportunity_gap
FROM zudio_stores
GROUP BY city, state
HAVING avg_norm_potential > avg_norm_stores
ORDER BY untapped_opportunity_gap DESC
LIMIT 10;
