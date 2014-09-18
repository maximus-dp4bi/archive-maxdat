CREATE OR REPLACE FUNCTION MAXDAT.calc_bus_or_calendar_date(in_date_type    VARCHAR2
                                                           ,in_lookup_date  DATE
                                                           ,in_num_days     NUMBER) 
RETURN DATE
IS
/*
 * Name:          CALC_BUS_OR_CALENDAR_DAYS
 * Author:        Brian Thai
 * Creation Date: 2/1/13
 * Purpose:       Based on Business (B) or Calendar (C) date type, it will
 *                calculate the new date.
 */
BEGIN
  IF UPPER(in_date_type) NOT IN ('B','C')
  THEN RAISE_APPLICATION_ERROR(-20001,'Invalid date type parameter. '||
                                      'Must be B (business) or C (calendar)');
  ELSIF in_lookup_date IS NULL
  THEN RETURN NULL;
  ELSIF in_num_days IS NULL
  THEN RETURN NULL;
  ELSIF UPPER(in_date_type) = 'B' 
  THEN RETURN(get_bus_date(TRUNC(in_lookup_date),in_num_days));
  ELSE RETURN(TRUNC(in_lookup_date) + in_num_days);
  END IF;
END calc_bus_or_calendar_date;
/
