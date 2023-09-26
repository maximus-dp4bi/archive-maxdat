/******* LIST OF ALL THE MUs FOR A GIVEN AGENT ID ******/

DECLARE @agentID varchar(20)

SELECT @agentID = '87145' -- ENTER AGENT's UserID here

SELECT  Z.C_ID as MU, 
		Z.c_name as MU_NAME, 
		CONVERT(VARCHAR(10),CAST(Z.C_SDATE as DATE),101) as Start_Date,
		ISNULL(CONVERT(VARCHAR(10),CAST(Z.C_EDATE as DATE),101), '') as End_Date, 
		Z.AgentID, 
		U.firstName, 
		U.lastName FROM (		
					SELECT E.C_ID, E.c_name, M.c_mu, M.C_SDATE, M.C_EDATE, @agentID as AgentID
					FROM nice_wfm_customer1..r_muroster M
					INNER JOIN nice_wfm_customer1..r_entity E
					ON M.C_MU = E.C_OID
					WHERE M.c_agt in (
									SELECT C_OID FROM nice_wfm_customer1..r_agt  WHERE c_externalid = @agentID)
					And M.C_ACT IS NOT NULL
				)Z
INNER JOIN nice_wfm_liferay..User_ U
ON Z.AgentID = U.screenName
ORDER BY Z.C_SDATE DESC



	
