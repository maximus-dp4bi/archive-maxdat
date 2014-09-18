ALTER TABLE nyhbe_etl_process_appeals
ADD ("RECEIVED_DT" DATE
    ,"CURRENT_STEP" VARCHAR2(256));

ALTER TABLE nyhbe_process_appeals_wip_bpm
ADD ("RECEIVED_DT" DATE
    ,"CURRENT_STEP" VARCHAR2(256));
    
ALTER TABLE nyhbe_process_appeals_oltp
ADD ("RECEIVED_DT" DATE
    ,"CURRENT_STEP" VARCHAR2(256));

ALTER TABLE d_appeals_current
ADD(CURRENT_STEP VARCHAR2(256),
   RECEIVED_DATE DATE);
        
create or replace view D_APPEALS_CURRENT_SV as
select * from D_APPEALS_CURRENT
with read only;

create or replace public synonym D_APPEALS_CURRENT_SV for D_APPEALS_CURRENT_SV;
