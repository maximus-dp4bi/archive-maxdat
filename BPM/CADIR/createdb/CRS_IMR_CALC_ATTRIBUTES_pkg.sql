alter session set plsql_code_type = native;

create or replace package CRS_IMR_CALC_ATTRIBUTES as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
  
procedure IMR_DUPLICATE_DATE ;

procedure IMR_INELIGIBLE_DATE ;

procedure IMR_CLOSED_DATE ;

procedure IMR_INELIGIBLE_TYPE ;

procedure IMR_CURRENT_QUEUE_ROLE ;

procedure IMR_ASSIGNEE_NAME ;

procedure IMR_CLINICAL_CONSULTANT_DATE;
  
end;
/  

create or replace package body CRS_IMR_CALC_ATTRIBUTES as

-- Initialize global variables

g_err_date date := sysdate;	
g_err_level varchar2(10) := 'Critical';	
g_create_ts date := sysdate;		
g_update_ts date := sysdate;
g_process_name varchar2(15) := 'CRS_IMR';
g_driver_table_name varchar2(50):= 'S_CRS_IMR';

-- Calculate IMR_DUPLICATE_DATE
  procedure IMR_DUPLICATE_DATE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_DUPLICATE_DATE_proc';
   
   cursor upd1_duplicate_date
   is
    with driver as
    (
    select id, assignment_date as imr_duplicate_date, c_case_number
    from
      cadir_maxdat_stg s  
    , cadir_user_stg u
    , cadir_person_stg p
    , s_crs_imr i
    where s.subject_id = u.user_id
    and u.person_id = p.person_id
    and s.c_case_number = i.case_number
    and (i.updated = 'Y' or i.imr_closed_date is null)
    and p.last_name = 'Duplicate' and s.subject_type=1
    ),
    driver2 as
    (
    select min(id)as MIN_ID from driver 
    group by c_case_number
    )
    select * from driver d, driver2 d2
    where d.id = d2.MIN_ID;
    
      cursor upd2_duplicate_date
       is
        with driver as
	(
	select id, assignment_date as imr_duplicate_date, c_case_number
	from
	  cadir_maxdat_stg s  
	, cadir_role_stg r
	, d_crs_closed_reasons d
	, s_crs_imr i
	where s.c_case_number = i.case_number
	and s.role_id = r.role_id
	and i.closed_reason_id = d.closed_reason_id
	and d.closed_reason_name = 'Duplicate'
	and r.name = 'Closed Cases Queue'
	and i.imr_duplicate_dt_flg = 'N'
	and (i.updated = 'Y' or i.imr_closed_date is null)
	),
	driver2 as
	(
	select min(id)as MIN_ID from driver 
	group by c_case_number
	)
	select * from driver d, driver2 d2
        where d.id=d2.MIN_ID;

  begin
  
     for i in upd1_duplicate_date
     loop
    
     
       if (i.imr_duplicate_date is not null)
            then
            begin
            update s_crs_imr
            set imr_duplicate_date = i.imr_duplicate_date,
            imr_duplicate_dt_flg='Y'
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;


      for j in upd2_duplicate_date
         loop
      
           if (j.imr_duplicate_date is not null)
                then
                begin
                
                update s_crs_imr
                set imr_duplicate_date = j.imr_duplicate_date,
                imr_duplicate_dt_flg='Y'
                where case_number = j.c_case_number;
                
                commit;
                
                 exception
			    	       
			    	     when others then
			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, j.c_case_number );
            

                end;
			    	     
             
         
           end if;
            
     end loop;

  end;



