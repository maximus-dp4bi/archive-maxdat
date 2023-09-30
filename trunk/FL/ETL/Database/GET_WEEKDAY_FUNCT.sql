--------------------------------------------------------
--  File created - Monday-August-19-2013   
--------------------------------------------------------
DROP FUNCTION "GET_WEEKDAY";
--------------------------------------------------------
--  DDL for Function GET_WEEKDAY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_WEEKDAY" (START_DATE IN DATE, DAYS2ADD IN NUMBER := 0) RETURN DATE IS
  COUNTER      NATURAL := 0;
  CURDATE      DATE := START_DATE;
  DAYNUM       POSITIVE;
  SKIPCNTR     NATURAL := 0;
  DIRECTION    INTEGER := 1; -- days after start_date
  BUSINESSDAYS NUMBER := DAYS2ADD;
BEGIN
  IF DAYS2ADD < 0 THEN
    DIRECTION    := -1; -- days before start_date
    BUSINESSDAYS := (-1) * BUSINESSDAYS;
  END IF;
  WHILE COUNTER < BUSINESSDAYS LOOP
    CURDATE := CURDATE + DIRECTION;
    DAYNUM  := TO_CHAR(CURDATE, 'D');
    IF DAYNUM BETWEEN 2 AND 6 THEN
      COUNTER := COUNTER + 1;
    ELSE
      SKIPCNTR := SKIPCNTR + 1;
    END IF;
  END LOOP;
  RETURN START_DATE +(DIRECTION * (COUNTER + SKIPCNTR));
END Get_WeekDay;

/

/
