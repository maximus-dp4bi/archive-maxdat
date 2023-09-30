-- add hire and termination date to CC_D_AGENT table
alter table cc_d_agent
add (hire_date date,
  termination_date date);
  
CREATE OR REPLACE VIEW CC_D_AGENT_SV AS
	SELECT * FROM CC_D_AGENT ;
  
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.4','004','004_ALTER_D_AGENT_ADD_HIRE_AND_TERMINATION_DATE');
	
commit;