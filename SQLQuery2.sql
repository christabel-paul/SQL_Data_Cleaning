--change all the '/' to 'and'
update BigCitiesHealthData
Set [Indicator Category] = REPLACE([Indicator Category], '/', ' and ')

--change Asian/PI to Asian and PI
update BigCitiesHealthData
Set [Race or Ethnicity] = REPLACE([Race or Ethnicity], '/', ' and ')
where [Race or Ethnicity] = 'Asian/PI'

--add a column for indicator value type
alter table BigCitiesHealthData 
add [Indicator Value Type] varchar(100)

--populate [indicator value type] for rate values
update BigCitiesHealthData
set [Indicator Value Type] = SUBSTRING(Indicator, CHARINDEX('Rate',Indicator) , CHARINDEX(')',Indicator)) 
where  CHARINDEX('Rate',Indicator)>0 

--populate [indicator value type] for year values
update BigCitiesHealthData
set [Indicator Value Type] = 'Years' 
where  CHARINDEX('Years',Indicator)>0 and  [Indicator] = 'Life Expectancy at Birth (Years)'

--populate [indicator value type] for percent values
update BigCitiesHealthData
set [Indicator Value Type] = 'Percent' 
where   
([Indicator Category]= 'Demographics' or [Indicator Category] = 'Infectious Disease' or 
[Indicator Category] = 'Nutrition, Physical Activity, and Obesity' or [Indicator Category] = 'Behavioral Health and Substance Abuse' 
or [Indicator Category] = 'Tobacco' or [Indicator Category] = 'Maternal and Child Health')

--pouplate [indicator value type] special case 
update BigCitiesHealthData
set [Indicator Value Type] = 'Dollars' 
where   
[Indicator]= 'Median Household Income (Dollars)' 


--Seperate Place into City, county, and state columns
alter table BigCitiesHealthData 
add City varchar(50),
    State varchar(50),
	County varchar(50)

--extract the city+county as well as state info from Place column
--commented after Place column was deleted
--update BigCitiesHealthData
--set City = substring(Place, 1, CHARINDEX(',', Place) - 1),
--    State = substring(Place, CHARINDEX(',', Place) + 1, LEN(Place)) 
--where Place <> 'U.S. Total' 

alter table BigCitiesHealthData 
drop column Place

--creates and populates the county column based on city column
update BigCitiesHealthData
set County = SUBSTRING(City, CHARINDEX('(',City)+1, CHARINDEX(')',City)-1) 
where  CHARINDEX('(',City)>0 

--gets rid of the county part in the existing city column
update BigCitiesHealthData
set City = SUBSTRING(City, 1, CHARINDEX('(',City)-2) 
where  CHARINDEX('(',City)>0 

--create source columns for each source
alter table BigCitiesHealthData 
add Source2 varchar(200),
 Source3 varchar(200),
 Source4 varchar(200)

--populate second/third/fourth source column (the existing source col becomes source1)
select distinct [Indicator Category], Source1, Notes
from BigCitiesHealthData
where CHARINDEX(',', Source1) > 0
order by source1

--for cells in the source column that have multiple sources, seperate each source into its own column
update BigCitiesHealthData
set Source1 = PARSENAME(Source1,3)
where Source1 = 'OnlineAnalyticalStatisticalInformationSystem.GeorgiaDepartmentofPublicHealth.OfficeofHealthIndicatorsforPlanning(OHIP)'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,2)
where Source1 = 'Boston resident live births and deaths. MA Department of Public Health'

update BigCitiesHealthData
set Source2 = PARSENAME(Source1,1)
where Source1 = 'Arizona Department of Health Services. HIV/AIDS Surveillance Program'
or Source1 = 'Behavior Risk Factors: Selected Metropolitan Area Risk Trends (SMART). Centers for Disease Control and Prevention'
or Source1 = 'Boston Behavioral Risk Factor Survey. Boston Public Health Commission'
or Source1 = 'Boston resident deaths. MA Department of Public Health'
 
