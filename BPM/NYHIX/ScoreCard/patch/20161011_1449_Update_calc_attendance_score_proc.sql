CREATE OR REPLACE Procedure DP_SCORECARD.Calc_Attendance_Score
   ( in_staff_id IN number )

IS
   attendance_total number := 0;
   incentive_total number := 0;
   total number := 0;

   cursor c1 is
     select staff_staff_id,
              dates,
              point_value,
              sc_attendance_id,
              create_datetime,
              incentive_flag
              ,incentive_balance  --added
         from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
         where staff_staff_id=in_staff_id
         order by dates, create_datetime;


BEGIN
  FOR RECS IN c1
  LOOP

      if RECS.sc_attendance_id = 0 then
           attendance_total := attendance_total + RECS.point_value;
           incentive_total  := incentive_total
           + RECS.incentive_balance;  --added
           total  := attendance_total + incentive_total;
      else
          if RECS.incentive_flag = 'Y' then
            if attendance_total=40 then
              attendance_total := attendance_total;
              incentive_total  := incentive_total + RECS.point_value;
              total  := attendance_total + incentive_total;

            else
              if attendance_total + RECS.point_value <= 40 then
                attendance_total := attendance_total + RECS.point_value;
                incentive_total  := incentive_total;
                total  := attendance_total + incentive_total;
              else
                incentive_total  := (attendance_total + RECS.point_value + incentive_total ) - 40 ;
                attendance_total := 40;
                total  := attendance_total + incentive_total;
              end if;
            end if;
          else
            if total + RECS.point_value > 40 then
              if RECS.point_value > 0 then
                incentive_total := incentive_total;
                attendance_total := 40;
                total := attendance_total + incentive_total;
              else
                incentive_total := (total-40) + RECS.point_value;
                attendance_total := 40;
                total := attendance_total + incentive_total;
              end if;
            else
              attendance_total := total + RECS.point_value;
              incentive_total  := 0;
              total  := attendance_total + incentive_total;
            end if;
            --Allow negative numbers
            /*if attendance_total < 0 then
              attendance_total := 0;
              total  := attendance_total + incentive_total;
            end if;*/
          end if;

          --running total cannot be less than 0pts
          update DP_SCORECARD.SC_ATTENDANCE
              set balance=attendance_total,
              incentive_balance=incentive_total,
              total_balance=total
              where staff_id = in_staff_id and sc_attendance_id = RECS.sc_attendance_id;

      end if;
  END LOOP;

  commit;

END;
/

GRANT EXECUTE ON DP_SCORECARD.CALC_ATTENDANCE_SCORE TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.CALC_ATTENDANCE_SCORE TO MAXDAT_read_only;
GRANT EXECUTE ON DP_SCORECARD.CALC_ATTENDANCE_SCORE TO MAXDAT;

