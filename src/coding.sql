WITH RECURSIVE rkd_order AS(
  SELECT year, name, 1 AS counter FROM cad
  UNION
  SELECT cad.year, cad.name, rkd_order.counter + 1
  FROM cad JOIN rkd_order
  ON cad.year-1 = rkd_order.year
  WHERE cad.name = rkd_order.name
),
max_rkd_order AS(
  SELECT year AS report_year, name, max(counter) AS consecutive_year 
  FROM rkd_order
  GROUP BY year, name
),
start_consecutive_years AS(
  SELECT  name, max(consecutive_year) AS consecutive_years, 
  report_year - consecutive_year AS start_year
  FROM max_rkd_order
  GROUP BY name, start_year)

  
SELECT *, start_year + consecutive_years AS end_year 
FROM start_consecutive_years 
ORDER BY name;
 
