alter session set current_schema = cisco_enterprise_cc;

delete 
select * from cc_c_ivr_holidays;
commit;

declare

    cursor c_projects_n_programs
    is
/*    select  distinct
            d_project_id,
            d_program_id
      from  cc_c_ivr_ctrls;
*/
select --distinct proj.project_name, prog.program_name
distinct proj.project_id d_project_id, prog.program_id d_program_id
from cc_c_ivr_language l, cc_d_project proj, cc_d_program prog
where l.program_name = prog.program_name
and l.project_name = proj.project_name
and l.project_name not like '%CA%'
;

      
begin

    for rec in c_projects_n_programs
    loop

        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('01/01/2020', 'mm/dd/yyyy'), 2020, 'New Year''s Day');

        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('01/20/2020', 'mm/dd/yyyy'), 2020, 'Dr. Martin Luther King, Jr. Day');

        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('02/17/2020', 'mm/dd/yyyy'), 2020, 'Presidents'' Day');
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('03/31/2020', 'mm/dd/yyyy'), 2020, 'Cesar Chavez Day');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('05/25/2020', 'mm/dd/yyyy'), 2020, 'Memorial Day ');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('07/04/2020', 'mm/dd/yyyy'), 2020, 'Independence Day');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('09/07/2020', 'mm/dd/yyyy'), 2020, 'Labor Day');   
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('11/11/2020', 'mm/dd/yyyy'), 2020, 'Veterans Day');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('11/26/2020', 'mm/dd/yyyy'), 2020, 'Thanksgiving Day');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('11/27/2020', 'mm/dd/yyyy'), 2020, 'Friday after Thanksgiving');        
        
        insert
          into  cc_c_ivr_holidays   (d_program_id, d_project_id, holiday_date, holiday_year, description)
        values                      (rec.d_program_id, rec.d_project_id, to_date('12/25/2020', 'mm/dd/yyyy'), 2020, 'Christmas Day');        
    
    end loop;

end;
/
commit;
