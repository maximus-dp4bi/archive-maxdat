CREATE OR REPLACE Procedure MAXDAT.TS_TIMELINESS_EXCEPTION_INSERT
   ( in_rids_id in varchar2
   , in_app_id in number
   , in_exception_type_id in number
   , in_exclusion_flag in varchar2
   , in_callback_date in date
   , in_new_cycle_start_date in date
   , in_new_cycle_end_date in date
   , in_hcfa_reactivation_flag in varchar2
   , in_comments in varchar2
   , in_NATIONAL_ID  in varchar2 )

AS
   
BEGIN

if in_rids_id is null or in_app_id is null or in_exception_type_id is null then
    --do nothing
      null;
else      
    insert into maxdat.ts_timeliness_exception
      (timeliness_exception_id,
       rids_id,
       app_id,
       exception_type_id,
       exclusion_flag,
       hcfa_reactivation_flag,
       callback_date,
       new_cycle_start_date,
       new_cycle_end_date,
       ignore_flag,
       comments,
       create_by,
       create_datetime,
       last_updated_by,
       last_updated_datetime
       )
    values
      (SEQ_timeliness_exception_ID.nextval,
       in_rids_id,
       in_app_id,
       in_exception_type_id,
       CASE
          WHEN in_exclusion_flag='Y' THEN 'Y'  
          ELSE 'N'
       END,
       CASE
          WHEN in_hcfa_reactivation_flag='Y' THEN 'Y'
          ELSE 'N'
       END,
       in_callback_date,
       in_new_cycle_start_date,
       in_new_cycle_end_date,
       'N',
       in_comments,
       in_NATIONAL_ID,
       sysdate,
       in_NATIONAL_ID,
       sysdate
       );
    commit;

end if;
   
END;

/

CREATE OR REPLACE Procedure MAXDAT.TS_TIMELINESS_EXCEPTION_UPDATE
   ( in_timeliness_exception_id in number
   , in_ignore_flag in varchar2
   , in_NATIONAL_ID  in varchar2)

AS
   
BEGIN


   if in_ignore_flag = 'Y' then
     update maxdat.ts_timeliness_exception
        set
            ignore_flag = in_ignore_flag,
            last_updated_by = in_NATIONAL_ID,
            last_updated_datetime = sysdate
      where timeliness_exception_id = in_timeliness_exception_id;
      commit;
   else
      --do nothing
      null;
   end if;

END;


/