-- Calculate IMR_INELIGIBLE_DATE
  procedure IMR_INELIGIBLE_DATE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_INELIGIBLE_DATE_proc';
   
   cursor upd1_ineligible_date
          is
           with driver as
           (
           select id, c_case_number, assignment_date as imr_ineligible_date
           from
             cadir_maxdat_stg s  
           , cadir_role_stg r
           , s_crs_imr i
           where s.role_id = r.role_id
           and s.c_case_number = i.case_number
           and r.name = 'Notice of Ineligibility Queue'
           and (i.updated = 'Y' or i.imr_closed_date is null)
           ),
           driver2 as
           (
           select min(id)as MIN_ID from driver 
           group by c_case_number
           )
           select * from driver d, driver2 d2
        where d.id=d2.MIN_ID;
   
   cursor upd2_ineligible_date
   is
     with driver as
     (
     select id, assignment_date as imr_ineligible_date , c_case_number
     from
       cadir_maxdat_stg s  
     , cadir_user_stg u
     , cadir_person_stg p
     , s_crs_imr i
     where s.subject_id = u.user_id
     and u.person_id = p.person_id
     and s.c_case_number=i.case_number
     and p.last_name in ('CNC','Untimely','No Signature','No UR','No Signature '||'&'||' No UR')
     and i.imr_ineligible_dt_flg = 'N'
     and (i.updated='Y' or i.imr_closed_date is null)
     ),  
     driver2 as  
     (  
     select min(id)as MIN_ID from driver   
     group by c_case_number  
     )  
     select * from driver d, driver2 d2  
     where d.id=d2.MIN_ID ;
    
   cursor upd3_ineligible_date
       is
        with driver as
        (
        select id, c_case_number, assignment_date as imr_ineligible_date
        from
          cadir_maxdat_stg s  
        , cadir_role_stg r
        , s_crs_imr i
        where s.role_id = r.role_id
        and s.c_case_number = i.case_number
        and r.name = 'Pending DWC Ineligibility Letter Queue'
        and i.imr_ineligible_dt_flg = 'N'
        and (i.updated = 'Y' or i.imr_closed_date is null)
        ),
        driver2 as
        (
        select min(id)as MIN_ID from driver 
        group by c_case_number
        )
        select * from driver d, driver2 d2
        where d.id=d2.MIN_ID;
        
   cursor upd4_ineligible_date
       is
        with driver as
        (
        select id, assignment_date as imr_ineligible_date, c_case_number
        from
          cadir_maxdat_stg s  
        , cadir_role_stg r
        , d_crs_closed_reasons d
        , s_crs_imr i
        where s.c_case_number = i.case_number
        and s.role_id = r.role_id
        and i.closed_reason_id = d.closed_reason_id
        and d.closed_reason_name = 'Ineligible'
        and r.name = 'Closed Cases Queue'
        and i.imr_ineligible_dt_flg='N'
        and (i.updated = 'Y' or i.imr_closed_date is null)
        ),
        driver2 as
        (
        select min(id)as MIN_ID from driver
        group by c_case_number
        )
        select * from driver d, driver2 d2
        where d.id=d2.MIN_ID;
        
  begin
  
     for i in upd1_ineligible_date
     loop
    
     
       if (i.imr_ineligible_date is not null)
            then
            begin
            update s_crs_imr
            set imr_ineligible_date = i.imr_ineligible_date,
            imr_ineligible_dt_flg='Y'
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;


      for j in upd2_ineligible_date
         loop
      
           if (j.imr_ineligible_date is not null)
                then
                begin
                
                update s_crs_imr
                set imr_ineligible_date = j.imr_ineligible_date,
                imr_ineligible_dt_flg='Y'
                where case_number = j.c_case_number;
                
                commit;
                
                 exception
			    	       
			    	     when others then
			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, j.c_case_number );
            

                end;
			    	     
             
         
           end if;
            
     end loop;
     
     
     for k in upd3_ineligible_date
              loop
           
                if (k.imr_ineligible_date is not null)
                     then
                     begin
                     
                     update s_crs_imr
                     set imr_ineligible_date = k.imr_ineligible_date,
                     imr_ineligible_dt_flg='Y'
                     where case_number = k.c_case_number;
                     
                     commit;
                     
                      exception
     			    	       
     			    	     when others then
     			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
     			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, k.c_case_number );
                 
     
                     end;
     			    	     
                  
              
                end if;
                 
     end loop;

     for l in upd4_ineligible_date
              loop
           
                if (l.imr_ineligible_date is not null)
                     then
                     begin
                     
                     update s_crs_imr
                     set imr_ineligible_date = l.imr_ineligible_date,
                     imr_ineligible_dt_flg='Y'
                     where case_number = l.c_case_number;
                     
                     commit;
                     
                      exception
     			    	       
     			    	     when others then
     			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
     			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, l.c_case_number );
                 
     
                     end;
     			    	     
                  
              
                end if;
                 
     end loop;
  end;


-- Calculate IMR_CLOSED_DATE
  procedure IMR_CLOSED_DATE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_CLOSED_DATE_proc';
   
   cursor upd1_closed_date
   is
     
     with driver as
     (
     select id, assignment_date as imr_closed_date, c_case_number
     from
       cadir_maxdat_stg s  
     , cadir_role_stg r
     , s_crs_imr i
     where s.role_id = r.role_id
     and s.c_case_number = i.case_number
     and r.name = 'Closed Cases Queue'
     and (i.updated = 'Y' or i.imr_closed_date is null)
     ),
     driver2 as
     (
     select min(id)as MIN_ID from driver 
     group by c_case_number
     )
     select * from driver d, driver2 d2
     where d.id=d2.MIN_ID;
     