update BigCitiesHealthData
set Source1 = PARSENAME(Source1,2)
where Source1 = 'Boston resident live births. MA Department of Public Health'
or Source1 = 'Crude rate. hospitiliation discharge data'
or Source1 = 'Division of Disease Control. Philadelphia Dept of Public Health'
or Source1 = 'HIV/AIDS Surveillance Program. MA Department of Public Health'
or Source1 = 'HIV/STD Program. Public Health - Seattle & King County'
or Source1 =  'Minnesota Department of Health. HIV/AIDS Surveillance System'
or Source1 = 'Minnesota Department of Health. TB Control Program (case counts)'
or Source1 = 'Minnesota Department of Health. Vital Records'
or Source1 = 'National Center for Health Statistics (NCHS). CDC'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,2)
where Source1 = 'Texas Department of State Health Services. Center for Health Statistics 2015'
or Source1 = 'Texas Behavioral Risk Factor Surveillance Systems. Statewide BRFSS survey'
or Source1 = 'TB Program. Public Health - Seattle & King County'
or Source1 = 'SNHD TB Annual TB Excel Files. 2010 Census data'
or Source1 = 'City of Houston. TB Control'
or Source1 =  'SNHD reportable-disease database and 2010 Clark County. NV Census'
or Source1 = 'Santa Clara County Public Health Department. Behavioral Risk Factor Surveillance Survey 2013-14'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,4)
where Source1 = 'California Department of Public Health. Center for Health Statistics. Office of Health Information and Research. Death Statistical Master Files; SANDAG January 1 population estimates (2001-2013 estimate released Jan 2014)'
or Source1 = 'Santa Clara County Public Health Department. 2011-2013 Death Database. US Census Bureau. Census 2000-2010'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,3)
where Source1 = 'Adolescent cigarette smoking in past month . Youth Risk Behavior Surveillance System (YRBSS). CDC/NCHHSTP'
or Source1 = 'Adolescents meeting Federal physical activity guidelines . Youth Risk Behavior Surveillance System (YRBSS). CDC/NCHHSTP'
or Source1 = 'Adult Cigarette Smoking. National Health Interview Survey (NHIS). CDC/NCHS'
or Source1 = 'All Infant deaths (per 1000 live births <1 year). Linked Birth/Infant Death Data Set. CDC/NCHS'
or Source1 = 'Binge drinking in past month. National Survey on Drug Use and Health (NSDUH). SAMHSA'
or Source1 = 'Binge drinking in past monthAdults (percent 18+ years). National Survey on Drug Use and Health (NSDUH). SAMHSA'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,3)
where Source1 = 'WA State Department of Health. Center for Health Statistics. Death Certificate Data 1990-2013 August 2014'
or Source1 = 'Oregon Death Certificates. National Center for Health Statistics Population Estimates. Census Bureau Population Estimates (Vintage 2012)'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,2)
where Source1 = 'California Department of Public Health. California Tuberculosis Data Tables 2014'
or Source1 = 'California Department of Public Health: Health Information and Research Center and Birth and Death Statistical Master File 2010. County of San Diego: Health & Human Services Agency and Public Health Services and Maternal/Child/Family Heath Services'
or Source1 = 'Boston Public Health Commission Research and Evaluation; Boston Resident Deaths. Massachusetts Department of Public Health'
or Source1 = 'California Department of Public Health. death statistical master files; analysis by San Francisco Department of Health'
or Source1 = 'Oregon Linked Birth & Death Certificates. Oregon Birth Certificates'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,4)
where Source1 = 'Centers for Disease Control and Prevention (CDC). Behavioral Risk Factor Surveillance System Survey Data Atlanta, Georgia. US Department of Health and Human Services. Centers for Disease Control and Prevention 2010-2012'
or Source1 = 'Centers for Disease Control and Prevention. National Center for Health Statistics. Underlying Cause of Death 1999-2014 on CDC WONDER Online Database, released 2015. Data are from the Multiple Cause of Death Files, 1999-2014, as compiled from data provided'

update BigCitiesHealthData
set Source1 = PARSENAME(Source1,2)
where Source1= 'US Census Bureau 2010 Census. California Department of Public Health Office of AIDS data reported as of March 29 2016; prepared by City of Long Beach Department of Health and Human Services HIV/STD Surveillance Program 2016'


--any notes in the source column should be moved to the notes column
update BigCitiesHealthData
set Notes = substring(Source1,charindex('Note',source1),len(source1))
where charindex('Note',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('Note',source1)-2)
where charindex('Note',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('Available at',source1),len(source1))
where charindex('Available at',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('Available at',source1)-2)
where charindex('Available at',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('Preliminary data',source1),len(source1))
where charindex('Preliminary data',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('Preliminary data',source1)-2)
where charindex('Preliminary data',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('Includes immediate',source1),len(source1))
where charindex('Includes immediate',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('Includes immediate',source1)-2)
where charindex('Includes immediate',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('The NYC YRBS',source1),len(source1))
where charindex('The NYC YRBS',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('The NYC YRBS',source1)-2)
where charindex('The NYC YRBS',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('http://',source1),len(source1))
where charindex('http://',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('Population estimates (denominator)',source1),len(source1))
where charindex('Population estimates (denominator)',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('Population estimates (denominator)',source1)-3)
where charindex('Population estimates (denominator)',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex('The CHS is a cross-sectional',source1),len(source1))
where charindex('The CHS is a cross-sectional',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex('The CHS is a cross-sectional',source1)-2)
where charindex('The CHS is a cross-sectional',Source1)>0

update BigCitiesHealthData
set Notes = substring(Source1,charindex(';',source1),len(source1))
where charindex('American Community Survey 1-year estimate tables',Source1)>0

update BigCitiesHealthData
set Source1 = substring(Source1,1,charindex(';',source1)-1)
where charindex('American Community Survey 1-year estimate tables',Source1)>0









