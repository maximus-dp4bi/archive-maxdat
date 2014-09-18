UPDATE corp_mj_file_cal_lkup
SET percentage_of_errors_to_alert = 0.01
WHERE percentage_of_errors_to_alert is null;   
commit;