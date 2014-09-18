--
-- @'S:\Texas IEE Project\MAXIMUS\CHIP\TX_CHIP_REPORTING\Reporting Developers\Isaac\Docs\ICE\PLSQL\PeriodPop\release_03\period_pop.pkb'
--
-- The following execution lines are Test-Cases for the two procedures in this package.
--
-- exec period_pop.loop_period_row('01-JAN-1995', '31-DEC-2050') -- Production Values
-- exec period_pop.loop_period_row('01-JAN-1995', '31-DEC-2005')
-- exec period_pop.pop_period_row('13-AUG-1998')
--
-- Date  Created:  11-AUG-05
-- Last Modified:  03-AUG-09 Added State of Texas Fiscal Year code, and commented out
--                           Federal Fiscal Year code. Future revision may execute both
--                           sets of code by adding more attributes.
--
-- Last Modified:  01-OCT-09 Corrected a bug in the Fiscal Year calculations. And removed
--                           some attributes used in previous project, but not needed
--                            for this one.
--
-- The 2 procedures in this package populate the TIME dimension-table which for this
-- project is called EMRS_D_DATE_PERIOD.
--
-- The 2nd procedure is called first.  It takes 2 arguments, a START_DATE and END_DATE,
-- and then iterates the 1st procedure 1-DAY for every day from START_DATE to END_DATE,
-- inserting 1 row in the table for each day.  Each row contains attributes that are
-- useful for date hierarchies, date drill-downs that are commonly needed for warehouse
-- analysis and data mining.
--
-- Test Strings
-- exec period_pop.pop_period_row('13-AUG-1998')
--
CREATE OR REPLACE PACKAGE BODY period_pop IS
--
PROCEDURE pop_period_row (P_PERIOD_DATE_IN IN varchar2)  IS 
   BEGIN
     DECLARE
     sql_statement          VARCHAR2(3000);
     v_insert_success       VARCHAR2(30);
     curr_month             number;
     curr_year              number;
     curr_week              number;
     curr_dow               number;      -- day of week
