alter session set plsql_code_type = native;

CREATE OR REPLACE TRIGGER BI_GEN_NC_QUEUE_PERFORMANCE_SUMMARY 
BEFORE INSERT ON GEN_NC_QUEUE_PERFORMANCE_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_SKILLS_PERFORMANCE 
BEFORE INSERT ON GEN_NC_SKILLS_PERFORMANCE
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_DNIS_PERFORMANCE_SUMMARY 
BEFORE INSERT ON GEN_NC_DNIS_PERFORMANCE_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_WRAP_UP_PERFORMANCE_SUMMARY
BEFORE INSERT ON GEN_NC_WRAP_UP_PERFORMANCE_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_AGENT_PERFORMANCE_SUMMARY
BEFORE INSERT ON GEN_NC_AGENT_PERFORMANCE_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_AGENT_STATUS_SUMMARY
BEFORE INSERT ON GEN_NC_AGENT_STATUS_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

CREATE OR REPLACE TRIGGER BI_GEN_NC_FLOW_OUTCOME_SUMMARY 
BEFORE INSERT ON GEN_NC_FLOW_OUTCOME_SUMMARY
REFERENCING OLD AS OLD NEW AS NEW 
for each row
declare
  v_date_span number := null;
BEGIN
v_date_span := (:NEW.INTERVAL_END - :NEW.INTERVAL_START);
IF  (v_date_span >=28) 
    THEN :NEW.DATA_SCOPE := 'MONTHLY';
ELSIF (v_date_span =7) 
    THEN :NEW.DATA_SCOPE := 'WEEKLY';
ELSIF (v_date_span=1)   
    THEN :NEW.DATA_SCOPE := 'DAILY';

ELSIF (v_date_span < 1)
    THEN :NEW.DATA_SCOPE := 'HOURLY';
ELSE :NEW.DATA_SCOPE := 'OTHER';
END IF;
END;
/

alter session set plsql_code_type = interpreted;
