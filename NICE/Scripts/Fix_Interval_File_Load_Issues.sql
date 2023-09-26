/* ISSUES WITH CISCO FILE LOAD */

-- R_FILESRCVD holds the information for Cisco/Avaya data loads

Select * from nice_wfm_customer1.dbo.R_FILESRCVD 
where c_filename = 'C:\totalview\ftp\switches\customer1\1\102218.1000' 
order by C_TIMESTAMP desc;

-- GET THE C_OID VALUE FROM ABOVE QUERY to see dependent records in the R_REPORTSRCVD table
Select * from nice_wfm_customer1.dbo.R_REPORTSRCVD 
Where C_FILESRCVD in ('8a16cc946694d5320166c6aba67d5800', '8a16cc946694d5320166c6aba67d5801')



/*** IN ORDER TO RECTIFY LOAD ISSUES, DATA FROM THE 2 TABLES NEED TO BE DELETED FIRST
AFTER DELETION, DROP THE INTERVAL FILE IN THE "1" FOLDER TO RE-PROCESS IT AGAIN ***/

/* ORDER OF DELETION FROM THE TABLES */
--Delete from nice_wfm_customer1.dbo.R_REPORTSRCVD 
--Where C_FILESRCVD in ('8a16cc946694d5320166c6a6b24a4868', '8a16cc946694d5320166c6a6b0c24861')

--Delete from  nice_wfm_customer1.dbo.R_FILESRCVD 
--where c_filename = 'C:\totalview\ftp\switches\customer1\1\102218.1000' 
