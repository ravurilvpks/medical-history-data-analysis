USE project_medical_data_history;
SHOW tables;
Describe patients;
describe admissions;
describe doctors;
describe province_names;
select* from admissions limit 10;
select * from doctors limit 10;
select * from patients limit 10;
select * from province_names limit 10;
SELECT COUNT(*) AS total_patients
from patients;
select count(*) as total_admissions
from admissions;
select count(*) as total_provinces
from province_names;
select count(*) as total_doctors 
from doctors;
SELECT
 SUM(patient_id is null), 
 sum(first_name is null),
 sum( last_name is null),
 sum(gender is null),
 sum(birth_date is null),
 sum(height is null),
 sum(weight is null),
 sum(city is null),
 sum(province_id is null),
 sum(allergies is null)
 from patients;
 select
 sum(patient_id is null),
 sum(admission_date is null),
 sum(discharge_date is null),
 sum(attending_doctor_id is null),
 sum(diagnosis is null)
 from admissions;
 select
  sum(doctor_id is null),
  sum(first_name is null),
  sum(last_name is null),
  sum(specialty is null)
  from doctors;
  select 
   sum(province_id is null),
   sum(province_name is null)
   from province_names; 
select patient_id, COUNT(*) AS COUNT
FROM patients
GROUP BY patient_id
HAVING COUNT(*)>1;
SELECT DOCTOR_ID, count(*) as count
from doctors
group by doctor_id
having count(*)>1;
SELECT province_id, COUNT(*) as count
from province_names
group by province_id
having count(*)>1;
SELECT patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id, count(*) as count
from admissions
group by patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id
having count(*)>1;
select distinct p.province_id
from patients p
left join province_names pn
on p.province_id = pn.province_id
where pn.province_id is null;
select distinct a.attending_doctor_id
from admissions a
left join doctors d
on a.attending_doctor_id=d.doctor_id
where d.doctor_id is null;
select count(*) as empty_first_name
from patients
where first_name=' ';
select count(*) as empty_last_name
from patients
where last_name=' ';
select count(*) as empty_city
from patients
where city=' ';
select count(*) as empty_allergies
from patients
where allergies=' ';
select * from patients where height<=0;
select * from patients where weight<=0;
select * from patients where birth_date is null;
select * from admissions where discharge_date< admission_date ;
select discharge_date, count(*) as total_records from admissions
where discharge_date<admission_date
group by discharge_date
order by total_records desc;
-- Query 1
-- Shoe first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name,gender
from patients
where gender= 'M';
-- Query 2
-- Show first name and last name of patients who does not have allergies.
select first_name,last_name
from patients
where allergies is null;
-- Query 3
-- Show first_name of patients that start with the letter 'C' "
select first_name from patients
where first_name like 'C%';
-- Query 4
-- Show first name and last name of patients that weight within the range od 100 to 120 (inclusive)"
select first_name, last_name
from patients 
where weight Between 100 AND 120;
-- Query 5
-- "Update the patients table for the alleries column. If the patient's alleries is null then replace it with 'NKA' "
SELECT COUNT(*) AS NULL_ALLERGIES FROM patients WHERE ALLERGIES IS NULL;
-- Query 6 
-- Show first name and last name concatenated into one column to show their full name."
select CONCAT(first_name, ' ', last_name) as full_name
from patients;
-- Query 7
-- Show first name, last name, and the full province name of each patient.
select 
p.first_name,
p.last_name,
pn.province_name
from patients p
join province_names pn 
on p.province_id = pn.province_id;
-- Query 8 
-- Show how many patients have a birth_date with 2010 as birth year.
select 
count(*) as total_patients from patients where year(birth_date)=2010;
-- Query 9 
-- Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, height 
from patients
where height =(select max(height) from patients);
-- Query 10
-- show all columns for patients who have one of the following patient_ids:1,45,535,879,1000"
select * from patients
where patient_id in (1, 45,535,879,1000);
-- Query 11
-- Show the total number of admissions
select count(*) as total_admissions 
from admissions;
-- Query 12
-- Show all the columns from admissions where the patients was admitted and discharged on the same day
select * from admissions 
where admission_date= discharge_date;
-- Query 13
-- Show the total number of admissions for patient_id 579.
select count(*) as total_admission
from admissions 
where patient_id ='579';
-- Query 14
-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct city from patients
where province_id ='NS';
-- Query 15 
-- Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70"
select 
first_name,last_name, birth_date
from patients
where height>160 and weight>70;
-- Query 16
-- Show unique birth years from patients and order them by ascending."
select distinct year(birth_date) as birth_year from patients
order by birth_year asc;
-- Query 17
-- Show unique first names from the patients table which only occurs once in the list."
select distinct first_name from patients
group by first_name
having count(*)=1;
-- Query 18
-- Show patient_id and first_name from patients where their first_name start and ends with "s" and is at least 6 characters long."
select patient_id, first_name from patients
where first_name like 's%s'
and char_length(first_name)>=6;
-- Query 19
-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table." 
select distinct 
p.patient_id,
p.first_name,
p.last_name
from patients p
join admissions a 
on p.patient_id=a.patient_id
where a.diagnosis='Dementia';
-- Query 20
-- Display every patient's first_name. Order the list by the length of each name and then by alphbetically."
select first_name
from patients
order by 
char_length(first_name)asc,
first_name asc;
-- Query 21
-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row."
Select 
count(case when gender= 'M' then 1 end) as male_patients,
count(case when gender='F' then 1 end) as female_patients
from patients;
-- Query 22
-- Duplicate of Query 21 as provided in the client requirement.
-- Query 23
-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis."
select patient_id, diagnosis from admissions
group  by patient_id, diagnosis 
having count(*) >1;
-- Query 24 
-- Show the city and the total number of patients in tha city. Order from  most to least patients and then by city name ascending." 
select city,
count(*) as total_patients
from patients 
group by city 
order by total_patients desc, city asc;
-- Query 25
-- Show first name , last name and role of every person that is either patient or doctor. The roles are either Patient or Doctor. 
select 
first_name,
last_name, 'Patient' as role from patients
union all
select first_name, last_name, 'Doctor' as role from doctors;
-- Query 26
-- Show all allergies ordered by popularity. Remove Null values from query. 
select allergies, 
count(*) as frequency
from patients
where allergies is not null group by allergies
order by frequency desc;
-- Query 27
-- Show all patient's first_name, and birth_date who were born in ther 1970s decade. Sort the list starting from the earliest birth_date."
select 
first_name, last_name, birth_date from patients
where birth_date>= '1970-01-01'
and birth_date<='1980-01-01'
order by birth_date asc;
-- Query 28
-- We want to display each patient's full name in a single column, Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH, jane"
select concat(upper(last_name),',',Lower(first_name)) as full_name
from patients
order by first_name Desc;
-- Query 29
-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7000."
select 
province_id,sum(height) as total_height from patients 
group by province_id
having sum(height)>=7000;
-- Query 30
-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' "
select 
max(weight)-min(weight) as weight_difference
from patients
where last_name= 'Maroni';
-- Query 31
-- Show all of the days of the month (1-31) and how many admission_dates occured on that date. Sort by the day with most admissions to least admissions." 
select 
day(admission_date) as day,
count(*) as total_admissions
from admissions
group by day(admission_date)
order by total_admissions desc,day asc;
-- Query 32
-- Show all of the patients grouped into weight groups.Show the total amount of patients in each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 weight gorup, etc." 
select 
floor (weight/10)*10 as weight_group,
count(*) as total_patients
from patients
group by floor (weight/10)*10
order by weight_group desc;
-- Query 33
-- Show patient_id, weight, height, isObese grom the patients table. Display is Obese as a boolean 0 or 1.Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm." 
Select patient_id,
weight,height,
case
  when weight/Power(height/100,2)>=30 then 1
  else 0
  end as isObese
  from patients;
-- Query 34
-- Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admission, and doctors table for required"
select distinct
p.patient_id,p.first_name,p.last_name,d.specialty
from patients p 
join admissions a 
on p.patient_id=a.patient_id
join doctors d
on a.attending_doctor_id=d.doctor_id
where a.diagnosis= 'Epilepsy'
and d.first_name= 'Lisa';



