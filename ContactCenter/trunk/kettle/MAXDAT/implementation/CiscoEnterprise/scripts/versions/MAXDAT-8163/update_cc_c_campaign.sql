update cc_c_campaign 
set project_name = 'CA HCO'
, program_name = 'Medi-Cal'
, region_name = 'West'
, state_name = 'California'
where campaign_id in
(
5035,	
5036,	
5037,	
5038,	
5039,	
5040,	
5041,	
5042,	
5043,	
5044,	
5045,	
5046,	
5047
);

commit;