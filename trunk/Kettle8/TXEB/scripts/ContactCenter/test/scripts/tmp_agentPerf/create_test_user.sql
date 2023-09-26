--create user(s)

CREATE USER testprojectuser 
    IDENTIFIED BY test123
	DEFAULT TABLESPACE TEST
    QUOTA UNLIMITED ON TEST
    QUOTA 1M ON SYSTEM
    ACCOUNT UNLOCK 
;

--assign role(s)
GRANT etluser TO testprojectuser 
;
