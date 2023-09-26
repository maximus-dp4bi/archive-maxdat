/* Execute query in the given order to correct values in the ExpandoValue table */

/* Step 1 - Select query to get screenname and userid columns from USser_ table */

SELECT firstname, lastname, screenname, userid 
FROM nice_wfm_liferay..User_ 
WHERE screenname like '%126462%'


/* Step 2 - Enter the (screename, userid) values in order from above query to get results from Expandvalue table. 
   The results will have 4 records for a single Role (agent or supervisor) and 8 records for a dual roles */

 /* SAMPLE RESULT - data_ column should reflect the correct Emp IDs
 valueId	companyId tableId columnId	rowId_	classNameId	classPK 	data_
18789586	11197	  11282	  11283	   18789573	10005	    18789507	false
18789607	11197	  11282	  11566	   18789573	10005	    18789507	202567@maximus.com
18789617	11197	  11282	  12182	   18789573	10005	    18789507	Agent Role
18789622	11197	  11282	  11558	   18789573	10005	    18789507	202567
*/

SELECT * FROM nice_wfm_liferay..expandovalue 
WHERE classpk in ('6995980','74015')


/* Step 3 - Update the data_ column value to Agent/Supervisor depending on what needs to be the correct one */

UPDATE nice_wfm_liferay..expandovalue 
SET data_='126462@maximus.com' 
WHERE classpk='6995980' AND valueid='6996002'

UPDATE nice_wfm_liferay..expandovalue 
SET data_='111011Sup' 
WHERE classpk='10092665' AND valueid='10092682'