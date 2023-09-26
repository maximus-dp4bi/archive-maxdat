ALTER TABLE MAXDAT.TS_CAHCO_TRACK_DOWNTIME 
ADD ignore_flag             VARCHAR2(1);

update MAXDAT.TS_CAHCO_TRACK_DOWNTIME set ignore_flag='N' where 1=1;

CREATE OR REPLACE VIEW MAXDAT.TS_CAHCO_TRACK_DOWNTIME_SV AS
SELECT TRACK_ID
      ,SYS_ID
      ,D_DATE_ID
      ,CASE WHEN SCHEDULED = 'N' then 'No'
      WHEN SCHEDULED = 'Y' then 'Yes'
        ELSE 'No'
          END as SCHEDULED
      ,TICKET_ID
      ,ACTUAL_DOWNTIME_IN_MINS
      ,COMMENTS
      ,D_PROJECT_ID            
      ,D_PROGRAM_ID
      ,CASE WHEN ignore_flag = 'N' then 'No'
      WHEN ignore_flag = 'Y' then 'Yes'
        ELSE 'No'
          END as ignore_flag            
      ,create_by               
      ,create_datetime         
      ,last_updated_by         
      ,last_updated_datetime
 FROM MAXDAT.TS_CAHCO_TRACK_DOWNTIME;

commit;

/ 