--     curr_doy               varchar2(3); -- day of year
     curr_qtr               VARCHAR2(7);
     day_num                number;
     C_DATE_PERIOD_ID_SEQ   number;
     C_DATE_FULL                       EMRS_D_DATE_PERIOD.DATE_FULL%TYPE;
     C_DATE_STANDARD_1                 EMRS_D_DATE_PERIOD.DATE_STANDARD_1%TYPE;
     C_DATE_STANDARD_2                 EMRS_D_DATE_PERIOD.DATE_STANDARD_2%TYPE;
     C_DATE_STANDARD_3                 EMRS_D_DATE_PERIOD.DATE_STANDARD_3%TYPE;
     C_DATE_STANDARD_4                 EMRS_D_DATE_PERIOD.DATE_STANDARD_4%TYPE;
     C_DAY_NUMBER_IN_MONTH             EMRS_D_DATE_PERIOD.DAY_NUMBER_IN_MONTH%TYPE;
     C_DAY_NUMBER_IN_WEEK              EMRS_D_DATE_PERIOD.DAY_NUMBER_IN_WEEK%TYPE;         
     C_DAY_NUMBER_IN_YEAR              EMRS_D_DATE_PERIOD.DAY_NUMBER_IN_YEAR%TYPE;            
     C_DAY_OF_WEEK                     EMRS_D_DATE_PERIOD.DAY_OF_WEEK%TYPE;               
     C_FISCAL_HALF_YEAR                EMRS_D_DATE_PERIOD.FISCAL_HALF_YEAR%TYPE;             
     C_FISCAL_MONTH_NUM_IN_YEAR        EMRS_D_DATE_PERIOD.FISCAL_MONTH_NUM_IN_YEAR%TYPE;       
     C_FISCAL_QUARTER                  EMRS_D_DATE_PERIOD.FISCAL_QUARTER%TYPE;                
     C_FISCAL_WEEK                     EMRS_D_DATE_PERIOD.FISCAL_WEEK%TYPE;                  
     C_FISCAL_YEAR                     EMRS_D_DATE_PERIOD.FISCAL_YEAR%TYPE;                 
     C_FISCAL_YEAR_DAY_NUMBER          EMRS_D_DATE_PERIOD.FISCAL_YEAR_DAY_NUMBER%TYPE;        
     C_FISCAL_YEAR_MONTH               EMRS_D_DATE_PERIOD.FISCAL_YEAR_MONTH%TYPE;             
     C_FISCAL_YEAR_QUARTER             EMRS_D_DATE_PERIOD.FISCAL_YEAR_QUARTER%TYPE;          
     C_HOLIDAY_IND                     EMRS_D_DATE_PERIOD.HOLIDAY_IND%TYPE;                   
     C_LAST_DAY_IN_MONTH_IND           EMRS_D_DATE_PERIOD.LAST_DAY_IN_MONTH_IND%TYPE;         
     C_LAST_DAY_IN_WEEK_IND            EMRS_D_DATE_PERIOD.LAST_DAY_IN_WEEK_IND%TYPE;          
     C_MAJOR_EVENT                     EMRS_D_DATE_PERIOD.MAJOR_EVENT%TYPE;                
     C_MONTH_NAME                      EMRS_D_DATE_PERIOD.MONTH_NAME%TYPE;                 
     C_MONTH_NUMBER_IN_YEAR            EMRS_D_DATE_PERIOD.MONTH_NUMBER_IN_YEAR%TYPE;          
     C_QUARTER                         EMRS_D_DATE_PERIOD.QUARTER%TYPE;                    
     C_YEAR_QUARTER                    EMRS_D_DATE_PERIOD.YEAR_QUARTER%TYPE;              
     C_SEASON                          EMRS_D_DATE_PERIOD.SEASON%TYPE;                   
     C_WEEKDAY_IND                     EMRS_D_DATE_PERIOD.WEEKDAY_IND%TYPE;                 
     C_WEEK_ENDING_DATE                EMRS_D_DATE_PERIOD.WEEK_ENDING_DATE%TYPE;               
     C_WEEK_NUMBER_IN_YEAR             EMRS_D_DATE_PERIOD.WEEK_NUMBER_IN_YEAR%TYPE;            
     C_YEAR                            EMRS_D_DATE_PERIOD.YEAR_YYYY%TYPE;
     C_YEAR_HALF                       EMRS_D_DATE_PERIOD.YEAR_HALF%TYPE;
     C_YEAR_MONTH                      EMRS_D_DATE_PERIOD.YEAR_MONTH%TYPE;

       BEGIN
-- Format date into string: January 05 1998 ----------
               select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'fmMonth DD, YYYY')
	       into C_DATE_FULL
	       from DUAL;
--            DBMS_OUTPUT.PUT_LINE('1-' || C_DATE_FULL);


-- Format date into string: 22-MAR-1999 ----------
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'DD-MM-RRRR')
	       into C_DATE_STANDARD_1
	       from DUAL;
--           DBMS_OUTPUT.PUT_LINE('3-' || C_DATE_STANDARD_1);

-- Format date into string: 03/22/1999 ----------
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'MM/DD/RRRR')
	       into C_DATE_STANDARD_2
	       from DUAL;
--           DBMS_OUTPUT.PUT_LINE('3-' || C_DATE_STANDARD_2);

-- Format date into string: 19991225 ----------
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'RRRRMMDD')
	       into C_DATE_STANDARD_3
	       from DUAL;
--           DBMS_OUTPUT.PUT_LINE('3-' || C_DATE_STANDARD_3);


-- Format date into Date datatype: 31-DEC-2035 ----------
	     select to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR')
	       into C_DATE_STANDARD_4
	       from DUAL;
--           DBMS_OUTPUT.PUT_LINE('4-' || C_DATE_STANDARD_4);


