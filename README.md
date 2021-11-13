# SQL DATA cleaning
Summary: This dataset from Data.World summarizes the leading causes of mortality in 26 of the largest urban cities in the US.  

Data Set: https://data.world/health/big-cities-health  

[orignal dataset - sample records](https://github.com/christabel-paul/SQL_Data_Cleaning/blob/main/Big_Cities_Health_Data_sample_records.csv)  
[cleaned dataset - sample records](https://github.com/christabel-paul/SQL_Data_Cleaning/blob/main/Big_Cities_Health_Data_%20updated_sample_records.csv)

**Attributes of original data set:**  
Indicator Category: condition which is contributing to mortality rate.  
Indicator: statistic which places indicator category in leading cause of mortality  
Value: indicator category value  
Year: year of statistic  
Gender  
Race/Ethnicity  
Place: City (County), State  
BCHC Requested Methodology  
Source: sources used in data collection (multiple sources listed in one column)  
Methods: additional details of data collection  
Notes

### Steps taken to clean data:  
1. Split Indicator attribute into Indicator and Indicator Value Type attributes  
  
       original:
       Indicator = "Tuberculosis Incidence Rate (Per 100,000 people)" 
       
       updated:
       Indicator = "Tuberculosis Incidence Rate"  
       Indicator Value Type = "Per 100,000 people"

2. Seperate place into City, County, and State attributes  

3. Seperate Source attribute into columns for each source listed  

       original:
       Source = "Online Analytical Statistical Information System, Georgia Department of Public Health, Office of Health Indicators for Planning (OHIP)."
       
       updated:
       Source1 = "Online Analytical Statistical Information System"  
       Source2 = "Georgia Department of Public Health"  
       Source3 = "Office of Health Indicators for Planning (OHIP)"  
       
 4. Move existing notes in Source attribute to Notes attribute.

**Attributes in updated dataset:**  
Indicator Category  
Indicator  
Indicator Value  
Indicator Value Type  
Year  
Gender  
Race or Ethnicity  
City  
County  
State  
BCHC Requested Methodology  
Source1  
Source2  
Source3  
Source4  
Methods  
Notes

### Full SQL queries used in cleaning are shown in [SQLQuery2.sql](https://github.com/christabel-paul/SQL_Data_Cleaning/blob/main/SQLQuery2.sql)







