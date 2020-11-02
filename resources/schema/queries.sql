-- Create Multomah Co. food desert table using SELECT statement
DROP TABLE IF EXISTS multnomah_data; 
CREATE TABLE multnomah_data AS
(SELECT 
CensusTract AS census_tract
,POP2010 AS population_2010
,TractLOWI AS population_low_income
,CAST(ROUND(PovertyRate) AS INT) AS percent_poverty
,MedianFamilyIncome AS med_fam_income
,TractHUNV AS house_unit_no_vehicle
,CAST(ROUND(lapophalf) AS INT) AS population_low_access_half
,CAST((ROUND((lapophalf / POP2010) * 100)) AS INT) AS percent_low_access_half
,CAST(ROUND(lapop1) AS INT) AS population_low_access_1
,CAST((ROUND((lapop1 / POP2010) * 100)) AS INT) AS percent_low_access_1
FROM data_food_deserts
INNER JOIN data_vulnerability_multi
ON data_food_deserts.CensusTract = data_vulnerability_multi.fips);
ALTER TABLE multnomah_data
ADD PRIMARY KEY (census_tract);


-- Create National food desert table using SELECT statement
DROP TABLE IF EXISTS national_data; 
CREATE TABLE national_data AS
(SELECT  
State          
,County      
,SUM(POP2010) AS total_population  
,CAST((ROUND(AVG(CAST(Urban AS NUMERIC)), 2) * 100) AS INT) AS percent_urban
,CAST((ROUND(AVG(CAST(LA1and10 AS NUMERIC)), 2) * 100) AS INT) AS percent_low_access  
FROM data_food_deserts
GROUP BY State, County);
ALTER TABLE national_data
ADD PRIMARY KEY (State, County);


DROP TABLE IF EXISTS multnomah_summary_data; 
CREATE TABLE multnomah_summary_data AS
(
SELECT 
 data_food_deserts.county
,sum(POP2010) AS sum_population_2010
,sum(TractLOWI) AS sum_population_low_income
,CAST(AVG(PovertyRate) AS INTEGER) AS median_percent_poverty
,CAST(AVG(medianfamilyincome) AS INTEGER) AS median_family_income
,SUM(TractHUNV) AS sum_house_unit_no_vehicle
,SUM(CAST(ROUND(lapophalf) AS INT)) AS sum_population_low_access_half
,SUM(CAST(ROUND(lapop1) AS INT)) AS sum_population_low_access_1
,CAST(AVG(perc_renters) AS INTEGER) AS percent_renters
,CAST(AVG(perc_com_color) AS INTEGER) AS percent_households_of_color
,CAST(AVG(perc_wo_bachlrs_degree) AS INTEGER) AS percent_no_bachlrs
,CAST(AVG(perc_hhs_80_mfi) AS INTEGER) AS percent_households_lessthan_80pcnt_of_mfi_score
,CAST(AVG(risk_renters) AS INTEGER) AS mean_risk_renters
,CAST(AVG(risk_com_color) AS INTEGER) AS mean_risk_households_of_color
,CAST(AVG(risk_25_wo_bachlrs_degree) AS INTEGER) AS mean_risk_over_25_wo_bachlrs
,CAST(AVG(risk_80_mfi) AS INTEGER) AS mean_risk_with_lessthan_80pcnt_of_mfi_score 
,CAST(AVG(risk_total) AS INTEGER) AS mean_risk_factor

FROM data_food_deserts
INNER JOIN data_vulnerability_multi
ON data_food_deserts.CensusTract = data_vulnerability_multi.fips
WHERE POP2010 > 100
group by data_food_deserts.county
);

ALTER TABLE multnomah_summary_data
ADD PRIMARY KEY (county);


-- Other columns not currently in use from data_vulnerability_mult.sql schema:
-- ,OBJECTID      
-- ,STATE         
-- ,COUNTY        
-- ,TRACT         
-- ,TRACT_NO      
-- ,FIPS          
-- ,Geography     
-- ,Perc_renters  
-- ,Perc_com_color
-- ,Perc_WO_bachlr
-- ,Perc_HHs_80_MF
-- ,risk_renters  
-- ,risk_com_color
-- ,risk_25_WO_bac
-- ,risk_80_MFI   
-- ,risk_total    
-- ,Shape_Length  
-- ,Shape_Area    
-- ,is_vulnerable 

