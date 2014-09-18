
SELECT SEQ_D_REPORTING_PERIOD.NEXTVAL FROM D_REPORTING_PERIOD;

DECLARE
  TMP_START_DATE DATE := TO_DATE('01/01/2013', 'MM/DD/YYYY');
  TMP_END_DATE DATE;

  
BEGIN
  -- populate the table with five years of data from START_DATE
  WHILE TMP_START_DATE < to_date('01/01/2019', 'MM/DD/YYYY') LOOP

    TMP_END_DATE := trunc(last_day(TMP_START_DATE));
    
    INSERT INTO D_REPORTING_PERIOD (
      TYPE
      , START_DATE
      , END_DATE
      , MONTH
      , YEAR
    ) VALUES (
      'MONTHLY'
      , TMP_START_DATE
      , TMP_END_DATE
      , TO_CHAR(TMP_START_DATE, 'Month')
      , TO_NUMBER(TO_CHAR(TMP_START_DATE, 'YYYY'))
    );
    
    
    TMP_START_DATE := TMP_END_DATE + 1;
    
  END LOOP;
COMMIT;
END;
/