-- Format date into string: 3rd ----------
	     select lower(to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'fmDDth'))
	       into C_DAY_NUMBER_IN_MONTH
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('4-' || C_DAY_NUMBER_IN_MONTH);

-- Format date into string: 3 ----------
	     select lower(to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'D'))
	       into C_DAY_NUMBER_IN_WEEK
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('4-' || C_DAY_NUMBER_IN_WEEK);

-- Format date into string: 236 ----------
	     select lower(to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'fmDDD'))
	       into C_DAY_NUMBER_IN_YEAR
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('5-' || C_DAY_NUMBER_IN_YEAR);

-- Format date into string: Wednesday 
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'fmDay')
	       into C_DAY_OF_WEEK
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('6-' || C_DAY_OF_WEEK);

-- Format date into string: October 1st is the start of the Federal Government Fiscal Year.
--	     select extract (month from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
--	       into CURR_MONTH
--	       from DUAL;
--
--             if CURR_MONTH between 4 and 9
--                then C_FISCAL_HALF_YEAR := '2nd Half';
--             else
--                     C_FISCAL_HALF_YEAR := '1st Half';
--             end if;
--              DBMS_OUTPUT.PUT_LINE('7-' || C_FISCAL_HALF_YEAR);


-- Format date into string: This logic will convert a Calendar month to a Texas State Fiscal Month.
-- The Texas State Fiscal Year begins September 1st and ends August 31st.
-- 	         
	     select extract (month from to_date(P_PERIOD_DATE_IN, 'dd-MON-RR'))
	       into CURR_MONTH
	       from DUAL;

             if CURR_MONTH > 8
                then  C_FISCAL_MONTH_NUM_IN_YEAR := (CURR_MONTH - 8);
             elsif CURR_MONTH <= 8
                then  C_FISCAL_MONTH_NUM_IN_YEAR := (CURR_MONTH + 4);
             end if;

--             DBMS_OUTPUT.PUT_LINE(C_FISCAL_MONTH_NUM_IN_YEAR);


-- Format date into string: '1st Half' or '2nd Half' based on the Texas State Fiscal Year.
--                          Use the Fiscal Month number determined in the previous block.

             if C_FISCAL_MONTH_NUM_IN_YEAR between 7 and 12
                then C_FISCAL_HALF_YEAR := 'Fiscal 2nd-Half';
             else
                     C_FISCAL_HALF_YEAR := 'Fiscal 1st-Half';
             end if;
--              DBMS_OUTPUT.PUT_LINE('7-' || C_FISCAL_HALF_YEAR);


-- Use the fiscal month-number variable value that was determined in the previous
-- block to determine the Fiscal Quarter.

               if      C_FISCAL_MONTH_NUM_IN_YEAR between 1 and 3
                  then C_FISCAL_QUARTER := 'Fiscal 1st Quarter';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 4 and 6
                  then C_FISCAL_QUARTER := 'Fiscal 2nd Quarter';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 7 and 9
                  then C_FISCAL_QUARTER := 'Fiscal 3rd Quarter';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 10 and 12
                  then C_FISCAL_QUARTER := 'Fiscal 4th Quarter';

               end if;
--              DBMS_OUTPUT.PUT_LINE('11 -' || C_FISCAL_QUARTER);

-- Format date into string: This logic will convert a Calendar week to a Federal Fiscal week.
--	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'WW')
--	       into CURR_WEEK
--	       from DUAL;
--
--                if    CURR_WEEK  >  39
--                    then C_FISCAL_WEEK := (CURR_WEEK - 39);
--                elsif CURR_MONTH <= 39
--                    then C_FISCAL_WEEK := (CURR_WEEK + 13);
--                end if;
--              DBMS_OUTPUT.PUT_LINE('12-' || C_FISCAL_WEEK);


