

DECLARE dt DATE := to_date('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS');
BEGIN
  --POPULATE CC_D_DATES w/ Date values
  WHILE dt < to_date('01/01/2024 00:00:00', 'MM/DD/YYYY HH24:MI:SS') LOOP
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
