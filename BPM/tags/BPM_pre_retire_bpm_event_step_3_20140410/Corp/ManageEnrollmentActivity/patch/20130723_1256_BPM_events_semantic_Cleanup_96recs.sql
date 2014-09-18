insert into BPM_UPDATE_EVENT_QUEUE
select 
BUEQ_ID,
BSL_ID,                  
BIL_ID,                              
EVENT_DATE,              
QUEUE_DATE,              
PROCESS_BUEQ_ID,         
BUE_ID,                  
WROTE_BPM_EVENT_DATE,    
WROTE_BPM_SEMANTIC_DATE, 
DATA_VERSION,            
OLD_DATA,                
NEW_DATA,        
IDENTIFIER 
from BPM_UPDATE_EVENT_QUEUE_ARCHIVE a
where identifier in (select client_enroll_status_id 
                       from corp_etl_manage_enroll 
                       where third_followup_id is not null);
commit;

                       
update BPM_UPDATE_EVENT_QUEUE
  set 
      bue_id = null,
      process_bueq_id = null,
      wrote_bpm_event_date = null,
      wrote_bpm_semantic_date = null
 where bsl_id = 14;
 commit;


delete  from BPM_UPDATE_EVENT_QUEUE_ARCHIVE a
where identifier in (select client_enroll_status_id 
                       from corp_etl_manage_enroll 
                       where third_followup_id is not null);
commit;
---------------------------------------------------------------------

delete from F_ME_BY_DATE
  where me_bi_id in (select me_bi_id from d_me_current
                    where client_enroll_status_id in (
                                      select client_enroll_status_id 
                                      from corp_etl_manage_enroll
                                      where third_followup_id is not null
                                      )
                      );
commit;

delete from d_me_current
where client_enroll_status_id in (
        select client_enroll_status_id 
        from corp_etl_manage_enroll
        where third_followup_id is not null
        );
commit;                      
---------------------------------------------------------------------
delete from bpm_instance_attribute
  where bi_id in (select bi_id 
                    from bpm_instance
                    where identifier in ( select client_enroll_status_id 
                                          from corp_etl_manage_enroll
                                          where third_followup_id is not null
                                          )  
                  );
commit;


delete from BPM_UPDATE_EVENT
 where bi_id in (select bi_id 
                    from bpm_instance
                    where identifier in ( select client_enroll_status_id 
                                          from corp_etl_manage_enroll
                                          where third_followup_id is not null
                                          )
                  );
commit;


delete from bpm_instance
  where identifier in ( select client_enroll_status_id 
                        from corp_etl_manage_enroll
                        where third_followup_id is not null
                        );
commit;           