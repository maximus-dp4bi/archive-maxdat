CREATE TABLE CC_D_DATES
  (
    D_DATE_ID       NUMBER (19) NOT NULL ,
    D_DATE          DATE NOT NULL ,
    D_MONTH         VARCHAR2 (3) NOT NULL ,
    D_MONTH_NAME    VARCHAR2 (9) NOT NULL ,
    D_DAY           VARCHAR2 (3) NOT NULL ,
    D_DAY_NAME      VARCHAR2 (9) NOT NULL ,
    D_DAY_OF_WEEK   VARCHAR2 (1) NOT NULL ,
    D_DAY_OF_MONTH  VARCHAR2 (2) NOT NULL ,
    D_DAY_OF_YEAR   VARCHAR2 (3) NOT NULL ,
    D_YEAR          VARCHAR2 (4) NOT NULL ,
    D_MONTH_NUM     VARCHAR2 (2) NOT NULL ,
    D_WEEK_OF_YEAR  VARCHAR2 (2) NOT NULL ,
    D_WEEK_OF_MONTH VARCHAR2 (1) NOT NULL ,
    WEEKEND_FLAG    CHAR (1) NOT NULL
  )
  TABLESPACE MAXDAT_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX CC_D_DATES_MONTH_NAME_IX ON CC_D_DATES
  (
    D_MONTH_NAME ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_D_DATES_D_WEEK_OF_MONTH_IX ON CC_D_DATES
  (
    D_WEEK_OF_MONTH ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE UNIQUE INDEX CC_D_DATES_D_DATE_UIX ON CC_D_DATES
  (
    D_DATE ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
  ALTER TABLE CC_D_DATES ADD CONSTRAINT CC_D_DATES_PK PRIMARY KEY
  (
    D_DATE_ID
  )
  ;
  ALTER TABLE CC_D_DATES ADD CONSTRAINT CC_D_DATES__UN UNIQUE
  (
    D_YEAR , D_DAY_OF_YEAR
  )
  ;
  ALTER TABLE CC_D_DATES ADD CONSTRAINT CC_D_DATES__UNv2 UNIQUE
  (
    D_MONTH , D_DAY_OF_MONTH , D_YEAR
  )
  ;

Grant select on CC_D_DATES to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW CC_D_DATES_SV
AS
SELECT *
FROM cc_d_dates
WITH read only;

Grant select on CC_D_DATES_SV to MAXDAT_READ_ONLY;

CREATE SEQUENCE SEQ_CC_D_DATE START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;  


CREATE OR REPLACE TRIGGER BI_CC_D_DATES 
    BEFORE INSERT ON CC_D_DATES 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_DATE_ID IS NULL THEN 
          SELECT SEQ_CC_D_DATE.NEXTVAL INTO :NEW.D_DATE_ID FROM DUAL;      
END IF;
END;  
/


DECLARE dt DATE := to_date('11/01/2008 00:00:00', 'MM/DD/YYYY HH24:MI:SS');
BEGIN
  --POPULATE CC_D_DATES w/ Date values
  WHILE dt < to_date('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS') LOOP
      INSERT INTO CC_D_DATES
        (D_DATE
        , d_month
        , d_month_name
        ,  d_day
        ,  d_day_name
        , d_day_of_week
        , d_day_of_month
        , d_day_of_year
        , d_year
        , d_month_num
        , d_week_of_year
        , D_WEEK_OF_MONTH 
        , WEEKEND_FLAG)
      VALUES
        (dt,
        to_char(dt,'Mon')
        , to_char(dt,'FMMonth') 
        , to_char(dt,'Dy')
        , to_char(dt,'Day')
        , to_char(dt,'D') 
        , to_char(dt,'DD') 
        , to_char(dt,'DDD') 
        , to_char(dt, 'YYYY') 
        , to_char(dt, 'MM') 
        , to_char(dt, 'IW') 
        , TO_CHAR(dt, 'W') 
        , (case when TO_CHAR(dt,'D') in('1','7') then 'Y' else 'N' end ));
      
      dt := dt + 1; 
  END LOOP;

  COMMIT;
END;
/