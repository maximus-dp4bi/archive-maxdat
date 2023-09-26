
/* change UUID */

update nice_wfm_customer1.dbo.R_USER 
set C_UNIFIEDID ='249372' 
where  C_UNIFIEDID = '65249372';

/* CHECK UUID */

Select  * from nice_wfm_customer1.dbo.R_USER 
where  C_UNIFIEDID = '249372';