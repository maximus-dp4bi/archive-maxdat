INSERT INTO holidays(holiday_id,holiday_year, holiday_date,description,created_by,create_ts)
VALUES(seq_holiday_id.nextval,'2020',TO_DATE('03/31/2020','mm/dd/yyyy'),'Cesar Chavez Day','MAXDAT',sysdate);

UPDATE bpm_d_dates
SET business_day_flag = 'N'
WHERE d_date = to_date('03/31/2020','mm/dd/yyyy');

COMMIT;

