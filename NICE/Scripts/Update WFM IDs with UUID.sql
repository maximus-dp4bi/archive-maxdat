--Script Start
--RUN UPDATES FOR WFMID

update nice_wfm_customer1.dbo.R_USER 
set C_USERNAME ='15202601' 
where  c_USERNAME = '15202608';

update nice_wfm_customer1.dbo.R_USER 
set C_UNIFIEDID ='202572' 
where  C_UNIFIEDID = '202593';

update nice_wfm_customer1.dbo.R_AGT 
set C_ID='15202593' 
where  C_ID = '202593';

update nice_wfm_customer1.dbo.R_AGT 
set C_EXTERNALID='202593' 
where  C_ID = '15202593';

--Check for the updated WFM IDs. 

Select  * from nice_wfm_customer1.dbo.R_USER 
where  c_username = '15202572 ';

Select  * from nice_wfm_customer1.dbo.R_USER 
where  C_UNIFIEDID = '202572';

Select  * from nice_wfm_customer1.dbo.R_AGT
where  C_ID = '15202572';

Select  * from nice_wfm_customer1.dbo.R_AGT
where  C_EXTERNALID = '202572';
--Script End 	
