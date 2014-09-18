--
-- @'S:\Texas IEE Project\MAXIMUS\CHIP\TX_CHIP_REPORTING\Reporting Developers\Isaac\Docs\ICE\PLSQL\Time Dim\time_period_pop.pkb'
--
--
-- Test Execution Strings:
-- exec period_time_pop.loop_time_period_row
--
-- Date  Created:  07-OCT-09
--
-- The 2 procedures in this package populate the TIME dimension-table which for this
-- project is called EMRS_D_TIME_PERIOD.
--
-- The 2nd procedure (LOOP_TIME_PERIOD_ROW) takes no arguments and is called first.  It then 
-- iterates the 1st procedure (POP_TIME_PERIOD_ROW) once for every second in a 24hr day
-- from 00:00:00 (HH24:MI:SS) until 23:59:59, inserting 1 row in the table for each second
-- in the day.  Each row contains attributes that are useful for TIME hierarchies, 
-- TIME drill-downs that are commonly needed for warehouse analysis and data mining.
--
--
CREATE OR REPLACE PACKAGE BODY period_time_pop IS
--
PROCEDURE pop_time_period_row (CURR_TIME_IN     IN  varchar2)  IS 
   BEGIN
     DECLARE
     sql_statement          VARCHAR2(3000);
     C_TIME_PERIOD_ID_SEQ   number;
     C_HOUR_MINUTE			EMRS_D_TIME_PERIOD.HOUR_MINUTE%TYPE;
     C_HOUR_MINUTE_MILITARY		EMRS_D_TIME_PERIOD.HOUR_MINUTE_MILITARY%TYPE;
     C_MORNING_NOON_NIGHT		EMRS_D_TIME_PERIOD.MORNING_NOON_NIGHT%TYPE;
     C_OPEN_LUNCH_CLOSE                 EMRS_D_TIME_PERIOD.OPEN_LUNCH_CLOSE%TYPE;
     C_HOUR				EMRS_D_TIME_PERIOD.HOUR%TYPE;
     C_MINUTE				EMRS_D_TIME_PERIOD.MINUTE%TYPE;         
     C_SECOND				EMRS_D_TIME_PERIOD.SECOND%TYPE;            
     C_MILITARY_HOUR			EMRS_D_TIME_PERIOD.MILITARY_HOUR%TYPE;               
     C_MILITARY_MINUTE			EMRS_D_TIME_PERIOD.MILITARY_MINUTE%TYPE;             
     C_MILITARY_SECOND			EMRS_D_TIME_PERIOD.MILITARY_SECOND%TYPE;  

       BEGIN

-- test string: 01-JAN-2010 01:14:54


------------ Format date into string: 11:59 ----------
               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'HH:MI')
	       into C_HOUR_MINUTE
	       from DUAL;
-- DBMS_OUTPUT.PUT_LINE(CURR_TIME_IN);
-- DBMS_OUTPUT.PUT_LINE(C_HOUR_MINUTE);

-- Format date into string: 24:59 ----------
	     select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'HH24:MI')
	       into C_HOUR_MINUTE_MILITARY
	       from DUAL;
--          DBMS_OUTPUT.PUT_LINE('3-' || C_HOUR_MINUTE_MILITARY);

