--RUN UPDATES FOR WFMID
update nice_wfm_customer1.dbo.R_AGT 
set C_ID='80200963' 
where  c_externalid ='200963'; 

update nice_wfm_customer1.dbo.R_USER 
set C_USERNAME='80200963' 
where  c_unifiedid = '200963';

--Check for the updated WFM IDs. 
Select  * from nice_wfm_customer1.dbo.R_AGT 
where c_externalid ='200963'; 

Select  * from nice_wfm_customer1.dbo.R_USER 
where  c_unifiedid = '200963';

--Script End
