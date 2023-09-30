INSERT INTO corp_etl_control VALUES ('IMR_EXPERT_Q_LAST_RPTDATE','D','20140828','Last report date for IMR_Daily_Days_in_Expert_queue.ktr in YYYYMMDD',SYSDATE,SYSDATE);
INSERT INTO corp_etl_control VALUES ('IMR_DAYS_WITH_EXPERT_LAST_RPTDATE','D','20140828','Last report date for IMR_Daily_Days_with_Expert.ktr in YYYYMMDD',SYSDATE,SYSDATE);
COMMIT;

delete from RA_IMR_DAYS_WITH_EXPERT
where ridwe_id in (
            select RIDWE_ID from (
            select max(RIDWE_ID) as RIDWE_ID,
            count(RIDWE_ID) as cnt,
            EXPERT_LIC_NAME,
            REPORT_DATE
            from RA_IMR_DAYS_WITH_EXPERT
            group by EXPERT_LIC_NAME,
            REPORT_DATE
            having  count(RIDWE_ID)>1) 
);

delete from RA_IMR_DAYS_IN_EXPERT_QUEUE
where ridieq_id in (
              select ridieq_id from (
              select max(ridieq_id) as ridieq_id, 
              count(ridieq_id) as cnt,
              queue_name, 
              expert_specialty, 
              report_date
               from RA_IMR_DAYS_IN_EXPERT_QUEUE
              group by queue_name, 
              expert_specialty, 
              report_date
              having  count(ridieq_id)>1              )
);

commit;

ALTER TABLE RA_IMR_DAYS_IN_EXPERT_QUEUE ADD CONSTRAINT unq_day_inexpert_queue UNIQUE (queue_name,expert_specialty,report_date ) ;
ALTER TABLE RA_IMR_DAYS_WITH_EXPERT ADD CONSTRAINT unq_day_with_expert UNIQUE (expert_lic_name,report_date ); 

