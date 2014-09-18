-- insert_stg_interval.sql
--
-- populates the STG_INTERVAL table with 1 day intervals

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

        START_DATE := TMP_START_DATE + DAYS_ADDED ;
        END_DATE := TMP_START_DATE + DAYS_ADDED ;
        
        INSERT INTO CC_S_INTERVAL (
          INTERVAL_START_DATE,
          INTERVAL_END_DATE,
          INTERVAL_SECONDS
        )
        VALUES (
          START_DATE,
          END_DATE,
          1440);

  DAYS_ADDED := DAYS_ADDED + 1;
  END LOOP;

COMMIT;
END;


