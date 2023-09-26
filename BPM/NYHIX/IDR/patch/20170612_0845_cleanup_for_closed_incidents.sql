
begin
  for cur in (select fk.owner, fk.constraint_name , fk.table_name 
    from all_constraints fk, all_constraints pk 
     where fk.CONSTRAINT_TYPE = 'R' and 
           pk.owner = 'MAXDAT' and
           fk.r_owner = pk.owner and
           fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
           pk.TABLE_NAME = 'F_IDR_BY_DATE') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  end loop;
end;
/

delete from maxdat.F_IDR_BY_DATE
where FIDRBD_ID in (296955, 200149,197254);

update maxdat.F_IDR_BY_DATE set creation_count=0
where FIDRBD_ID = 296951;

update  maxdat.F_IDR_BY_DATE set completion_count=0, COMPLETE_DT=null, DIDRAC_ID=1, DIDRES_ID=1,DIDRIA_ID=1,DIDRID_ID=1,DIDRLUBN_ID=1, DIDRLUB_ID=1
where FIDRBD_ID = 295495;

update maxdat.F_IDR_BY_DATE set complete_dt=to_date('08-JUN-17 10:02:43','DD-MON-RR HH24:MI:SS')
where FIDRBD_ID = 296204;

update maxdat.d_idr_current set cur_complete_dt = instance_complete_dt 
where incident_id = 36560531;
commit;

begin
  for cur in (select fk.owner, fk.constraint_name , fk.table_name 
   from all_constraints fk, all_constraints pk 
    where fk.CONSTRAINT_TYPE = 'R' and 
          pk.owner = 'MAXDAT' and
          fk.r_owner = pk.owner and
          fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME and 
          pk.TABLE_NAME = 'F_IDR_BY_DATE') loop
    execute immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end loop;
end;
/
SET DEFINE OFF;
Insert into maxdat.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('07-APR-17 11:15:40','DD-MON-RR HH24:MI:SS'),to_date('07-APR-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('07-APR-17 00:00:00','DD-MON-RR HH24:MI:SS'),36543114,82779,null,2,21,59416,41,22,2803,3422,1,1,13647734,to_date('07-APR-17 11:15:40','DD-MON-RR HH24:MI:SS'),to_date('07-APR-17 11:15:40','DD-MON-RR HH24:MI:SS'),to_date('07-APR-17 11:15:40','DD-MON-RR HH24:MI:SS'),1,0,1);
Insert into maxdat.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('27-JUL-16 11:57:22','DD-MON-RR HH24:MI:SS'),to_date('27-JUL-16 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('27-JUL-16 00:00:00','DD-MON-RR HH24:MI:SS'),36560982,49649,null,2,21,30404,4,22,1761,1981,1,1,16252872,to_date('27-JUL-16 11:57:22','DD-MON-RR HH24:MI:SS'),to_date('27-JUL-16 11:57:22','DD-MON-RR HH24:MI:SS'),to_date('27-JUL-16 11:57:22','DD-MON-RR HH24:MI:SS'),0,0,1);
Insert into maxdat.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('08-JAN-14 16:52:31','DD-MON-RR HH24:MI:SS'),to_date('08-JAN-14 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('08-JAN-14 00:00:00','DD-MON-RR HH24:MI:SS'),36573146,5309,null,2,21,860,5,22,88,107,548,1,null,to_date('08-JAN-14 16:52:31','DD-MON-RR HH24:MI:SS'),to_date('08-JAN-14 16:52:31','DD-MON-RR HH24:MI:SS'),to_date('27-DEC-13 10:16:40','DD-MON-RR HH24:MI:SS'),0,0,1);
commit;


