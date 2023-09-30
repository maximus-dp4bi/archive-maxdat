--Procedures
CREATE OR REPLACE Procedure TS_CAHCO_TRACK_DOWNTIME_INSERT
   ( in_sys_id                  IN NUMBER
   , in_d_date                  IN DATE
   , in_scheduled               IN VARCHAR2
   , in_ticket_id               IN NUMBER
   , in_actual_downtime_in_mins IN NUMBER
   , in_comments                IN VARCHAR2
   , in_NATIONAL_ID             IN NUMBER )

AS
 --v_date_id number;
BEGIN
  
   if in_sys_id is null or in_d_date is null or in_scheduled is null or in_actual_downtime_in_mins is null
     or in_NATIONAL_ID is null  then
     /*do nothing*/
      null;
   else   
           
      insert into ts_cahco_track_downtime
        (track_id,
         sys_id,
         d_date_id,
         scheduled,
         ticket_id,
         actual_downtime_in_mins,
         comments,
         d_project_id,
         d_program_id,
         create_by,
         create_datetime,
         last_updated_by,
         last_updated_datetime,
         ignore_flag)
      values
        (seq_cahco_trackdowntime_id.Nextval,
         in_sys_id,
         (select d_date_id
            from cisco_enterprise_cc.cc_d_dates_sv
           where d_date = trunc(in_d_date)),
         CASE WHEN in_scheduled=1 THEN 'Y'
           ELSE 'N'
         END,
         in_ticket_id,
         in_actual_downtime_in_mins,
         in_comments,
         (select project_id
            from cisco_enterprise_cc.cc_d_project_sv
           where project_name = 'CA HCO'),
         (select program_id
            from cisco_enterprise_cc.cc_d_program_sv
           where program_name = 'Medi-Cal'),
         in_NATIONAL_ID,
         sysdate,
         in_NATIONAL_ID,
         sysdate,
         'N');
  
       commit;
  
   end if;

END;

/

CREATE OR REPLACE Procedure TS_CAHCO_TRACK_DOWNTIME_UPDATE
   ( in_track_id                IN NUMBER
   , in_sys_id                  IN NUMBER
   , in_d_date                  IN DATE
   , in_scheduled               IN VARCHAR2
   , in_ticket_id               IN NUMBER
   , in_actual_downtime_in_mins IN NUMBER
   , in_comments                IN VARCHAR2
   , in_ignore_flag             IN VARCHAR2
   , in_NATIONAL_ID             IN NUMBER )

AS

BEGIN 
   
   if  (in_D_DATE is NULL and in_track_id is NULL and in_sys_id is NULL and in_scheduled is NULL and in_ticket_id is NULL
     and Length(in_actual_downtime_in_mins) is NULL and in_comments is NULL and in_ignore_flag IS NULL) then
         /*do nothing*/
          null;
   elsif in_track_id is NULL then
         /*do nothing*/
          null;     
   else  
     
       update ts_cahco_track_downtime
          set sys_id = case when (in_sys_id IS NOT NULL) then in_sys_id else sys_id end,
              d_date_id = case when (in_d_date IS NOT NULL) then  
                                    (select d_date_id from cisco_enterprise_cc.cc_d_dates_sv where d_date = trunc(in_d_date))
                               else d_date_id end,
              scheduled = case when (in_scheduled IS NOT NULL) then 
              case 
                when in_scheduled='Yes' then 'Y' 
                else 'N'
              end   
              else scheduled  
              end,
              ticket_id = case when (in_ticket_id IS NOT NULL) then in_ticket_id else ticket_id end,
              actual_downtime_in_mins = case when (in_actual_downtime_in_mins IS NOT NULL) then in_actual_downtime_in_mins else actual_downtime_in_mins end,
              comments = case when (in_comments IS NOT NULL) then in_comments else comments end,
              --comments='in_sys_id=' || in_sys_id || ' in_d_date=' || in_d_date ||  ' in_scheduled=' || in_scheduled || ' in_ticket_id=' || in_ticket_id || ' in_actual_downtime_in_mins=' || in_actual_downtime_in_mins || ' in_ignore_flag=' || in_ignore_flag,
              ignore_flag = case when (in_ignore_flag IS NOT NULL) then 
                       case  
                         when in_ignore_flag='Yes' then 'Y'
                         else 'N' 
                       end 
                   else ignore_flag 
              end,
              last_updated_by = in_NATIONAL_ID,
              last_updated_datetime = SYSDATE
        where track_id=in_track_id;

       commit;
           
   end if;

END;

/
