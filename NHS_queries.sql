-- Query 1: Add categorical age cohort attribute to the schema
ALTER TABLE EmrAge ADD AgeGroup VARCHAR(30);


-- Query 2: Populate AgeGroup classifications based on NHS demographic cohorts
UPDATE EmrAge
SET AgeGroup = CASE 
    WHEN Age < 3 THEN 'Infants and toddlers'
    WHEN Age < 11 THEN 'Children'
    WHEN Age < 19 THEN 'Adolescents' 
    WHEN Age < 49 THEN 'Adults'
    ELSE 'Senior'
END;


-- Query 3: Standardise attendance numeric text entries into database integers
UPDATE EmrAge
SET Total_emergency_department_attendances = REPLACE(Total_emergency_department_attendances, ',', '');


-- Query 4: Calculate total A&E visit volumes across engineered age categories
SELECT 
    AgeGroup, 
    SUM(CAST(Total_emergency_department_attendances AS INTEGER)) AS TotalEmergencyVisits
FROM EmrAge
GROUP BY AgeGroup
ORDER BY TotalEmergencyVisits DESC;


-- Query 5: Aggregate baseline attendance percentages by socioeconomic deprivation levels
SELECT 
    Level,
    AVG(CAST(Percentage AS REAL)) AS AverageAttendancePercentage
FROM SocioAge
GROUP BY Level
ORDER BY AverageAttendancePercentage DESC;


-- Query 6: Audit relative emergency risk probabilities across demographic dimensions
SELECT 
    Level, 
    Age_Group, 
    Emergency_attendance_type, 
    CAST(Ods_ratio AS REAL) AS Cleaned_Odds_Ratio
FROM SocioAge
ORDER BY Cleaned_Odds_Ratio DESC;


-- Query 7: Cross-reference clinical acuity outcomes against deprivation tiers
SELECT 
    Emergency_attendance_type,
    Level, 
    AVG(CAST(Ods_ratio AS REAL)) AS Average_Odds_Ratio
FROM AcuitySocio
GROUP BY Level, Emergency_attendance_type
ORDER BY Average_Odds_Ratio DESC;


-- Query 8: Isolate high-acuity urgent medical risks across socioeconomic groups
SELECT 
    Level, 
    Emergency_attendance_type, 
    CAST(Ods_ratio AS REAL) AS Cleaned_Odds_Ratio
FROM AcuitySocio
WHERE Emergency_attendance_type LIKE '%Urgent%' 
   OR Emergency_attendance_type LIKE '%immediate%'
ORDER BY Cleaned_Odds_Ratio DESC;


-- Query 9: Evaluate minor and standard clinical emergency volumes by social class
SELECT 
    Emergency_attendance_type, 
    Level, 
    CAST(Ods_ratio AS REAL) AS Cleaned_Odds_Ratio
FROM AcuitySocio
WHERE Emergency_attendance_type LIKE '%low%' 
   OR Emergency_attendance_type LIKE '%standard%'
ORDER BY Cleaned_Odds_Ratio DESC;


-- Query 10: Standardise national baseline population values into database integers
UPDATE EmrAge
SET Total_population = REPLACE(Total_population, ',', '');


-- Query 11: Track peak infant emergency department operational strain under age 1
SELECT 
    Age AS InfantsUnder1, 
    ROUND(AVG(CAST(Percentage AS REAL)), 2) AS EmrgAttendancePercentage, 
    AVG(CAST(Total_population AS INTEGER)) AS EstimatePopulationCount, 
    Sex
FROM EmrAge
WHERE Age < 1
GROUP BY Sex;


-- Query 12: Isolate high-volume age segments exceeding global database averages
SELECT 
    AgeGroup, 
    ROUND(AVG(CAST(Total_emergency_department_attendances AS INTEGER)), 2) AS AverageVisitsOfGroup
FROM EmrAge
WHERE CAST(Total_emergency_department_attendances AS INTEGER) > (
    SELECT AVG(CAST(Total_emergency_department_attendances AS INTEGER)) 
    FROM EmrAge
)
GROUP BY AgeGroup;


-- Query 13: Execute row-level window function rankings across gender profiles
SELECT  
    Sex, 
    AgeGroup, 
    CAST(Total_emergency_department_attendances AS INTEGER) AS RawVisits,
    ROW_NUMBER() OVER(
        PARTITION BY Sex 
        ORDER BY CAST(Total_emergency_department_attendances AS INTEGER) DESC
    ) AS RankByAttendance
FROM EmrAge;







