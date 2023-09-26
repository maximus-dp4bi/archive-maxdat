CREATE OR REPLACE Procedure DP_SCORECARD.CALC_ATTENDANCE_SCORE
   ( in_staff_id IN number )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170901_1703_CALC_ATTENDANCE_SCORE.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 21097 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-08-29 13:26:48 -0400 (Tue, 29 Aug 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';



   attendance_total number := 0;
   incentive_total number := 0;
   total number := 0;

   LV_58_DATE_MONTH_NUM  VARCHAR2(8) := '201709';

   LV_BALANCE_LIMIT     Number(2)  := 40;

   cursor c1 is
     select staff_staff_id,
              dates,
              point_value,
              sc_attendance_id,
              create_datetime,
              incentive_flag,
              incentive_balance,
              ABSENCE_TYPE  --added
         from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
         where staff_staff_id=in_staff_id
         order by dates, create_datetime;


BEGIN

  FOR RECS IN c1
  LOOP

    IF RECS.ABSENCE_TYPE LIKE 'Perfect Attendance |%'
    THEN
        LV_BALANCE_LIMIT := GREATEST(ATTENDANCE_TOTAL,40);
    ELSE
        IF TO_CHAR(RECS.DATES,'YYYYMM') < LV_58_DATE_MONTH_NUM
            THEN LV_BALANCE_LIMIT := 40;
        ELSE LV_BALANCE_LIMIT := 58;
        END IF;
    END IF;

    IF RECS.SC_ATTENDANCE_ID = 0
    THEN
        ATTENDANCE_TOTAL := ATTENDANCE_TOTAL + RECS.POINT_VALUE;
        INCENTIVE_TOTAL  := INCENTIVE_TOTAL
        + RECS.INCENTIVE_BALANCE;  --added
        TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
    ELSE
        IF RECS.ABSENCE_TYPE = 'Employee (40)*'
        THEN
            ATTENDANCE_TOTAL := GREATEST(40,ATTENDANCE_TOTAL);
            INCENTIVE_TOTAL  := INCENTIVE_TOTAL;
            TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
        ELSE
            IF RECS.INCENTIVE_FLAG = 'Y'
            THEN
                IF ATTENDANCE_TOTAL=LV_BALANCE_LIMIT
                THEN
                    ATTENDANCE_TOTAL := ATTENDANCE_TOTAL;
                    INCENTIVE_TOTAL  := INCENTIVE_TOTAL + RECS.POINT_VALUE;
                    TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;

                ELSE
                    IF ATTENDANCE_TOTAL + RECS.POINT_VALUE <= LV_BALANCE_LIMIT
                    THEN
                        ATTENDANCE_TOTAL := ATTENDANCE_TOTAL + RECS.POINT_VALUE;
                        INCENTIVE_TOTAL  := INCENTIVE_TOTAL;
                        TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
                    ELSE
                        INCENTIVE_TOTAL  := (ATTENDANCE_TOTAL + RECS.POINT_VALUE + INCENTIVE_TOTAL ) - LV_BALANCE_LIMIT ;
                        ATTENDANCE_TOTAL := LV_BALANCE_LIMIT;
                        TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
                    END IF;
                END IF;
            ELSE
                IF TOTAL + RECS.POINT_VALUE > LV_BALANCE_LIMIT
                THEN
                    IF RECS.POINT_VALUE > 0
					THEN
						INCENTIVE_TOTAL := INCENTIVE_TOTAL;
						ATTENDANCE_TOTAL := LV_BALANCE_LIMIT;
						TOTAL := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
					ELSE
						INCENTIVE_TOTAL := (TOTAL-LV_BALANCE_LIMIT) + RECS.POINT_VALUE;
						ATTENDANCE_TOTAL := LV_BALANCE_LIMIT;
						TOTAL := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
					END IF;
				ELSE
					ATTENDANCE_TOTAL := TOTAL + RECS.POINT_VALUE;
					INCENTIVE_TOTAL  := 0;
					TOTAL  := ATTENDANCE_TOTAL + INCENTIVE_TOTAL;
				END IF;
			END IF;
            --Allow negative numbers
            --	if attendance_total < 0 then
			--	attendance_total := 0;
			--	total  := attendance_total + incentive_total;
			--	end if;
        END IF;
          --running total cannot be less than 0pts
        UPDATE DP_SCORECARD.SC_ATTENDANCE
            SET BALANCE=ATTENDANCE_TOTAL,
            INCENTIVE_BALANCE=INCENTIVE_TOTAL,
            TOTAL_BALANCE=TOTAL
        WHERE STAFF_ID = IN_STAFF_ID
        AND SC_ATTENDANCE_ID = RECS.SC_ATTENDANCE_ID;

    END IF;

  END LOOP;

  commit;

END;
/
