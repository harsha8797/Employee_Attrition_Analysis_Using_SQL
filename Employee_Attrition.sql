CREATE DATABASE hr_employee_attrition;

CREATE TABLE hr_employee_attrition (
    EmployeeID SERIAL PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

--#1 Descriptive Analysis of Monthly Income--

SELECT * FROM hr_employee_attrition LIMIT 5;

SELECT 
    AVG(MonthlyIncome) AS average_income,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income
FROM hr_employee_attrition;

--#2 Overall Attriution Rate--

SELECT 
    (COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)::FLOAT / COUNT(*)) * 100 AS attrition_rate_percentage
FROM hr_employee_attrition;

--#3 Department-wise Attrition Rate---

SELECT 
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)::FLOAT / COUNT(*) * 100 AS attrition_rate_percentage
FROM hr_employee_attrition
GROUP BY Department
ORDER BY attrition_rate_percentage DESC;

--#4 Attrition Rate by Age Group--

SELECT CASE 
         WHEN Age BETWEEN 18 AND 30 THEN '18-30'
         WHEN Age BETWEEN 31 AND 40 THEN '31-40'
         WHEN Age BETWEEN 41 AND 50 THEN '41-50'
         WHEN Age > 50 THEN '51+'
       END AS AgeGroup,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / CAST(COUNT(*) AS FLOAT)) * 100 AS AttritionRate
FROM hr_employee_attrition
GROUP BY AgeGroup;


--#5 Salary Analysis by role and attrition--

SELECT 
    JobRole,
    Attrition,
    AVG(MonthlyIncome) AS average_monthly_income
FROM hr_employee_attrition
GROUP BY JobRole, Attrition
ORDER BY JobRole, Attrition;

--#6 Analysis by Education and Attrition--

SELECT 
    CASE Education 
        WHEN 1 THEN 'Below College'
        WHEN 2 THEN 'College'
        WHEN 3 THEN 'Bachelor'
        WHEN 4 THEN 'Master'
        WHEN 5 THEN 'Doctor'
    END AS education_level,
    Attrition,
    COUNT(*) AS number_of_employees
FROM hr_employee_attrition
GROUP BY Education, Attrition
ORDER BY Education, Attrition;

--#7 Tenure Analysis--

SELECT 
    AVG(YearsAtCompany) AS average_years_at_company,
    MIN(YearsAtCompany) AS min_years_at_company,
    MAX(YearsAtCompany) AS max_years_at_company
FROM hr_employee_attrition
WHERE Attrition = 'Yes';


--#8 Impact of Business Travel on Attrition--

SELECT 
    BusinessTravel,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)::FLOAT / COUNT(*)) * 100 AS attrition_rate_percentage
FROM hr_employee_attrition
GROUP BY BusinessTravel
ORDER BY attrition_rate_percentage DESC;


--#9 Impact of Performance Rating on Attrition--

SELECT 
    PerformanceRating,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)::FLOAT / COUNT(*)) * 100 AS attrition_rate_percentage
FROM hr_employee_attrition
GROUP BY PerformanceRating
ORDER BY PerformanceRating;

--#10 Work-Life Balance Analysis--

SELECT Department, AVG(WorkLifeBalance) AS AverageWorkLifeBalance
FROM hr_employee_attrition
GROUP BY Department;

--Career Progression Analysis--
--#11 Average years since the last promotion by job role--

SELECT JobRole, AVG(YearsSinceLastPromotion) AS AverageYearsSinceLastPromotion
FROM hr_employee_attrition
GROUP BY JobRole;

--Mobility and stability analysis--
--#12 Average number of companies worked by age group--

SELECT CASE 
         WHEN Age BETWEEN 18 AND 30 THEN '18-30'
         WHEN Age BETWEEN 31 AND 40 THEN '31-40'
         WHEN Age BETWEEN 41 AND 50 THEN '41-50'
         WHEN Age > 50 THEN '51+'
       END AS AgeGroup,
       CEIL(AVG(NumCompaniesWorked)) AS AverageCompaniesWorked
FROM hr_employee_attrition
GROUP BY AgeGroup;