-- Format date into string: This logic will convert a Calendar week to a State of Texas Fiscal week.
-- The minus-5 in the select statement accomodates for the fact that there is an overlap of 5 days
-- between the calendar week and the fiscal week.
--
	     select to_char((to_date((P_PERIOD_DATE_IN), 'dd-MON-RRRR') -5), 'WW')
	       into CURR_WEEK
	       from DUAL;

                if    CURR_WEEK  >=  35
                    then C_FISCAL_WEEK := (CURR_WEEK - 34);
                elsif CURR_WEEK   <  35
                    then C_FISCAL_WEEK := (CURR_WEEK + 18);
                end if;
--              DBMS_OUTPUT.PUT_LINE('12-' || C_FISCAL_WEEK);
--



-- Format date into string: Determines whether a Date is within which Federal Fiscal Year.
--	     select extract (year from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
--	       into CURR_YEAR
--	       from DUAL;
--
--                if    to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR') >=  to_date(('01-OCT-' || CURR_YEAR), 'dd-MON-RRRR')
--                   then  C_FISCAL_YEAR := (CURR_YEAR + 1);
--                else     C_FISCAL_YEAR :=  CURR_YEAR;
--                end if;
--              DBMS_OUTPUT.PUT_LINE('13-' || C_FISCAL_YEAR);



-- Format date into string: Determines whether a Date is within which Federal Fiscal Year.
	     select extract (year from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
	       into CURR_YEAR
	       from DUAL;

                if    to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR') >=  to_date(('01-SEP-' || CURR_YEAR), 'dd-MON-RRRR')
                   then  C_FISCAL_YEAR := (CURR_YEAR + 1);
                else     C_FISCAL_YEAR :=  CURR_YEAR;
                end if;
--              DBMS_OUTPUT.PUT_LINE('13-' || C_FISCAL_YEAR);



-- Format date into string: Determines the Day Number in the State of Texas Fiscal Year.
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'ddd')
	       into day_num
	       from DUAL;

                if    day_num >= 244
                    then C_FISCAL_YEAR_DAY_NUMBER := (day_num - 243);
                elsif day_num  < 244
                    then C_FISCAL_YEAR_DAY_NUMBER := (day_num + 122);
                end if;
--              DBMS_OUTPUT.PUT_LINE('14-' || C_FISCAL_YEAR_DAY_NUMBER);



-- Format date using previously stored variables into Fiscal Year Month 'F2004-01" format.
	     C_FISCAL_YEAR_MONTH := ('F'|| C_FISCAL_YEAR || '-' || C_FISCAL_MONTH_NUM_IN_YEAR);
--	     DBMS_OUTPUT.PUT_LINE('15-' || C_FISCAL_YEAR_MONTH);



-- Format date into: Fiscal Year Quarter 'F2004-2nd" format.
               if      C_FISCAL_MONTH_NUM_IN_YEAR between 1 and 3
                  then curr_qtr := '1st Qtr';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 4 and 6
                  then curr_qtr := '2nd Qtr';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 7 and 9
                  then curr_qtr := '3rd Qtr';

               elsif C_FISCAL_MONTH_NUM_IN_YEAR between 10 and 12
                  then curr_qtr := '4th Qtr';
               end if;

	     C_FISCAL_YEAR_QUARTER := ('F'|| C_FISCAL_YEAR || '-' || curr_qtr);
--	     DBMS_OUTPUT.PUT_LINE('16-' || C_FISCAL_YEAR_QUARTER);
/*
-- Create this code section at a later date. 'Holiday' if the date is on a standard Holiday.
--                  
             if  (select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'MON/DD')
                    into C_HOLIDAY_IND
                    from dual
                   where (select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'ddd'))
                            from dual
                           where C_HOLIDAY_IND
                      IN ('DEC/31', 'JAN/01', 'JAN/17', 'MAY/30', 'JUL/04'
                        , 'DEC/24', 'DEC/25'
                        )
                )
                then C_HOLIDAY_IND := ('Holiday');
*/
-- Complete this Holiday Indicator column later when time and information permit.
             C_HOLIDAY_IND := 'Unknown';
--              DBMS_OUTPUT.PUT_LINE('17-' || C_HOLIDAY_IND);


-- Convert incoming date to what Tinker Air Force calls one of its
-- Julian formats, in this case "YYYYDDD", i.e 2003321.
--	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'YYYY')
--	       into C_AF_CENTURY_DAY_DATE
--	       from DUAL;
--
--	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'DDD')
--	       into curr_doy
--	       from DUAL;
--
--             C_AF_CENTURY_DAY_DATE :=  C_AF_CENTURY_DAY_DATE || curr_doy;
--    DBMS_OUTPUT.PUT_LINE('18-' || C_AF_CENTURY_DAY_DATE);

