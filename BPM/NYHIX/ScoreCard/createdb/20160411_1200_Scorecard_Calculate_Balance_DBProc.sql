CREATE OR REPLACE Procedure Scorecard_Calculate_Balance
   ( in_staff_id IN number )

IS
   attendance_total number := 0;
   incentive_total number := 0;
   total number := 0;

   cursor c1 is
     select staff_id,
              dates,
              point_value,
              sc_id,
              create_datetime,
              incentive_flag
         from pp_bo_scorecard_sv
         where staff_id=in_staff_id;

BEGIN
  FOR RECS IN c1
  LOOP
        
      if RECS.sc_id = 0 then
           attendance_total := attendance_total + RECS.point_value;
           incentive_total  := incentive_total;
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
            if attendance_total < 0 then
              attendance_total := 0;
              total  := attendance_total + incentive_total;
            end if;
          end if;
          
          --running total cannot be less than 0pts
          update pp_bo_scorecard
              set balance=attendance_total,
              incentive_balance=incentive_total,
              total_balance=total
              where staff_id = in_staff_id and sc_id = RECS.sc_id;
              
      end if;  
  END LOOP;

  commit;

END;

/
