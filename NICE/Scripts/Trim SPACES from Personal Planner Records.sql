/* This script is to remove errant spaces causing problems when trying to save updates to the Personal Planner 
## Run this from COCP1MMSQL01WFM.nice-wfm_customer1" 
## Reference JIRA NICEWFM-2206 */

/*Shows list of FORECASTS*/
Select len(c_name), c_name, c_entity from r_ltfcst where c_name like '%MD HBE 2019 2/1/19%';


/* STEP 1: Validate the data where the problem exisits; script shows list of FORECASTS including date */
Select len(c_name)c_chars, c_name, c_entity, c_edate from r_ltfcst where c_name like '%MD HBE 2019 2/1/19%'; 


/* STEP 2: Check the character length... shows the data length in number of characters */
Select datalength(c_name)c_chars, len(c_name)c_chars, c_name, c_entity, c_edate from r_ltfcst where c_name like '%MD HBE 2019 2/1/19%'; -- shows number of chars (to look ones for too many -- errant "spaces")


/* Removes (trims) errant spaces*/
update r_ltfcst set c_name=rtrim(c_name) where c_name like '%MD HBE 2019 2/1/19%'; 
