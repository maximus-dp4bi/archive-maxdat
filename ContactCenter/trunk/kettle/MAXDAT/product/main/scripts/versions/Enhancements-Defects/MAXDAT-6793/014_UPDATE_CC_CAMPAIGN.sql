update CC_C_CAMPAIGN 
 set PROJECT_NAME='CA HCO',
     PROGRAM_NAME='Medi-Cal',
     REGION_NAME='West',
     STATE_NAME='California',
     COUNTRY_NAME='USA'
 WHERE CAMPAIGN_NAME LIKE 'CA%';

COMMIT;