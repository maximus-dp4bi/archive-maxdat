merge into s_crs_imr sci
using(
  with driver as
     (
     select distinct id, assignment_date as imr_cc_date, c_case_number
     from
       cadir_maxdat_stg s  
     , cadir_role_stg r
     , s_crs_imr i
     where s.role_id = r.role_id
     and s.c_case_number = i.case_number
     and r.name = 'Clinical Consultant Queue'
     ),
     driver2 as
     (
     select max(id)as MAX_ID from driver 
     group by c_case_number
     )
     select * from driver d, driver2 d2
     where d.id=d2.MAX_ID)m on (sci.case_number = m.c_case_number)
when matched then update
set sci.imr_cc_date = m.imr_cc_date;

commit;
