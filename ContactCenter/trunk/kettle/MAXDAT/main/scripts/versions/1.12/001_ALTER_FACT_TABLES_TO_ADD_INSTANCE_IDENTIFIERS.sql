ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD ( QUEUE_NUMBER NUMBER (19) );

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD ( AGENT_LOGIN_ID NVARCHAR2 (100)  );


ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD ( QUEUE_NUMBER NUMBER (19)  );


ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD ( QUEUE_NUMBER NUMBER (19) );

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD ( AGENT_LOGIN_ID NVARCHAR2 (100) );



ALTER TABLE CC_F_AGENT_BY_DATE ADD ( AGENT_LOGIN_ID NVARCHAR2 (100) );

ALTER TABLE CC_F_AGENT_BY_DATE ADD ( SUPERVISOR_AGENT_LOGIN_ID NVARCHAR2 (100)  );

ALTER TABLE CC_F_AGENT_BY_DATE ADD ( MANAGER_AGENT_LOGIN_ID NVARCHAR2 (100) );


ALTER TABLE CC_F_AGENT_ACTIVITY_BY_DATE ADD ( AGENT_LOGIN_ID NVARCHAR2 (100)   );


CREATE OR REPLACE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACTUALS_QUEUE_INTERVAL.* FROM CC_F_ACTUALS_QUEUE_INTERVAL ;


CREATE OR REPLACE VIEW CC_F_AGENT_ACTIVITY_BY_DATE_SV  AS
SELECT CC_F_AGENT_ACTIVITY_BY_DATE.* FROM CC_F_AGENT_ACTIVITY_BY_DATE ;


CREATE OR REPLACE VIEW CC_F_AGENT_BY_DATE_SV  AS
SELECT CC_F_AGENT_BY_DATE.* FROM CC_F_AGENT_BY_DATE ;

CREATE OR REPLACE VIEW CC_F_ACD_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACD_QUEUE_INTERVAL.* FROM CC_F_ACD_QUEUE_INTERVAL ;

CREATE OR REPLACE VIEW CC_F_ACD_AGENT_INTERVAL_SV  AS
SELECT CC_F_ACD_AGENT_INTERVAL.* FROM CC_F_ACD_AGENT_INTERVAL ;