begin
  
     for i in upd1_closed_date
     loop
    
     
       if (i.imr_closed_date is not null)
            then
            begin
            update s_crs_imr
            set imr_closed_date = i.imr_closed_date,
            imr_closed_dt_flg = 'Y'  			--Adding this for updating all closed records from source, CADIR-851
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;
 
 end;


-- Calculate IMR_INELIGIBLE_TYPE
  procedure IMR_INELIGIBLE_TYPE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_INELIGIBLE_TYPE_proc';
  
     cursor upd1_ineligible_type
     is
       select i.case_number as c_case_number, 
	(case dil.ineligible_letter_name when 'Conditionally Non-Certified'  then 'CNC'
       					 when 'No UR - No Signature' then 'No Signature ' || '&' || ' No UR'
       					 else dil.ineligible_letter_name 
	end) as imr_ineligible_type
	from 
		s_crs_imr i
		, s_crs_imr_preliminary_review ipr
		, d_crs_ineligibility_letter dil
	where i.imr_id = ipr.imr_id
	      and ipr.ineligible_letter_id = dil.ineligible_letter_id
	      and (i.updated = 'Y' or i.imr_closed_date is null); 
   
   cursor upd2_ineligible_type
   is
     with driver as
     (
     select id, p.last_name as imr_ineligible_type, c_case_number
     from
       cadir_maxdat_stg s  
     , cadir_user_stg u
     , cadir_person_stg p
     , s_crs_imr i
     where s.subject_id = u.user_id
     and u.person_id = p.person_id
     and s.c_case_number = i.case_number
     and p.last_name in ('CNC','Untimely','No Signature','No UR','No Signature '||'&'||' No UR')
     and i.imr_ineligible_type_flg = 'N' 
     and (i.updated = 'Y' or i.imr_closed_date is null)
     ),
     driver2 as
     (
     select min(id)as MIN_ID from driver 
     group by c_case_number
     )
     select * from driver d, driver2 d2
     where d.id=d2.MIN_ID;
     
     
  cursor upd3_ineligible_type
       is
       with driver as 
       ( 
       select id, c_case_number, 'Pending DWC Ineligibility Letter Queue' as imr_ineligible_type 
       from 
         cadir_maxdat_stg s   
       , cadir_role_stg r 
       , s_crs_imr i 
       where s.role_id = r.role_id 
       and s.c_case_number = i.case_number 
       and upper(r.name) = 'PENDING DWC INELIGIBILITY LETTER QUEUE' 
       and i.imr_ineligible_type_flg = 'N' 
       and (i.updated = 'Y' or i.imr_closed_date is null)
       ), 
       driver2 as 
       ( 
       select min(id)as MIN_ID from driver  
       group by c_case_number 
       ) 
       select * from driver d, driver2 d2 
       where d.id=d2.MIN_ID;
        
        
   cursor upd4_ineligible_type
       is
       with driver as 
       (select id, 'Ineligible' as imr_ineligible_type, c_case_number 
       from 
        s_crs_imr i 
       , d_crs_closed_reasons d 
       , cadir_maxdat_stg s 
       where i.closed_reason_id = d.closed_reason_id 
       and i.case_number = s.c_case_number 
       and upper(d.closed_reason_name) = 'INELIGIBLE' 
       and i.imr_ineligible_type_flg = 'N' 
       and (i.updated = 'Y' or i.imr_closed_date is null)
       ), 
       driver2 as 
       ( 
       select min(id) as MIN_ID from driver  
       group by c_case_number 
       ) 
       select d.* from driver d, driver2 d2 
       where d.id=d2.MIN_ID;
        
  begin
  
  for l in upd1_ineligible_type
       loop
        
         if (l.imr_ineligible_type is not null)
              then
              begin
              update s_crs_imr
              set imr_ineligible_type = l.imr_ineligible_type,
              imr_ineligible_type_flg='Y'
              where case_number = l.c_case_number;
              
              commit;
              
              exception
  	    	       
  	    	     when others then
  	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
  	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, l.c_case_number );
              
              end;
              
  	 end if;
          
     end loop;
  
     for i in upd2_ineligible_type
     loop
    
     
       if (i.imr_ineligible_type is not null)
            then
            begin
            update s_crs_imr
            set imr_ineligible_type = i.imr_ineligible_type,
            imr_ineligible_type_flg='Y'
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;


      for j in upd3_ineligible_type
         loop
      
           if (j.imr_ineligible_type is not null)
                then
                begin
                
                update s_crs_imr
                set imr_ineligible_type = j.imr_ineligible_type,
                imr_ineligible_type_flg='Y'
                where case_number = j.c_case_number;
                
                commit;
                
                 exception
			    	       
			    	     when others then
			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, j.c_case_number );
            

                end;
			    	     
             
         
           end if;
            
     end loop;
     
     
     for k in upd4_ineligible_type
              loop
           
                if (k.imr_ineligible_type is not null)
                     then
                     begin
                     
                     update s_crs_imr
                     set imr_ineligible_type = k.imr_ineligible_type,
                     imr_ineligible_type_flg='Y'
                     where case_number = k.c_case_number;
                     
                     commit;
                     
                      exception
     			    	       
     			    	     when others then
     			    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
     			           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, k.c_case_number );
                 
     
                     end;
     			    	     
                  
              
                end if;
                 
     end loop;

  end;


