DECLARE dt DATE := to_date('01/01/2013 00:00:00', 'MM/DD/YYYY HH24:MI:SS');
BEGIN
  --POPULATE D_DATE w/ Date values
  WHILE dt < to_date('01/01/2023 00:00:00', 'MM/DD/YYYY HH24:MI:SS') LOOP
      INSERT INTO CC_D_BLOCKED_CALLS
        (D_DATE
        )
      VALUES
        (dt
        );
      
      dt := dt + 1; 
  END LOOP;

  COMMIT;
END;
/