##################################################
#Deletes for sc_attendance_mthly 
##################################################

delete from  dp_scorecard.scorecard_attendance_mthly where dates_month_num > 201810;
/


##################################################
# Deletes for sc_attendance
##################################################

delete from dp_scorecard.sc_attendance where to_number(to_char(entry_date,'yyyymm')) > 201810 ;

/