-- Format date into string: Night ----------

		IF           to_date(CURR_TIME_IN,'dd-mon-yyyy HH24:MI:SS')
		    between (to_date('01-JAN-2010 06:06:00', 'dd-mon-yyyy HH24:MI:SS'))
		        and (to_date('01-JAN-2010 11:59:59', 'dd-mon-yyyy HH24:MI:SS'))
		   then  C_MORNING_NOON_NIGHT := 'Morning';
		  elsif      to_date(CURR_TIME_IN,'dd-mon-yyyy HH24:MI:SS')
		    between (to_date('01-JAN-2010 12:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		        and (to_date('01-JAN-2010 18:30:00', 'dd-mon-yyyy HH24:MI:SS'))
		   then  C_MORNING_NOON_NIGHT := 'Afternoon';
		  else   C_MORNING_NOON_NIGHT := 'Night';
		END IF;

--           DBMS_OUTPUT.PUT_LINE('3-' || C_MORNING_NOON_NIGHT);

-- Format date into string: Closing Hours ----------

		IF           to_date(CURR_TIME_IN,'dd-mon-yyyy HH24:MI:SS')
		    between (to_date('01-JAN-2010 07:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		        and (to_date('01-JAN-2010 10:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		   then  C_OPEN_LUNCH_CLOSE := 'Office Opening';
		  elsif      to_date(CURR_TIME_IN,'dd-mon-yyyy HH24:MI:SS')
		    between (to_date('01-JAN-2010 11:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		        and (to_date('01-JAN-2010 13:30:00', 'dd-mon-yyyy HH24:MI:SS'))
		   then  C_OPEN_LUNCH_CLOSE := 'Lunch Hours';
		  elsif      to_date(CURR_TIME_IN,'dd-mon-yyyy HH24:MI:SS')
		    between (to_date('01-JAN-2010 16:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		        and (to_date('01-JAN-2010 18:00:00', 'dd-mon-yyyy HH24:MI:SS'))
		   then  C_OPEN_LUNCH_CLOSE := 'Closing Hours';
		  else   C_OPEN_LUNCH_CLOSE := 'Other Hours';
		END IF;




-- Format date into string: 3pm ----------

               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'fmHHpm')
	       into C_HOUR
	       from DUAL;
--            DBMS_OUTPUT.PUT_LINE('1-' || C_HOUR);



-- Format date into string: 31 ----------

               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'fmMI')
	       into C_MINUTE
	       from DUAL;

--              DBMS_OUTPUT.PUT_LINE('5-' || C_MINUTE);
-- Format date into string: 58

               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'fmSS')
	       into C_SECOND
	       from DUAL;

--              DBMS_OUTPUT.PUT_LINE('6-' || C_SECOND);

-- Format date into string: 08.

               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'HH24')
	       into C_MILITARY_HOUR
	       from DUAL;

--              DBMS_OUTPUT.PUT_LINE('7-' || C_MILITARY_HOUR);


-- Format date into string: 38
-- 	         
               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'MI')
	       into C_MILITARY_MINUTE
	       from DUAL;

--             DBMS_OUTPUT.PUT_LINE(C_MILITARY_MINUTE);


-- Format date into string: 59

               select to_char(to_date(CURR_TIME_IN, 'dd-MON-YYYY HH24:MI:SS'), 'SS')
	       into C_MILITARY_SECOND
	       from DUAL;

--            DBMS_OUTPUT.PUT_LINE('c-' || CURR_TIME_IN);
--            DBMS_OUTPUT.PUT_LINE('m-' || C_MILITARY_SECOND);


	     sql_statement := 'INSERT INTO EMRS_D_TIME_PERIOD
                                  (TIME_PERIOD_ID
                                 , HOUR_MINUTE
                                 , HOUR_MINUTE_MILITARY
                                 , MORNING_NOON_NIGHT
                                 , OPEN_LUNCH_CLOSE
                                 , HOUR
                                 , MINUTE
                                 , SECOND
                                 , MILITARY_HOUR
                                 , MILITARY_MINUTE
                                 , MILITARY_SECOND
				  )
                               VALUES (EMRS_SEQ_TIME_PERIOD_ID.nextval
                                    , :2  , :3  , :4  , :5  , :6
                                    , :7  , :8  , :9  , :10 , :11
				  )';
             EXECUTE IMMEDIATE sql_statement
                                 USING C_HOUR_MINUTE
                                     , C_HOUR_MINUTE_MILITARY
                                     , C_MORNING_NOON_NIGHT
                                     , C_OPEN_LUNCH_CLOSE
                                     , C_HOUR
                                     , C_MINUTE
                                     , C_SECOND
                                     , C_MILITARY_HOUR
                                     , C_MILITARY_MINUTE
                                     , C_MILITARY_SECOND;
	     commit;  -- The program runs slower (3min) with the COMMIT here, but it uses less TEMP space.

--             EXCEPTION
--                WHEN NO_DATA_FOUND THEN
--                   DBMS_OUTPUT.PUT_LINE('No INSERT for date: ' || CURR_TIME_IN);
        END;
--      END;
   END pop_time_period_row;
--
--
PROCEDURE loop_time_period_row IS 
   BEGIN
      DECLARE
         to_HH       number(2) := 00;
         to_MI       number(2) := 00;
         to_SS       number(2) := 00;
         curr_date   varchar2(22);
         HHMMSS      varchar2(8);
	BEGIN

	WHILE (to_HH <= 23) LOOP

		IF to_HH <= 23
			THEN HHMMSS    := to_char(to_HH) || ':' || to_char(to_MI) || ':' || to_char(to_SS);

-- An arbitrary date is set here for all rows.  Since this is the TIME dimension, the DATE doesn't
-- matter.  It is the time portion (HHMMSS) that matters for the table.

		             curr_date := '01-JAN-2010 ' || HHMMSS; 
			     period_time_pop.pop_time_period_row(curr_date);

			     to_SS  :=   to_SS + 1;


			     IF to_SS = 60
				THEN to_MI := to_MI + 1;
			     END IF;

			     IF to_MI = 60
				THEN to_HH := to_HH + 1;
			     END IF;



			     if to_SS = 60
		   		then to_SS := 00;
			     end if;

			     if to_MI = 60
				then to_MI := 00;
			     end if;
		END IF;

-- DBMS_OUTPUT.PUT_LINE(curr_date);

	END LOOP;

--       commit;  -- The COMMIT here runs faster (2min), but uses a lot of TEMP space.
        END;
   END loop_time_period_row;
END period_time_pop;
--
--
-- DBMS_OUTPUT.PUT_LINE('column  ' || UPPER(p_column_name_in) || '  is in  TABLE  ' || v_source_name_is);
-- SET SERVEROUTPUT ON size 1000000
-- rm_event_fact.person_id%TYPE
-- DBMS_OUTPUT.ENABLE(100000);
-- DBMS_OUTPUT.NEW_LINE();
--
/
show errors
