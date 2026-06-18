# NHS Emergency Department Attendance & Socioeconomic Risk Analysis

## Project Overview
This project analyses historical Accident & Emergency (A&E) department operational attendance patterns across England using official Office for National Statistics (ONS) census datasets. The objective was to investigate the systemic relationship between socioeconomic deprivation (IMD Deciles), occupational classifications (NS-SEC), clinical acuity tiers, and patient age demographics to isolate resource bottlenecks and support strategic healthcare planning.

## Tech Stack Used
* **Advanced Excel:** Raw data cleaning, quality assurance checks, string formatting standardisation, and age cohort percentage mapping.
* **SQL (SQLite Studio):** Schema type conversion (`CAST`), data scrubbing (`REPLACE`), multi-table demographic grouping (`GROUP BY`), correlated evaluation subqueries, and window function rankings (`ROW_NUMBER() OVER`).
* **Tableau Public:** Executive operational performance portals, demographic trend line charts, ranked horizontal bar matrices, and interactive multi-chart funnel filters.

## Core SQL Queries & Data Engineering
The production-ready scripts developed across the database schema (`EmrAge`, `SocioAge`, and `AcuitySocio` tables) include:
1. **Dynamic Age Cohort Engineering:** Injecting and updating structural marketing and medical age definitions into raw rows via a conditional `CASE WHEN` engine.
2. **Clinical Acuity Segmentations:** Filtering specific high-acuity (Urgent/Immediate) versus low-acuity (Minor/Standard) emergency volumes to isolate operational bottlenecks.
3. **Poverty Risk Aggregations:** Grouping cross-table records to calculate average attendance probabilities across distinct neighbourhood deprivation tiers (IMD Deciles).
4. **Outlier Demographic Subqueries:** Constructing a subquery execution block to isolate specific demographic records whose visit counts exceed global database averages.
5. **Window Function Risk Hierarchy:** Partitioning patient records by gender and age cohorts to rank clinical attendance velocities sequentially without squashing raw detail.

*All verified scripts can be viewed directly in the `healthcare_queries.sql` file in this repository.*

## Key Insights & Business Recommendations
* **Deprivation Driving Department Strain:** Operational profiling reveals an overwhelming concentration of A&E attendances within **IMD Decile 1 (Most Deprived)** communities. Crucially, this strain is heavily driven by low-acuity and standard-level emergency cases that do not require critical, life-saving hospital interventions. *Action Plan: Partner with local Integrated Care Boards (ICBs) to deploy targeted, community-based GP clinics and preventative health hubs within high-deprivation zones to deflect non-urgent A&E volume.*
* **The Under-5 Critical Disparity:** The dataset highlights a severe generational gap. **52.69% of children under 5 living in the most deprived areas** attend emergency departments, compared to just **6.46%** of children in the wealthiest deciles. *Action Plan: Develop an automated text-alert and educational outreach programme for new parents in Decile 1 post-discharge, directing them to local urgent treatment centres rather than emergency departments.*
* **Data Cleansing Impact:** Over half a million infant population records were successfully repaired by stripping text-based formatting strings and casting the fields back into operational mathematical integers to ensure baseline modeling accuracy.

## Live Interactive Dashboard
View and interact with the full dashboard online here:  
https://public.tableau.com/views/NHSEvaluatingSocioeconomicInequalitiesinAE/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