-- Convert incoming date to what Tinker Air Force calls another of its
-- Julian forma, in this case "YDDD", i.e 3321.
--	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'Y')
--	       into C_AF_YEAR_DAY_DATE
--	       from DUAL;
--
--	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'DDD')
--	       into curr_doy
--	       from DUAL;
--
--           C_AF_YEAR_DAY_DATE := C_AF_YEAR_DAY_DATE || curr_doy;
--    DBMS_OUTPUT.PUT_LINE('18-' || C_AF_YEAR_DAY_DATE);

-- Determines whether this date is the last day in the Month.
             select extract (day from (to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR') + 1))
	       into day_num
	       from DUAL;

             if day_num = 1 then
                C_LAST_DAY_IN_MONTH_IND := 'Y';
             else
                C_LAST_DAY_IN_MONTH_IND := 'N';
             end if;
--              DBMS_OUTPUT.PUT_LINE('19-' || C_LAST_DAY_IN_MONTH_IND);


-- Determines whether this date is the last day in the Week.  Last Date = Saturday.
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'd')
	       into day_num
	       from DUAL;

             if day_num = 7 then
                C_LAST_DAY_IN_WEEK_IND := 'Y';
             else
                C_LAST_DAY_IN_WEEK_IND := 'N';
             end if;
--              DBMS_OUTPUT.PUT_LINE('20-' || C_LAST_DAY_IN_WEEK_IND);

-- Complete this Major Event column later when time and information permit.
             C_MAJOR_EVENT := 'Undetermined';
--              DBMS_OUTPUT.PUT_LINE('21-' || C_MAJOR_EVENT);

-- Format date into string: February 
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'fmMonth')
	       into C_MONTH_NAME
	       from DUAL;

--              DBMS_OUTPUT.PUT_LINE('22-' || C_MONTH_NAME);


-- Format date into string: This displays the Calendar month number.
	     select extract (month from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
	       into CURR_MONTH
	       from DUAL;

             C_MONTH_NUMBER_IN_YEAR := CURR_MONTH;
--              DBMS_OUTPUT.PUT_LINE('23-' || C_MONTH_NUMBER_IN_YEAR);

-- Format date into string: This section used the variable from the previous section to compute the calendar quarter.
               if      C_MONTH_NUMBER_IN_YEAR between 1 and 3
                  then C_QUARTER := 'Calendar 1st Quarter';

               elsif C_MONTH_NUMBER_IN_YEAR between 4 and 6
                  then C_QUARTER := 'Calendar 2nd Quarter';

               elsif C_MONTH_NUMBER_IN_YEAR between 7 and 9
                  then C_QUARTER := 'Calendar 3rd Quarter';

               elsif C_MONTH_NUMBER_IN_YEAR between 10 and 12
                  then C_QUARTER := 'Calendar 4th Quarter';

               end if;
--              DBMS_OUTPUT.PUT_LINE('24 -' || C_QUARTER);

-- Format date into: Calendar Year Quarter 'F2004-2nd Qtr" format.
               if    C_MONTH_NUMBER_IN_YEAR between 1 and 3
                  then curr_qtr := '1st Qtr';

               elsif C_MONTH_NUMBER_IN_YEAR between 4 and 6
                  then curr_qtr := '2nd Qtr';

               elsif C_MONTH_NUMBER_IN_YEAR between 7 and 9
                  then curr_qtr := '3rd Qtr';

               elsif C_MONTH_NUMBER_IN_YEAR between 10 and 12
                  then curr_qtr := '4th Qtr';
               end if;

	     C_YEAR_QUARTER := (CURR_YEAR || '-' || curr_qtr);
--	     DBMS_OUTPUT.PUT_LINE('25-' || C_YEAR_QUARTER);

-- Format date into Season Name.
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'ddd')
               into day_num
                from dual;

               if    day_num between 80 and 171
                  then C_SEASON := 'Spring';

               elsif day_num between 172 and 263
                  then C_SEASON := 'Summer';

               elsif day_num between 264 and 354
                  then C_SEASON := 'Fall';

               elsif day_num between 355 and 366
                  then C_SEASON := 'Winter';
               
               elsif day_num between 1 and 79
                  then C_SEASON := 'Winter';
               end if;
