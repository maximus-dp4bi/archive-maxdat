ALTER TABLE CC_S_AGENT ADD (SUPERVISOR VARCHAR2(100));

ALTER TABLE CC_D_AGENT ADD (SUPERVISOR VARCHAR2(100));

CREATE OR REPLACE FORCE VIEW CC_S_AGENT_SV 
as SELECT * FROM CC_S_AGENT;

