
/*Displays the queue names as they appear in the EnterpiseName field of the t_Precision_Queue table */
select * from maxco_awdb.dbo.t_Precision_Queue where EnterpriseName = 'VAHM_PACC_0026_ENG'; 
select * from maxco_awdb.dbo.t_Precision_Queue where EnterpriseName = 'VAHM_PACC_0026_SPA'; 

/*Updates the names in the EnterpiseName field of the t_Precision_Queue table */
update maxco_awdb.dbo.t_Precision_Queue  
set EnterpriseName = 'VAHM_PACC_0026_ENG1' 
where  EnterpriseName = 'VAHM_PACC_0026_ENG';

update maxco_awdb.dbo.t_Precision_Queue  
set EnterpriseName = 'VAHM_PACC_0026_SPA1' 
where  EnterpriseName = 'VAHM_PACC_0026_SPA';