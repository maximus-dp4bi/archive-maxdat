-- insert_stg_interval.sql
--
-- populates the STG_INTERVAL table with 15, 30, and 60 minute intervals

DECLARE 
  DAYS_ADDED INT := 0; -- day counter
  TMP_START_DATE DATE := to_date('09/26/2015 00:00:00', 'MM/DD/YYYY HH24:MI:SS'); -- datetime (24-hour format)
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
        END_DATE := TMP_START_DATE + DAYS_ADDED + (MIL_HOUR/24) + ((MIL_MINUTE + 15)/1440);
        
        INSERT INTO CC_S_INTERVAL (
          INTERVAL_START_DATE,
          INTERVAL_END_DATE,
          INTERVAL_SECONDS
        )
        VALUES (
          START_DATE,
          END_DATE,
          900);

        MIL_MINUTE := MIL_MINUTE + 15;
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


