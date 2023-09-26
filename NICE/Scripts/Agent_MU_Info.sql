/****** SCRIPT TO FIND OUT Agent's MU  *****/

DECLARE @agentID varchar(20)

SELECT @agentID = '141503' -- ENTER AGENT's UserID here

SELECT  C_ID AS MU,
		c_name AS Name  
FROM nice_wfm_customer1..r_entity 
WHERE c_oid in (
	SELECT c_mu 
	FROM nice_wfm_customer1..r_muroster 
	WHERE c_agt in (
					SELECT C_OID FROM nice_wfm_customer1..r_agt  WHERE c_externalid = @agentID)
	and C_EDATE IS NULL)