--	     DBMS_OUTPUT.PUT_LINE('26-' || C_SEASON);

-- Determine whether a day is a weekday or weekend?  Use previously determined value.

	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'D')
	       into curr_dow
               from dual;

             if curr_dow between 2 and 6
                  then C_WEEKDAY_IND := 'Week-Day';
                else   C_WEEKDAY_IND := 'Week-END';
             end if;
--               DBMS_OUTPUT.PUT_LINE('27-' || curr_dow);

-- Determine whether a day is a weekday or weekend?

             if curr_dow  = 7
                then C_WEEK_ENDING_DATE := to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR');
             else    C_WEEK_ENDING_DATE := to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR') + (7 - curr_dow);
             end if;
--              DBMS_OUTPUT.PUT_LINE('28-' || C_WEEK_ENDING_DATE);


-- Format date to a Calendar Week number.
	     select to_char(to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'), 'WW')
	       into C_WEEK_NUMBER_IN_YEAR
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('29-' || C_WEEK_NUMBER_IN_YEAR);

-- Format date to a Calendar Year number.
	     select extract (year from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
	       into C_YEAR
	       from DUAL;
--              DBMS_OUTPUT.PUT_LINE('30-' || C_YEAR);

-- Format date into 1st and 2nd halves of the Calendar Year.
	     select extract (month from to_date(P_PERIOD_DATE_IN, 'dd-MON-RRRR'))
	       into CURR_MONTH
	       from DUAL;

             if CURR_MONTH between 7 and 12
                then C_YEAR_HALF := '2nd Half';
             else
                     C_YEAR_HALF := '1st Half';
             end if;
--              DBMS_OUTPUT.PUT_LINE('31-' || C_YEAR_HALF);

-- Format date using previously stored variables into Fiscal Year Month 'F2004-01" format.
	     C_YEAR_MONTH := (C_YEAR || '-' || C_MONTH_NUMBER_IN_YEAR);
--     DBMS_OUTPUT.PUT_LINE('32-' || C_YEAR_MONTH);

	     sql_statement := 'INSERT INTO EMRS_D_DATE_PERIOD
                                  (DATE_PERIOD_ID
                                 , DATE_FULL
                                 , DATE_STANDARD_1
                                 , DATE_STANDARD_2
                                 , DAY_NUMBER_IN_MONTH
                                 , DAY_NUMBER_IN_WEEK
                                 , DAY_NUMBER_IN_YEAR
                                 , DAY_OF_WEEK
                                 , FISCAL_HALF_YEAR
                                 , FISCAL_MONTH_NUM_IN_YEAR
                                 , FISCAL_QUARTER
                                 , FISCAL_WEEK
                                 , FISCAL_YEAR
                                 , FISCAL_YEAR_DAY_NUMBER
                                 , FISCAL_YEAR_MONTH
                                 , FISCAL_YEAR_QUARTER
                                 , HOLIDAY_IND
                                 , LAST_DAY_IN_MONTH_IND
                                 , LAST_DAY_IN_WEEK_IND
                                 , MAJOR_EVENT
                                 , MONTH_NAME
                                 , MONTH_NUMBER_IN_YEAR
                                 , QUARTER
                                 , SEASON
                                 , WEEKDAY_IND
                                 , WEEK_ENDING_DATE
                                 , WEEK_NUMBER_IN_YEAR
                                 , YEAR_YYYY
                                 , YEAR_HALF
                                 , YEAR_MONTH
                                 , YEAR_QUARTER
                                 , date_standard_3
                                 , date_standard_4)
                               VALUES (EMRS_SEQ_DATE_PERIOD_ID.nextval
                                    , :2  , :3  , :4  , :5  , :6
                                    , :7  , :8  , :9  , :10 , :11
                                    , :12 , :13 , :14 , :15 , :16
                                    , :17 , :18 , :19 , :20 , :21
                                    , :22 , :23 , :24 , :25 , :26
                                    , :27 , :28 , :29 , :30 , :31
                                    , :32 , :33)';
             EXECUTE IMMEDIATE sql_statement
--                                INTO v_insert_success
                                 USING C_DATE_FULL
                                     , C_DATE_STANDARD_1
                                     , C_DATE_STANDARD_2
                                     , C_DAY_NUMBER_IN_MONTH
                                     , C_DAY_NUMBER_IN_WEEK
                                     , C_DAY_NUMBER_IN_YEAR
                                     , C_DAY_OF_WEEK
                                     , C_FISCAL_HALF_YEAR
                                     , C_FISCAL_MONTH_NUM_IN_YEAR
                                     , C_FISCAL_QUARTER
                                     , C_FISCAL_WEEK
                                     , C_FISCAL_YEAR
                                     , C_FISCAL_YEAR_DAY_NUMBER
                                     , C_FISCAL_YEAR_MONTH
                                     , C_FISCAL_YEAR_QUARTER
                                     , C_HOLIDAY_IND
                                     , C_LAST_DAY_IN_MONTH_IND
                                     , C_LAST_DAY_IN_WEEK_IND
                                     , C_MAJOR_EVENT
                                     , C_MONTH_NAME
                                     , C_MONTH_NUMBER_IN_YEAR
                                     , C_QUARTER
                                     , C_SEASON
                                     , C_WEEKDAY_IND
                                     , C_WEEK_ENDING_DATE
                                     , C_WEEK_NUMBER_IN_YEAR
                                     , C_YEAR
                                     , C_YEAR_HALF
                                     , C_YEAR_MONTH
                                     , C_YEAR_QUARTER
                                     , C_DATE_STANDARD_3
                                     , C_DATE_STANDARD_4;
--             EXCEPTION
--                WHEN NO_DATA_FOUND THEN
--                   DBMS_OUTPUT.PUT_LINE('No INSERT for date: ' || P_PERIOD_DATE_IN);
        END;
--      END;
   END pop_period_row;
--
--
PROCEDURE loop_period_row (P_PERIOD_DATE_START_IN IN varchar2
                         , P_PERIOD_DATE_END_IN   IN varchar2 )  IS 
   BEGIN
      DECLARE
         from_j      number;
         to_j        number;
         curr_date   varchar2(11);
      BEGIN
         select to_char(to_date(P_PERIOD_DATE_START_IN, 'dd-MON-RRRR'), 'j')
           into from_j
           from DUAL;

         select to_char(to_date(P_PERIOD_DATE_END_IN, 'dd-MON-RRRR'), 'j')
           into to_j
           from DUAL;

         curr_date := P_PERIOD_DATE_START_IN;

         FOR i IN from_j..to_j
         LOOP
            period_pop.pop_period_row(curr_date);

            select to_char((to_date(curr_date, 'dd-MON-RRRR') + 1), 'dd-MON-RRRR')
              into curr_date
              from DUAL;

--         DBMS_OUTPUT.PUT_LINE('34-' || curr_date);

         END LOOP;

         commit;
       END;
   END loop_period_row;
END period_pop;
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
