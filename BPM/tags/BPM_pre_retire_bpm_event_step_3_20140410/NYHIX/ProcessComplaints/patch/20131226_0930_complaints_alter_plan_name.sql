

alter table D_COMPLAINT_CURRENT add(PLAN_NAME Varchar2(64));

alter table NYHX_ETL_COMPLAINTS_INCIDENTS add (PLAN_NAME Varchar2(64));
alter table NYHX_ETL_COMPL_INCIDENTS_OLTP add (PLAN_NAME Varchar2(64));
alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM add (PLAN_NAME Varchar2(64));


CREATE OR REPLACE VIEW D_COMPLAINT_CURRENT_SV AS
SELECT * FROM D_COMPLAINT_CURRENT
WITH READ ONLY;

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2596,1589,22,'BOTH',to_date('2013-09-22 08:52:50','YYYY-MM-DD HH24:MI:SS'),to_date('2077-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,2596,22,'PLAN_NAME');

delete from nyhx_etl_complaints_incidents;

update corp_etl_control set value = '0' where name = 'PC_LAST_COMPLAINT';

update corp_etl_control set value = '200' where name = 'COMP_LOOK_BACK_DAYS';

commit;