-- Calculate IMR_CURRENT_QUEUE_ROLE
  procedure IMR_CURRENT_QUEUE_ROLE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_CURRENT_QUEUE_ROLE_proc';
   
   cursor upd1_role_name
   is
     select cms.c_case_number, crs.name as role_name 
     from cadir_maxdat_stg cms
     join 
     (
     	select c_case_number, max(id) maxassignid
     	from cadir_maxdat_stg
     	where 
     	is_current  = 1
         group by c_case_number
     ) mx on cms.id = mx.maxassignid
     join cadir_role_stg crs on cms.role_id = crs.role_id
     join s_crs_imr ci on cms.c_case_number = ci.case_number and (ci.updated = 'Y' or ci.imr_closed_date is null);
     
 begin
  
     for i in upd1_role_name
     loop
    
     
       if (i.role_name is not null)
            then
            begin
            update s_crs_imr
            set imr_current_queue_role = i.role_name
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;
 
 end;


-- Calculate IMR_ASSIGNEE_NAME
  procedure IMR_ASSIGNEE_NAME
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_ASSIGNEE_NAME_proc';
   
   cursor upd1_assignee_name
   is
     select cms.c_case_number, cps.last_name || ', ' ||  cps.first_name || ' ' || cps.middle_name as imr_assignee_name 
     from cadir_maxdat_stg cms
     join 
     (
     	select c_case_number, max(id) maxassignid
     	from cadir_maxdat_stg
     	where 
     	is_current  = 1
         group by c_case_number
     ) mx on cms.id = mx.maxassignid
     join cadir_user_stg cus on cms.subject_id=cus.user_id and cms.subject_type = 1
     join cadir_person_stg cps on cps.person_id = cus.person_id
     join s_crs_imr ci on cms.c_case_number = ci.case_number and (ci.updated = 'Y' or ci.imr_closed_date is null);
     
  begin
  
     for i in upd1_assignee_name
     loop
    
     
       if (i.imr_assignee_name is not null)
            then
            begin
            update s_crs_imr
            set imr_assignee_name = i.imr_assignee_name
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;
 
 end;

-- Calculate CLINICAL_CONSULTANT_DATE
  procedure IMR_CLINICAL_CONSULTANT_DATE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'IMR_CLINICAL_CONSULTANT_DATE_proc';
   
   cursor upd1_clinical_consultant_date
   is
     
     with driver as
     (
     select id, assignment_date as imr_cc_date, c_case_number
     from
       cadir_maxdat_stg s  
     , cadir_role_stg r
     , s_crs_imr i
     where s.role_id = r.role_id
     and s.c_case_number = i.case_number
     and r.name = 'Clinical Consultant Queue'
     and (i.updated = 'Y' or i.imr_closed_date is null)
     ),
     driver2 as
     (
     select max(id)as MAX_ID from driver 
     group by c_case_number
     )
     select * from driver d, driver2 d2
     where d.id=d2.MAX_ID;
     
begin
  
     for i in upd1_clinical_consultant_date
     loop
    
     
       if (i.imr_cc_date is not null)
            then
            begin
            update s_crs_imr
            set imr_cc_date = i.imr_cc_date
            where case_number = i.c_case_number;
            
            commit;
            
            exception
	    	       
	    	     when others then
	    	           insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
	           values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name, i.c_case_number );
            
            end;
            
	 end if;
        
     end loop;
 
 end;


end;
/    

alter session set plsql_code_type = interpreted;  