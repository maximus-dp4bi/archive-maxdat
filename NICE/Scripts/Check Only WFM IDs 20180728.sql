
--Check for the updated WFM IDs. 
Select  * from nice_wfm_customer1.dbo.R_AGT 
where c_externalid ='200963'; 

Select  * from nice_wfm_customer1.dbo.R_USER 
where  c_unifiedid = '200963';

--Script End