-- Other columns not currently in use from data_food_deserts.sql schema: 
-- ,OHU2010        
-- ,GroupQuartersFl
-- ,NUMGQTRS       
-- ,PCTGQTRS       
-- ,LILATracts_1And
-- ,LILATracts_half
-- ,LILATracts_1And
-- ,LILATracts_Vehi
-- ,HUNVFlag       
-- ,LowIncomeTracts
-- ,PovertyRate    
-- ,MedianFamilyInc    
-- ,LAhalfand10    
-- ,LA1and20       
-- ,LATracts_half  
-- ,LATracts1      
-- ,LATracts10     
-- ,LATracts20     
-- ,LATractsVehicle      
-- ,LAPOP05_10     
-- ,LAPOP1_20      
-- ,LALOWI1_10     
-- ,LALOWI05_10    
-- ,LALOWI1_20     
-- ,lapophalf      
-- ,lapophalfshare 
-- ,lalowihalf     
-- ,lalowihalfshare
-- ,lakidshalf     
-- ,lakidshalfshare
-- ,laseniorshalf  
-- ,laseniorshalfsh
-- ,lawhitehalf    
-- ,lawhitehalfshar
-- ,lablackhalf    
-- ,lablackhalfshar
-- ,laasianhalf    
-- ,laasianhalfshar
-- ,lanhopihalf    
-- ,lanhopihalfshar
-- ,laaianhalf     
-- ,laaianhalfshare
-- ,laomultirhalf  
-- ,laomultirhalfsh
-- ,lahisphalf     
-- ,lahisphalfshare
-- ,lahunvhalf     
-- ,lahunvhalfshare
-- ,lasnaphalf     
-- ,lasnaphalfshare
-- ,lapop1 
-- ,lapop1share    
-- ,lalowi1        
-- ,lalowi1share   
-- ,lakids1        
-- ,lakids1share   
-- ,laseniors1     
-- ,laseniors1share
-- ,lawhite1       
-- ,lawhite1share  
-- ,lablack1       
-- ,lablack1share  
-- ,laasian1       
-- ,laasian1share  
-- ,lanhopi1       
-- ,lanhopi1share  
-- ,laaian1        
-- ,laaian1share   
-- ,laomultir1     
-- ,laomultir1share
-- ,lahisp1        
-- ,lahisp1share   
-- ,lahunv1        
-- ,lahunv1share   
-- ,lasnap1        
-- ,lasnap1share   
-- ,lapop10        
-- ,lapop10share   
-- ,lalowi10       
-- ,lalowi10share  
-- ,lakids10       
-- ,lakids10share  
-- ,laseniors10    
-- ,laseniors10shar
-- ,lawhite10      
-- ,lawhite10share 
-- ,lablack10      
-- ,lablack10share 
-- ,laasian10      
-- ,laasian10share 
-- ,lanhopi10      
-- ,lanhopi10share 
-- ,laaian10       
-- ,laaian10share  
-- ,laomultir10    
-- ,laomultir10shar
-- ,lahisp10       
-- ,lahisp10share  
-- ,lahunv10       
-- ,lahunv10share  
-- ,lasnap10       
-- ,lasnap10share  
-- ,lapop20        
-- ,lapop20share   
-- ,lalowi20       
-- ,lalowi20share  
-- ,lakids20       
-- ,lakids20share  
-- ,laseniors20    
-- ,laseniors20shar
-- ,lawhite20      
-- ,lawhite20share 
-- ,lablack20      
-- ,lablack20share 
-- ,laasian20      
-- ,laasian20share 
-- ,lanhopi20      
-- ,lanhopi20share 
-- ,laaian20       
-- ,laaian20share  
-- ,laomultir20    
-- ,laomultir20shar
-- ,lahisp20       
-- ,lahisp20share  
-- ,lahunv20       
-- ,lahunv20share  
-- ,lasnap20       
-- ,lasnap20share  
-- ,TractLOWI      
-- ,TractKids      
-- ,TractSeniors   
-- ,TractWhite     
-- ,TractBlack     
-- ,TractAsian     
-- ,TractNHOPI     
-- ,TractAIAN      
-- ,TractOMultir   
-- ,TractHispanic  
-- ,TractHUNV      
-- ,TractSNAP      