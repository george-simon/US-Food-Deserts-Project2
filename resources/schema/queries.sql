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

-- State Food Desert Stats (For Data Table) --
DROP TABLE IF EXISTS nat_stat_table;
CREATE TABLE nat_stat_table AS
(SELECT state AS State
 	  ,stateCode
 	  ,median_income
	  ,SUM(pop2010) AS Total_2010_Pop
	  ,SUM(is_lila_pop) AS Food_Desert_Pop
	  ,SUM(not_lila_pop) AS Non_Food_Desert_Pop
	  ,CAST(ROUND(SUM(CAST(is_lila_pop AS FLOAT)) / SUM(CAST(pop2010 AS FLOAT))*100) AS INT) AS Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_pop AS FLOAT)) / SUM(CAST(pop2010 AS FLOAT))*100) AS INT) AS Percent_Non_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_white AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_white AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS White_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_black AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_black AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Black_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_aian AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_aian AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Amer_Ind_AK_Native_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_asian AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_asian AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Asian_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_nhopi AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_nhopi AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Native_HI_Pac_Is_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_multir AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_multir AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Multi_Race_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_hispanic AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) - ROUND(SUM(CAST(not_lila_hispanic AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Hispanic_More_Less_Likely_FD
	  ,CAST(ROUND(SUM(CAST(is_lila_white AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS White_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_black AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Black_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_aian AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Amer_Ind_AK_Native_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_asian AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Asian_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_nhopi AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Native_HI_Pac_Is_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_multir AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Multi_Race_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(is_lila_hispanic AS FLOAT)) / SUM(CAST(is_lila_pop AS FLOAT))*100) AS INT) AS Hispanic_Percent_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_white AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS White_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_black AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Black_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_aian AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Amer_Ind_AK_Native_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_asian AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Asian_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_nhopi AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Native_HI_Pac_Is_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_multir AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Multi_Race_Percent_Not_Food_Desert
	  ,CAST(ROUND(SUM(CAST(not_lila_hispanic AS FLOAT)) / SUM(CAST(not_lila_pop AS FLOAT))*100) AS INT) AS Hispanic_Percent_Not_Food_Desert
FROM 
	(
	SELECT *
		  ,(is_lila_white + is_lila_black + is_lila_asian + is_lila_nhopi + is_lila_aian + is_lila_multir) AS is_lila_pop
		  ,(not_lila_white + not_lila_black + not_lila_asian + not_lila_nhopi + not_lila_aian + not_lila_multir) AS not_lila_pop
	FROM
		(
		SELECT state
			  ,pop2010
			  ,tractwhite
			  ,tractblack
			  ,tractasian
			  ,tractnhopi
			  ,tractaian
			  ,tractomultir
			  ,tracthispanic
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractwhite
				ELSE NULL
			   END is_lila_white
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractblack
				ELSE NULL
			   END is_lila_black
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractasian
				ELSE NULL
			   END is_lila_asian
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractnhopi
				ELSE NULL
			   END is_lila_nhopi
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractaian
				ELSE NULL
			   END is_lila_aian
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractomultir
				ELSE NULL
			   END is_lila_multir
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tracthispanic
				ELSE NULL
			   END is_lila_hispanic
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 1 THEN tractsnap
				ELSE NULL
			   END is_lila_snap
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractwhite
				ELSE NULL
			   END not_lila_white
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractblack
				ELSE NULL
			   END not_lila_black
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractasian
				ELSE NULL
			   END not_lila_asian
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractnhopi
				ELSE NULL
			   END not_lila_nhopi
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractaian
				ELSE NULL
			   END not_lila_aian
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tractomultir
				ELSE NULL
			   END not_lila_multir
			  ,CASE
				WHEN CAST(lilatracts_1and10 AS INT) = 0 THEN tracthispanic
				ELSE NULL
			   END not_lila_hispanic
			  ,CASE
				WHEN state = 'Alabama' THEN 'AL'
				WHEN state = 'Alaska' THEN 'AK'
				WHEN state = 'Arizona' THEN 'AZ'
				WHEN state = 'Arkansas' THEN 'AR'
				WHEN state = 'California' THEN 'CA'
				WHEN state = 'Colorado' THEN 'CO'
				WHEN state = 'Connecticut' THEN 'CT'
				WHEN state = 'Delaware' THEN 'DE'
				WHEN state = 'District of Columbia' THEN 'DC'
				WHEN state = 'Florida' THEN 'FL'
				WHEN state = 'Georgia' THEN 'GA'
				WHEN state = 'Hawaii' THEN 'HI'
				WHEN state = 'Idaho' THEN 'ID'
				WHEN state = 'Illinois' THEN 'IL'
				WHEN state = 'Indiana' THEN 'IN'
				WHEN state = 'Iowa' THEN 'IA'
				WHEN state = 'Kansas' THEN 'KS'
				WHEN state = 'Kentucky' THEN 'KY'
				WHEN state = 'Louisiana' THEN 'LA'
				WHEN state = 'Maine' THEN 'ME'
				WHEN state = 'Maryland' THEN 'MD'
				WHEN state = 'Massachusetts' THEN 'MA'
				WHEN state = 'Michigan' THEN 'MI'
				WHEN state = 'Minnesota' THEN 'MN'
				WHEN state = 'Mississippi' THEN 'MS'
				WHEN state = 'Missouri' THEN 'MO'
				WHEN state = 'Montana' THEN 'MT'
				WHEN state = 'Nebraska' THEN 'NE'
				WHEN state = 'Nevada' THEN 'NV'
				WHEN state = 'New Hampshire' THEN 'NH'
				WHEN state = 'New Jersey' THEN 'NJ'
				WHEN state = 'New Mexico' THEN 'NM'
				WHEN state = 'New York' THEN 'NY'
				WHEN state = 'North Carolina' THEN 'NC'
				WHEN state = 'North Dakota' THEN 'ND'
				WHEN state = 'Ohio' THEN 'OH'
				WHEN state = 'Oklahoma' THEN 'OK'
				WHEN state = 'Oregon' THEN 'OR'
				WHEN state = 'Pennsylvania' THEN 'PA'
				WHEN state = 'Rhode Island' THEN 'RI'
				WHEN state = 'South Carolina' THEN 'SC'
				WHEN state = 'South Dakota' THEN 'SD'
				WHEN state = 'Tennessee' THEN 'TN'
				WHEN state = 'Texas' THEN 'TX'
				WHEN state = 'Utah' THEN 'UT'
				WHEN state = 'Vermont' THEN 'VT'
				WHEN state = 'Virginia' THEN 'VA'
				WHEN state = 'Washington' THEN 'WA'
				WHEN state = 'West Virginia' THEN 'WV'
				WHEN state = 'Wisconsin' THEN 'WI'
				WHEN state = 'Wyoming' THEN 'WY'
			   END stateCode
			  ,CASE
				WHEN state = 'Alabama' THEN 40933
				WHEN state = 'Alaska' THEN 57848
				WHEN state = 'Arizona' THEN 46896
				WHEN state = 'Arkansas' THEN 38587
				WHEN state = 'California' THEN 54283
				WHEN state = 'Colorado' THEN 60233
				WHEN state = 'Connecticut' THEN 65998
				WHEN state = 'Delaware' THEN 55214
				WHEN state = 'District of Columbia' THEN 56928
				WHEN state = 'Florida' THEN 44066
				WHEN state = 'Georgia' THEN 44117
				WHEN state = 'Hawaii' THEN 59539
				WHEN state = 'Idaho' THEN 47050
				WHEN state = 'Illinois' THEN 50728
				WHEN state = 'Indiana' THEN 46139
				WHEN state = 'Iowa' THEN 49016
				WHEN state = 'Kansas' THEN 46054
				WHEN state = 'Kentucky' THEN 41104
				WHEN state = 'Louisiana' THEN 39300
				WHEN state = 'Maine' THEN 47931
				WHEN state = 'Maryland' THEN 64201
				WHEN state = 'Massachusetts' THEN 60934
				WHEN state = 'Michigan' THEN 46276
				WHEN state = 'Minnesota' THEN 52321
				WHEN state = 'Mississippi' THEN 38160
				WHEN state = 'Missouri' THEN 45817
				WHEN state = 'Montana' THEN 41280
				WHEN state = 'Nebraska' THEN 52504
				WHEN state = 'Nevada' THEN 51200
				WHEN state = 'New Hampshire' THEN 66633
				WHEN state = 'New Jersey' THEN 62968
				WHEN state = 'New Mexico' THEN 45134
				WHEN state = 'New York' THEN 49781
				WHEN state = 'North Carolina' THEN 43830
				WHEN state = 'North Dakota' THEN 51006
				WHEN state = 'Ohio' THEN 45886
				WHEN state = 'Oklahoma' THEN 43103
				WHEN state = 'Oregon' THEN 50602
				WHEN state = 'Pennsylvania' THEN 48314
				WHEN state = 'Rhode Island' THEN 51623
				WHEN state = 'South Carolina' THEN 41698
				WHEN state = 'South Dakota' THEN 45352
				WHEN state = 'Tennessee' THEN 38591
				WHEN state = 'Texas' THEN 47266
				WHEN state = 'Utah' THEN 56701
				WHEN state = 'Vermont' THEN 55928
				WHEN state = 'Virginia' THEN 60367
				WHEN state = 'Washington' THEN 56163
				WHEN state = 'West Virginia' THEN 42777
				WHEN state = 'Wisconsin' THEN 50351
				WHEN state = 'Wyoming' THEN 52201
			   END median_income
		FROM data_food_deserts
		) b
	) a
GROUP BY state
 		,stateCode
 		,median_income
ORDER BY ROUND(SUM(CAST(is_lila_pop AS FLOAT)) / SUM(CAST(pop2010 AS FLOAT))*100) DESC)
;
ALTER TABLE nat_stat_table
ADD PRIMARY KEY (state);
;


DROP TABLE IF EXISTS nat_map;
CREATE TABLE nat_map AS
(SELECT CONCAT(county,' County, ',stateCode) AS name
	  ,CAST(((lilatract_1and10_sum / lilatract_1and10_count) * 100) AS INT) AS value
FROM 
	(
	SELECT state
		  ,county
		  ,SUM(CAST(lilatracts_1and10 AS FLOAT)) AS lilatract_1and10_sum
		  ,COUNT(CAST(lilatracts_1and10 AS FLOAT)) AS lilatract_1and10_count
		  ,CASE
			WHEN state = 'Alabama' THEN 'AL'
			WHEN state = 'Alaska' THEN 'AK'
			WHEN state = 'Arizona' THEN 'AZ'
			WHEN state = 'Arkansas' THEN 'AR'
			WHEN state = 'California' THEN 'CA'
			WHEN state = 'Colorado' THEN 'CO'
			WHEN state = 'Connecticut' THEN 'CT'
			WHEN state = 'Delaware' THEN 'DE'
			WHEN state = 'District of Columbia' THEN 'DC'
			WHEN state = 'Florida' THEN 'FL'
			WHEN state = 'Georgia' THEN 'GA'
			WHEN state = 'Hawaii' THEN 'HI'
			WHEN state = 'Idaho' THEN 'ID'
			WHEN state = 'Illinois' THEN 'IL'
			WHEN state = 'Indiana' THEN 'IN'
			WHEN state = 'Iowa' THEN 'IA'
			WHEN state = 'Kansas' THEN 'KS'
			WHEN state = 'Kentucky' THEN 'KY'
			WHEN state = 'Louisiana' THEN 'LA'
			WHEN state = 'Maine' THEN 'ME'
			WHEN state = 'Maryland' THEN 'MD'
			WHEN state = 'Massachusetts' THEN 'MA'
			WHEN state = 'Michigan' THEN 'MI'
			WHEN state = 'Minnesota' THEN 'MN'
			WHEN state = 'Mississippi' THEN 'MS'
			WHEN state = 'Missouri' THEN 'MO'
			WHEN state = 'Montana' THEN 'MT'
			WHEN state = 'Nebraska' THEN 'NE'
			WHEN state = 'Nevada' THEN 'NV'
			WHEN state = 'New Hampshire' THEN 'NH'
			WHEN state = 'New Jersey' THEN 'NJ'
			WHEN state = 'New Mexico' THEN 'NM'
			WHEN state = 'New York' THEN 'NY'
			WHEN state = 'North Carolina' THEN 'NC'
			WHEN state = 'North Dakota' THEN 'ND'
			WHEN state = 'Ohio' THEN 'OH'
			WHEN state = 'Oklahoma' THEN 'OK'
			WHEN state = 'Oregon' THEN 'OR'
			WHEN state = 'Pennsylvania' THEN 'PA'
			WHEN state = 'Rhode Island' THEN 'RI'
			WHEN state = 'South Carolina' THEN 'SC'
			WHEN state = 'South Dakota' THEN 'SD'
			WHEN state = 'Tennessee' THEN 'TN'
			WHEN state = 'Texas' THEN 'TX'
			WHEN state = 'Utah' THEN 'UT'
			WHEN state = 'Vermont' THEN 'VT'
			WHEN state = 'Virginia' THEN 'VA'
			WHEN state = 'Washington' THEN 'WA'
			WHEN state = 'West Virginia' THEN 'WV'
			WHEN state = 'Wisconsin' THEN 'WI'
			WHEN state = 'Wyoming' THEN 'WY'
		   END stateCode
	FROM data_food_deserts
	GROUP BY state
			,county
	) a
ORDER BY value DESC)
;


DROP TABLE IF EXISTS nat_map_json;
CREATE TABLE nat_map_json (
   code         VARCHAR(10)  PRIMARY KEY 
  ,name                VARCHAR(60)
  ,value               FLOAT IS NOT NULL
);

DROP TABLE IF EXISTS clean_nat_map_json;
CREATE TABLE clean_nat_map_json AS (
SELECT *
FROM nat_map_json
WHERE value IS NOT NULL
);

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