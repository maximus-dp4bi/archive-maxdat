CREATE USER PIPKINS 
    IDENTIFIED BY maximus
	DEFAULT TABLESPACE TEST
    QUOTA UNLIMITED ON TEST
    QUOTA 1M ON SYSTEM
    ACCOUNT UNLOCK 
;

--assign role(s)
GRANT etluser TO PIPKINS 
;