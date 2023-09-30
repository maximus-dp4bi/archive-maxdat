--------------------------------------------------------
--  File created - Monday-August-19-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function BUSINESS_DAYS_BETWEEN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "BUSINESS_DAYS_BETWEEN" (I_START_DATE IN DATE
 ,I_END_DATE IN DATE
 )
 RETURN INTEGER
 IS

  v_num_days INTEGER;
  v_from_date DATE;
  v_to_date DATE;
BEGIN
    v_num_days := 0;

    v_from_date := trunc(i_start_date);
    v_to_date := trunc(i_end_date);

    WITH date_tab AS
    (SELECT v_from_date
    + LEVEL
    - 1 business_date
    FROM DUAL
    CONNECT BY LEVEL <=
    v_to_date
    - v_from_date
    + 1)
    SELECT count(business_date)-1  INTO v_num_days
    FROM date_tab
    WHERE TO_CHAR (business_date, 'DY') NOT IN ('SAT', 'SUN')
    AND   business_date NOT IN (SELECT holiday_date FROM holidays WHERE holiday_date
     BETWEEN v_from_date AND v_to_date );

RETURN v_num_days;
END;

/

/
