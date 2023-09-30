
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
where FIDRBD_ID =298077;
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

Insert into MAXDAT.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('25-MAY-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('25-MAY-17 12:07:38','DD-MON-RR HH24:MI:SS'),to_date('25-MAY-17 12:07:38','DD-MON-RR HH24:MI:SS'),36553586,1,null,1,1,1,41,1,2803,3422,1,1,15266137,to_date('25-MAY-17 12:07:38','DD-MON-RR HH24:MI:SS'),to_date('25-MAY-17 12:07:38','DD-MON-RR HH24:MI:SS'),null,1,0,0);
Insert into MAXDAT.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('22-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('22-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('22-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),36534082,1,null,1,1,1,21,1,4204,5106,1,1,null,to_date('22-MAR-17 11:14:43','DD-MON-RR HH24:MI:SS'),to_date('22-MAR-17 11:14:43','DD-MON-RR HH24:MI:SS'),null,1,0,0);
Insert into MAXDAT.F_IDR_BY_DATE (FIDRBD_ID,D_DATE,BUCKET_START_DATE,BUCKET_END_DATE,IDR_BI_ID,DIDRAC_ID,CURRENT_TASK_ID,DIDRES_ID,DIDRIA_ID,DIDRID_ID,DIDRIS_ID,DIDRIN_ID,DIDRLUBN_ID,DIDRLUB_ID,DIDRRD_ID,DIDRRT_ID,CLIENT_ID,INCIDENT_STATUS_DT,LAST_UPDATE_BY_DT,COMPLETE_DT,CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) values 
(MAXDAT.SEQ_FIDRBD_ID.nextval,to_date('21-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('21-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),to_date('21-MAR-17 00:00:00','DD-MON-RR HH24:MI:SS'),36570503,1,null,1,1,1,21,22,3891,4868,1,1,null,to_date('21-MAR-17 16:30:30','DD-MON-RR HH24:MI:SS'),to_date('21-MAR-17 16:30:30','DD-MON-RR HH24:MI:SS'),null,1,0,0);
commit;
