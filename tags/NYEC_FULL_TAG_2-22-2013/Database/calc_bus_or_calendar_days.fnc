CREATE OR REPLACE FUNCTION MAXDAT.calc_bus_or_calendar_days(in_date_type  VARCHAR2
                                                           ,in_beg_date   DATE
                                                           ,in_end_date   DATE) 
RETURN NUMBER
IS
/*
 * Name:          CALC_BUS_OR_CALENDAR_DAYS
 * Author:        Brian Thai
 * Creation Date: 2/1/13
 * Purpose:       Based on Business (B) or Calendar (C) date type, it will
 *                calculate the days between.
 */
 v_beg_date DATE := TRUNC(NVL(in_beg_date,SYSDATE));
 v_end_date DATE := TRUNC(NVL(in_end_date,SYSDATE));
BEGIN
  IF UPPER(in_date_type) NOT IN ('B','C')
  THEN RAISE_APPLICATION_ERROR(-20001,'Invalid date type parameter. '||
                                      'Must be B (business) or C (calendar)');
  ELSE CASE UPPER(in_date_type)
       WHEN 'B' 
       THEN RETURN(bus_days_between(v_beg_date,v_end_date));
       ELSE RETURN(v_end_date - v_beg_date);
       END CASE;
  END IF;
END calc_bus_or_calendar_days;
/
