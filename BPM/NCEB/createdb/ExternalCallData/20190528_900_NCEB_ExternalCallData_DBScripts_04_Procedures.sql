--Procedures
CREATE OR REPLACE Procedure MAXDAT.TS_NCEB_EXT_CALL_DATA_INSERT
   ( in_blocked_calls     IN NUMBER
   , in_D_DATE            IN DATE
   , in_NATIONAL_ID       IN NUMBER )

AS

   --v_EXT_CALL_ID number;
   
 --  cursor c1 is
 --  select EXT_CALL_ID
 --  from MAXDAT.TS_NCEB_EXT_CALL_DATA
 --  where d_date_id=(select d_date_id
 --           from cisco_enterprise_cc.cc_d_dates_sv
 --          where d_date = trunc(in_D_DATE));   

BEGIN

 --  open c1;
 --  fetch c1 into v_EXT_CALL_ID;
   
   if   in_D_DATE is null  or in_NATIONAL_ID is null or trunc(in_D_DATE) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
        insert into MAXDAT.TS_NCEB_EXT_CALL_DATA
          (EXT_CALL_ID,
           blocked_calls,
           d_date_id,
           d_project_id,
           d_program_id,
           create_by,
           create_datetime,
           last_updated_by,
           LAST_UPDATED_DATETIME)
        values
          (SEQ_NCEB_EXT_CALL_DATA_ID.Nextval,
           in_blocked_calls,
           (select d_date_id
              from cisco_enterprise_cc.cc_d_dates_sv
             where d_date = trunc(in_d_date)),
           /*(select project_id
              from cisco_enterprise_cc.cc_d_project_sv
             where project_name = 'NCEB')*/
           'NCEB',
           /*(select program_id
              from cisco_enterprise_cc.cc_d_program_sv
             where program_name = 'Medicaid')*/
           'Medicaid',
           in_NATIONAL_ID,
           SYSDATE,
           in_NATIONAL_ID,
           sysdate);

           commit;
   end if;
   
 --  close c1;

END;

/

CREATE OR REPLACE Procedure MAXDAT.TS_NCEB_EXT_CALL_DATA_UPDATE
   ( in_ext_call_id       IN NUMBER
   , in_blocked_calls     IN NUMBER
   , in_D_DATE            IN DATE
   , in_NATIONAL_ID       IN NUMBER )

AS
   
 --  v_EXT_CALL_ID number;
   
 --  cursor c1 is
 --   select EXT_CALL_ID
 --  from MAXDAT.TS_NCEB_EXT_CALL_DATA
 --  where d_date_id=(select d_date_id
 --           from cisco_enterprise_cc.cc_d_dates_sv
 --         where d_date = trunc(in_D_DATE))
 --          and EXT_CALL_ID<>in_ext_call_id;

BEGIN
   
 --  open c1;
 --  fetch c1 into v_EXT_CALL_ID;   
   
   if  (in_D_DATE is NULL and Length(in_blocked_calls) is NULL ) then
         /*do nothing*/
          null;
   else           
       update MAXDAT.TS_NCEB_EXT_CALL_DATA
          set blocked_calls = case
                                --when (length(in_blocked_calls) > 0) then
                                when (in_blocked_calls IS NOT NULL) then
                                     in_blocked_calls
                                else
                                     blocked_calls
                              end,
              
              d_date_id = case
                               --when (length(in_unique_calls) > 0) then
                               when (in_D_DATE IS NOT NULL) then  
                                    (select d_date_id
                                      from cisco_enterprise_cc.cc_d_dates_sv
                                     where d_date = trunc(in_D_DATE))
                               else
                                    d_date_id
                             end,               
              last_updated_by = in_NATIONAL_ID,
              LAST_UPDATED_DATETIME = sysdate
        where EXT_CALL_ID = in_ext_call_id;

       commit;
           
   end if;

--   close c1;


END;

/
