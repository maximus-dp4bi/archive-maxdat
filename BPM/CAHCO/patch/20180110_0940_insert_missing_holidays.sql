INSERT INTO holidays(holiday_id,holiday_year,holiday_date,description,created_by,create_ts)
VALUES(405,'2018',TO_DATE('11/23/2018','mm/dd/yyyy'),'Day After Thanksgiving',user,sysdate);

INSERT INTO holidays(holiday_id,holiday_year,holiday_date,description,created_by,create_ts)
VALUES(406,'2019',TO_DATE('11/29/2019','mm/dd/yyyy'),'Day After Thanksgiving',user,sysdate);

commit;

