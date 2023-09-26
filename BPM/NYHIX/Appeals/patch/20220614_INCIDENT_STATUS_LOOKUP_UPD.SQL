INSERT INTO MAXDAT.INCIDENT_STATUS_LOOKUP 
(INCIDENT_STATUS, MODULE, START_STOP,STATUS_CD) 
VALUES ( 
 'Appeal Closed - Other', 	-- INCIDENT_STATUS
 'APPEAL', 					-- 	MODULE
 'FINISH', 					--	START_STOP
 'APL_CLOS_OTHER' ); 		
 
 
INSERT INTO MAXDAT.INCIDENT_STATUS_LOOKUP 
(INCIDENT_STATUS, MODULE, START_STOP,STATUS_CD) 
VALUES ( 
 'Dismissal - Death', 	-- INCIDENT_STATUS 
 'APPEAL', 					-- 	MODULE
 'STOP', 					--	START_STOP
 'DIS_DEATH' ); 		
 
 
INSERT INTO MAXDAT.INCIDENT_STATUS_LOOKUP 
(INCIDENT_STATUS, MODULE, START_STOP,STATUS_CD) 
VALUES ( 
 'Incident Closed - Duplicate', 	-- INCIDENT_STATUS
 'APPEAL', 					-- 	MODULE
 'FINISH', 					--	START_STOP
 'INC_CLOSED_DUP' ); 		

COMMIT; 


update corp_etl_list_lkup lkp
set out_var =  out_var||','||''''||'Appeal Closed - Failure to Participate'||''''
              ||','||''''||'Appeal Closed - Phone Not Working/Bad Number'||'''' 
              ||','||''''||'Appeal Closed - Invalid Appeal Request'||''''
where name = 'PA_UPD20_70';

commit;


