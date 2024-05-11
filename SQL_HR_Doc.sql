USE [hr_database]
GO

SELECT * from general_data;

GO

CREATE PROCEDURE HR
AS
SELECT * from general_data;

EXEC HR

GO;

SELECT * from employee_survey_data$;

CREATE PROCEDURE esd
AS
SELECT * from employee_survey_data$;

EXEC esd


SELECT COUNT(EmpName) AS Total_number_Employees
FROM general_data;


SELECT DISTINCT JobRole
FROM general_data;


SELECT AVG(Age) AS Average_Age_Employes
FROM general_data;


SELECT EmpName, Age 
FROM general_data 
where YearsAtCompany>5;


SELECT COUNT(EmpName) AS Count_Employes, Department
from general_data
group by Department;


SELECT EmpName, 
CASE WHEN JobSatisfaction is not null or JobSatisfaction = 4 THEN 'HIGH'  
END as JobSatisfaction  
from general_data gd left join employee_survey_data$ esd 
on gd.EmployeeID=esd.EmployeeID ;


SELECT MAX(MonthlyIncome) AS Highest_monthly_income FROM general_data;


SELECT EmpName,BusinessTravel from general_data where BusinessTravel='Travel_Rarely';


SELECT DISTINCT MaritalStatus from general_data;


SELECT EmpName FROM general_data Where TotalWorkingYears>2 AND YearsAtCompany<4;

/* 11 th question miss */

;with CTE as (select EmpName,cast(JobLevel as varchar(100))+''+JobRole as UniqueID 
from general_data)
,CTE_1 AS (select a.EmpName,count(distinct UniqueID) counts
from CTE a
group by a.EmpName
having Count(Distinct UniqueID)>1)
select Distinct a.EmpName
from CTE_1 a
inner join general_data b on a.EmpName=b.EmpName
order by a.EmpName



SELECT  Department, AVG(DistanceFromHome) AS AverageDistanceFromHome from general_data GROUP BY Department;


SELECT TOP 5 EmpName, MAX(MonthlyIncome) AS TOP_MONTHLY_INCOME FROM general_data GROUP BY EmpName ORDER BY MAX(MonthlyIncome) DESC;


select EmpName, count(distinct JobRole) from general_data
group by EmpName
having count(distinct JobRole)>1
order by 2 desc




/* 14th missing */ 
SELECT
    sum(CASE WHEN YearsSinceLastPromotion > 0.00 THEN 1.00 ELSE 0.00 END ) AS promoted_count,
    COUNT(*) AS total_count,
    (sum(CASE WHEN YearsSinceLastPromotion > 0.00 THEN 1.00 ELSE 0.00 END) / COUNT(*)) * 100.00 AS promotion_percentage
FROM
    general_data;


SELECT EmpName, 
CASE WHEN  EnvironmentSatisfaction = 4 THEN 'HIGHEST' 
else 'LOWEST'
END as EnvironmentSatisfaction 
FROM general_data gd Right join employee_survey_data$ esd 
on gd.EmployeeID=esd.EmployeeID;

EXEC ESD


SELECT A.EmpName AS Employee1, 
B.EmpName AS Employee2, A.JobRole, A.MaritalStatus
FROM general_data A JOIN general_data B 
ON A.JobRole = B.JobRole 
AND A.MaritalStatus = B.MaritalStatus 
AND A.EmpName < B.EmpName;


SELECT EmpName,MAX(TotalWorkingYears) AS MAX_EORKING_DAYS, PerformanceRating=4
FROM general_data gd JOIN manager_survey_data$ msd on gd.EmployeeID=msd.EmployeeID
WHERE TotalWorkingYears = (SELECT MAX(TotalWorkingYears)
FROM general_data gd JOIN manager_survey_data$ msd on gd.EmployeeID=msd.EmployeeID
WHERE PerformanceRating = '4') group by EmpName;



SELECT BusinessTravel,AVG(Age) AS Average_Age, AVG(JobSatisfaction) AS Average_JobSatisfaction 
from general_data gd join employee_survey_data$ esd 
on gd.EmployeeID=esd.EmployeeID 
GROUP BY BusinessTravel;


SELECT TOP 1
EducationField,
COUNT(*) AS NumberOfEmployees
FROM general_data
GROUP BY EducationField
ORDER BY COUNT(*) DESC;


SELECT EmpName,MAX(YearsAtCompany) AS MAX_YEAR_AT_COMPANY 
from general_data 
WHERE YearsAtCompany=(SELECT MAX(YearsAtCompany) 
FROM general_data WHERE YearsSinceLastPromotion=0) 
GROUP BY EmpName;

EXEC HR
EXEC esd