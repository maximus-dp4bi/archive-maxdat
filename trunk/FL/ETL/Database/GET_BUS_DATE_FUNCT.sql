--------------------------------------------------------
--  File created - Monday-August-19-2013   
--------------------------------------------------------
DROP FUNCTION "GET_BUS_DATE";
--------------------------------------------------------
--  DDL for Function GET_BUS_DATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_BUS_DATE" (P_START_DATE IN DATE,
                                               P_NUMBER_DAYS IN NUMBER := 0)
RETURN DATE
IS
  V_WEEKDATE DATE;
  V_LOOP NUMBER := 0;
  V_HOLIDAY NUMBER:=null;
  V_HOLIDAY_FLAG NUMBER := 1;
BEGIN

  IF P_NUMBER_DAYS <= 0
  THEN
      V_WEEKDATE := trunc(P_START_DATE);
      WHILE V_WEEKDATE >= trunc(P_START_DATE)
      loop
               V_HOLIDAY := 0;
               SELECT COUNT(1)
                 INTO V_HOLIDAY
                 FROM holidays
                WHERE holiday_date = V_WEEKDATE;

                 if V_HOLIDAY <> 0
                 then
                    V_WEEKDATE := V_WEEKDATE+1;
                 else
                    IF TO_CHAR(V_WEEKDATE, 'D') in (1,7) THEN
                      V_WEEKDATE := GET_WEEKDAY(V_WEEKDATE, 1);
                    end if;
                    exit; --Exit on the first business date.
                 end if;
       end loop;

     RETURN V_WEEKDATE;
  END IF;

  V_WEEKDATE := trunc(P_START_DATE);
  WHILE V_WEEKDATE >= trunc(P_START_DATE)
  loop
           V_HOLIDAY := 0;
           SELECT COUNT(1)
             INTO V_HOLIDAY
             FROM holidays
            WHERE holiday_date = V_WEEKDATE;

             if V_HOLIDAY <> 0
             then
                V_WEEKDATE := V_WEEKDATE+1;
             else
                ----Added in v4.
                IF TO_CHAR(V_WEEKDATE, 'D') in (1,7) THEN
                      V_WEEKDATE := GET_WEEKDAY(V_WEEKDATE, 1);
                end if;
                ----Added in v4.
                exit; --Exit on the first business date.
             end if;
   end loop;

      WHILE V_LOOP < P_NUMBER_DAYS
      LOOP
          V_WEEKDATE := GET_WEEKDAY(V_WEEKDATE, 1);
          V_HOLIDAY_FLAG := 1;

          WHILE V_HOLIDAY_FLAG <> 0
          LOOP

                SELECT COUNT(1)
                 INTO V_HOLIDAY
                  FROM holidays
                 WHERE holiday_date = V_WEEKDATE;

                IF V_HOLIDAY <> 0 THEN
                  V_WEEKDATE := GET_WEEKDAY(V_WEEKDATE, 1);
                ELSE
                  V_HOLIDAY_FLAG := 0;
                END IF;

          END LOOP;

          V_LOOP := V_LOOP + 1;

      END LOOP;

  RETURN V_WEEKDATE;
END;

/

/
