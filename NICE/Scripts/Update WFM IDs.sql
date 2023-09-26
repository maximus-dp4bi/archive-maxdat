--Script Start
--RUN UPDATES FOR WFMID

update nice_wfm_customer1.dbo.R_USER 
set C_USERNAME ='40305852' 
where  c_USERNAME = '96305852';

update nice_wfm_customer1.dbo.R_AGT 
set C_ID='40305852' 
where  C_ID = '96305852';

--Check for the updated WFM IDs. 

Select  * from nice_wfm_customer1.dbo.R_USER 
where  c_username = '40305852';

Select  * from nice_wfm_customer1.dbo.R_AGT
where  C_ID = '40305852';

--Script End 	
