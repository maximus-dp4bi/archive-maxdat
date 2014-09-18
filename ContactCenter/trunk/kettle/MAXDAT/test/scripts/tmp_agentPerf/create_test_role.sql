--create role(s)
CREATE ROLE etluser 
    NOT IDENTIFIED 
;

--assign privileges
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER TO etluser
;