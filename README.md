This dataset from Data.World summarizes the leading causes of mortality in 26 of the largest urban cities in the US. 
Data Set: https://data.world/health/big-cities-health

Attributes of original data set  
Indicator Category: condition which is contributing to mortality rate.
Indicator: statistic which places indicator category in leading cause of mortality
Value: indicator category value
Year: year of statistic	
Gender	
Race/Ethnicity	
Place: city (county), state
Source: sources used in data collection
Methods: details of data collection
Notes

Steps taken to clean data:
1. split Indicator attribute into Indicator and Indicator Value Type attributes
  e.g. Indicator = Tuberculosis Incidence Rate (Per 100,000 people) --> Indicator = Tuberculosis Incidence Rate, Indicator Value Type = Per 100,000 people

2.seperate place into City, County, and State attributes



Full SQL queries used in cleaning are shown in [SQLQuery2.sql](https://github.com/christabel-paul/SQL_Data_Cleaning/blob/main/SQLQuery2.sql)







