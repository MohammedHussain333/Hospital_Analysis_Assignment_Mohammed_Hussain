
--create database
create database hospital;

--create table
drop table if exists hospital_file;
create table hospital_file(
	Hospital_Name varchar(100),
	Location varchar(100),
	Department varchar(100),
	Doctors_Count int,
	Patients_Count int,
	Admission_Date date,
	Discharge_Date date,
	Medical_Expenses numeric(10,2)
);

SELECT * FROM hospital_file;

--import csv data to sql query tool.
copy hospital_file(Hospital_Name, Location, Department, Doctors_Count, Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses)
from '/System/Volumes/Data/macOS Install Data/UpdateBundle/AssetData/boot/usr/Hospital_file.csv'
csv header;

--To the whole table.

SELECT * FROM hospital_file;

--Write an SQL query to find the total number of patients across all hospitals.

SELECT SUM(patients_count) AS total_patients
FROM hospital_file;

--Retrieve the average count of doctors available in each hospital.

SELECT  hospital_name, AVG(doctors_count) AS average_count_of_doctors
FROM hospital_file
GROUP BY hospital_name;

--Find the top 3 hospital departments that have the highest number of patients.

SELECT department, SUM(patients_count) as Highest_number_patients
FROM hospital_file
GROUP BY department
ORDER BY Highest_number_patients DESC
LIMIT 3;

--Identify the hospital that recorded the highest medical expenses.

SELECT hospital_name, medical_expenses
FROM hospital_file
ORDER BY medical_expenses DESC
LIMIT 1;

--Calculate the average medical expenses per day for each hospital.

SELECT hospital_name, medical_expenses, admission_date, discharge_date,
    (medical_expenses / (discharge_date - admission_date)) AS avg_expense_per_day
FROM hospital_file;

--Find the patient with the longest stay by calculating the difference between
--Discharge Date and Admission Date.

SELECT hospital_name, admission_date, discharge_date,
    (discharge_date - admission_date) AS stay_days
FROM hospital_file
ORDER BY stay_days DESC
LIMIT 1;

--Count the total number of patients treated in each city.

SELECT location, SUM(patients_count) AS total_number_of_patients_each_city
FROM hospital_file
GROUP BY location
ORDER BY total_number_of_patients_each_city desc;

--Calculate the average number of days patients spend in each department.

SELECT department, AVG(discharge_date - admission_date) AS average_days_spend
FROM hospital_file
GROUP BY department;

--Find the department with the least number of patients.

SELECT department, SUM(patients_count) AS least_patients
FROM hospital_file
GROUP BY department
ORDER BY least_patients ASC
LIMIT 1;

--Group the data by month and calculate the total medical expenses for each month.

SELECT TO_CHAR(admission_date, 'YYYY-MM') AS month, SUM(medical_expenses) AS total_expenses
FROM hospital_file
GROUP BY month
ORDER BY month;













