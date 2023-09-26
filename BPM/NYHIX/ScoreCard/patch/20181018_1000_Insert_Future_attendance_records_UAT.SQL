ALTER TRIGGER dp_scorecard.TRG_CHECK_DATES DISABLE;

insert into dp_scorecard.sc_attendance ( sc_attendance_id,staff_id,entry_date,sc_all_id,absence_type,point_value,create_by,create_datetime,balance,
incentive_balance,total_balance,last_updated_by,last_updated_datetime) values
( 999999, 12482, to_Date('13-AUG-19','dd-mon-yy'), 51, 'Tardy',-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

ALTER TRIGGER dp_scorecard.TRG_CHECK_DATES ENABLE;

commit;
/