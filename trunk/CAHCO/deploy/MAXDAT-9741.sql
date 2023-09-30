alter session set current_schema=maxdat;

--alter table step_instance disable all triggers;

declare

    type t_task_instance_tbl is table of d_mw_task_instance%rowtype;
    
    l_task_instance_tbl                 t_task_instance_tbl;
    l_step_instance_rec                 step_instance%rowtype;

    l_claimed_date                      date;

    l_script_name                       varchar2(200)                   default 'maxdat-9741.sql';

begin

    delete
      from  cahco_etl_mw_log
     where  context             =   l_script_name;
     
     commit;

    cahco_etl_mw_util_pkg.log_message(l_script_name, 'Started script');

    cahco_etl_mw_util_pkg.log_message(l_script_name, 'Building PL/SQL table of affected task instances...');

    select  ti.*
            bulk collect into
            l_task_instance_tbl
      from  d_mw_task_instance              ti,
            step_instance                   si
     where  ti.task_id                  =   si.step_instance_id
       and  ti.curr_claim_date is null 
       and  ti.complete_date is not null 
       and  si.owner is not null
       and  rownum < 20;

    cahco_etl_mw_util_pkg.log_message(l_script_name, 'Found ' || l_task_instance_tbl.count || ' affected task instances...');

    for i in 1..l_task_instance_tbl.count
    loop

        select  *
          into  l_step_instance_rec
          from  step_instance
         where  step_instance_id        =   l_task_instance_tbl(i).task_id;  

        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Determining claimed date...');

        if
        (
            l_task_instance_tbl(i).task_type_id in (1)
        )
        then

            begin
                select  max(hbs.perform_scan_start)
                  into  l_claimed_date
                  from  hco_batch_dcn               hbd,
                        hco_batch_stats             hbs
                 where  hbd.dcn                 =   l_task_instance_tbl(i).dcn
                   and  hbd.batch_guid          =   hbs.batch_guid;    

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;    
        elsif
        (
            l_task_instance_tbl(i).task_type_id in (2)
        )
        then

            begin
                select  max(hbs.perform_scan_end)
                  into  l_claimed_date
                  from  hco_batch_dcn               hbd,
                        hco_batch_stats             hbs
                 where  hbd.dcn                 =   l_task_instance_tbl(i).dcn
                   and  hbd.batch_guid          =   hbs.batch_guid;    

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (3)
        )
        then

            begin
                select  max(e.record_date)
                  into  l_claimed_date
                  from  emrs_f_enrollment           e
                 where  e.enrollment_id         =   l_task_instance_tbl(i).source_reference_id
                   and  e.date_of_validity_start <= SYSDATE
                   and  e.date_of_validity_end >= SYSDATE;

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;
        
        elsif
        (
            l_task_instance_tbl(i).task_type_id in (5)
        )
        then

            BEGIN
                SELECT  dte.record_date
                  INTO  l_claimed_date
                  FROM  daily_transaction_enrollment    dte
                 WHERE  dte.enrollment_id               =   l_task_instance_tbl(I).source_reference_id
                   AND  dte.enrollment_record_id        =   (
                                                                SELECT  MAX(enrollment_record_id)
                                                                  FROM  daily_transaction_enrollment        dte1
                                                                 WHERE  dte1.enrollment_id              =   l_task_instance_tbl(i).source_reference_id
                                                            );
            EXCEPTION
            
                WHEN    no_data_found
                THEN    l_claimed_date := NULL;
            END;                                                            

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (7)
        )
        then

            begin
                select  max(hbs.release_to_dms_end)
                  into  l_claimed_date
                  from  hco_batch_dcn               hbd,
                        hco_batch_stats             hbs
                 where  hbd.dcn                 =   l_task_instance_tbl(i).dcn
                   and  hbd.batch_guid          =   hbs.batch_guid;    

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (12)
        )
        then

            begin
                select  max(hbs.release_to_dms_start)
                  into  l_claimed_date
                  from  hco_batch_dcn               hbd,
                        hco_batch_stats             hbs
                 where  hbd.dcn                 =   l_task_instance_tbl(i).dcn
                   and  hbd.batch_guid          =   hbs.batch_guid;    

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (8, 17, 19)
        )
        then

            begin

                select  e.record_date
                  into  l_claimed_date
                  from  emrs_d_emrgcy_disenroll             e
                 where  e.emrgcy_disenroll_id           =   l_task_instance_tbl(i).source_reference_id;

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (9, 18, 24)
        )
        then

            begin

                select  e.record_date
                  into  l_claimed_date
                  from  emrs_d_exemption_req                e
                 where  e.exemption_id                  =   l_task_instance_tbl(i).source_reference_id;

            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;

        elsif
        (
            l_task_instance_tbl(i).task_type_id in (14)
        )
        then

            begin

                select  max(hbs.release_to_dms_end)
                  into  l_claimed_date
                  from  hco_batch_dcn               hbd,
                        hco_batch_stats             hbs
                 where  hbd.dcn                 =   l_task_instance_tbl(i).dcn
                   and  hbd.batch_guid          =   hbs.batch_guid;    
                   
            exception
                
                when    no_data_found
                then    l_claimed_date :=   null;
                        
            end;
            
        end if;

        if
        (
                l_claimed_date is null
        )
        then
            cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Could not resolve a value for claimed date...using complete date ' || to_char(l_task_instance_tbl(i).complete_date, 'mm/dd/yyyy hh24:mi:ss') || ' as claimed date.');
            l_claimed_date  :=  l_task_instance_tbl(i).complete_date;
        elsif
        (
            l_claimed_date > l_task_instance_tbl(i).complete_date        
        )
        then
            cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Resolved claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss') || ' with complete date ' || to_char(l_task_instance_tbl(i).complete_date, 'mm/dd/yyyy hh24:mi:ss') || '.  Using complete date as claimed date.');
            l_claimed_date  :=  l_task_instance_tbl(i).complete_date;            
        end if;

        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Resolved claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss') || ' with complete date ' || to_char(l_task_instance_tbl(i).complete_date, 'mm/dd/yyyy hh24:mi:ss'));

        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Updating step_instance with claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss'));
        
        update  step_instance
           set  claimed_ts              =   l_claimed_date
         where  step_instance_id        =   l_task_instance_tbl(i).task_id; 
    
        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Inserting record into step_instance_history with claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss'));
    
        insert
          into  step_instance_history       (   step_instance_history_id,               step_instance_id,                           status,             owner,                                                                                             escalated_ind,                                              escalate_to,                                forwarded_ind,                              forwarded_by,                           group_id,                           team_id,                            create_ts,          created_by                          )
        values                              (   -seq_step_instance_history_id.nextval,  l_step_instance_rec.step_instance_id,       'CLAIMED',          cahco_etl_mw_util_pkg.format_staff_string(l_step_instance_rec.created_by),                         l_step_instance_rec.escalated_ind,                          l_step_instance_rec.escalate_to,            l_step_instance_rec.forwarded_ind,          l_step_instance_rec.forwarded_by,       l_step_instance_rec.group_id,       l_step_instance_rec.team_id,        l_claimed_date,     cahco_etl_mw_util_pkg.format_staff_string(l_step_instance_rec.created_by));
    
        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Updating step_instance_stg with claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss'));
    
        update  step_instance_stg
           set  claimed_ts              =   l_claimed_date
         where  step_instance_id        =   l_task_instance_tbl(i).task_id; 
    
        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Updating corp_etl_mw_wip with claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss'));
    
        update  corp_etl_mw_wip
           set  claim_date              =   l_claimed_date
         where  task_id                 =   l_task_instance_tbl(i).task_id; 
    
        cahco_etl_mw_util_pkg.log_message(l_script_name, 'task_id=' || l_task_instance_tbl(i).task_id || ' ( ' || i || ' of ' || l_task_instance_tbl.count || ' ):  Updating corp_etl_mw with claimed date ' || to_char(l_claimed_date, 'mm/dd/yyyy hh24:mi:ss'));
    
        update  corp_etl_mw
           set  claim_date              =   l_claimed_date
         where  task_id                 =   l_task_instance_tbl(i).task_id; 
    
    end loop;

    cahco_etl_mw_util_pkg.log_message(l_script_name, 'Completed script');
            
end;
/

--alter table step_instance enable all triggers;


--select * from cahco_etl_mw_log where context = 'maxdat-9741.sql' order by cahco_etl_mw_log_id;
--select * from all_triggers where status = 'DISABLED';
