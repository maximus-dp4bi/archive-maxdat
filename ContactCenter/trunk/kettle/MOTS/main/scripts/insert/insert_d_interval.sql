-- insert_d_interval.sql
--
-- populates the D_INTERVAL table with 30 minute intervals

DECLARE 
  DAYS_ADDED INT := 0; -- day counter
  TMP_START_DATE DATE := to_date('01/01/2013 00:00:00', 'MM/DD/YYYY HH24:MI:SS'); -- datetime (24-hour format)
  MIL_HOUR INT := 0; -- military hour
  MIL_MINUTE INT := 0; -- minute
  START_DATE DATE;
  END_DATE DATE;
  
BEGIN
  -- populate the table with five years of data from START_DATE
  WHILE DAYS_ADDED <= 1825 LOOP

    WHILE MIL_HOUR <= 23 LOOP
              
      -- populate the table with the 30 minute intervals
      WHILE MIL_MINUTE <= 59 LOOP

        START_DATE := TMP_START_DATE + DAYS_ADDED + (MIL_HOUR/24) + (MIL_MINUTE/1440);
        END_DATE := TMP_START_DATE + DAYS_ADDED + (MIL_HOUR/24) + ((MIL_MINUTE + 30)/1440);
        
        INSERT INTO CC_D_INTERVAL (
          INTERVAL_START_DATE
          , INTERVAL_END_DATE
          , AM_PM
          , INTERVAL_START_HOUR
          , INTERVAL_START_MINUTE
          , INTERVAL_END_HOUR
          , INTERVAL_END_MINUTE
          , INTERVAL_SECONDS
          , INTERVAL_START_TIME_OF_DAY12
          , INTERVAL_START_TIME_OF_DAY24
          , INTERVAL_END_TIME_OF_DAY12
          , INTERVAL_END_TIME_OF_DAY24
          , RECORD_EFF_DT
          , RECORD_END_DT
          , VERSION          
        )
        VALUES (
          START_DATE
          , END_DATE
          , CASE WHEN TO_NUMBER(TO_CHAR(START_DATE, 'HH24')) < 12 THEN 'AM' ELSE 'PM' END
          , TO_NUMBER(TO_CHAR(START_DATE, 'HH24'))
          , TO_NUMBER(TO_CHAR(START_DATE, 'MI'))
          , TO_NUMBER(TO_CHAR(END_DATE, 'HH24'))
          , TO_NUMBER(TO_CHAR(END_DATE, 'MI'))
          , 1800
          , TO_CHAR(START_DATE, 'HH:MI')
          , TO_CHAR(START_DATE, 'HH24:MI')
          , TO_CHAR(END_DATE, 'HH:MI')
          , TO_CHAR(END_DATE, 'HH24:MI')
          , to_date('01-JAN-1900','DD-MON-YYYY')
          , to_date('12-DEC-2999','DD-MON-YYYY')
          , 1);

        MIL_MINUTE := MIL_MINUTE + 30;
      END LOOP;
      MIL_MINUTE := 0;
      
      MIL_MINUTE := 0;
      MIL_HOUR := MIL_HOUR + 1;
    END LOOP;
    MIL_HOUR := 0;
    DAYS_ADDED := DAYS_ADDED + 1;
  END LOOP;

COMMIT;
END;
