/*
Created on 12/19/2014 by Raj A.
Description:  DO NOT DEPLOY THIS. This only spits out Update statements.
This script maps the events to the correct UOW.
*/
begin

  for cur_rec in (
                  select 
                        (case when X.UOW_NAME is null then 'N'
                              when nvl(s_uow.unit_of_work_name,'a') <>  nvl(X.UOW_NAME,'a') then 'Y' else 'N' end
                         ) as change_needed,
                       s_uow.label,
                       s_uow.unit_of_work_name,
                       s_uow.uow_id,
                       s.source_ref_detail_identifier as db_source_ref_type,
                       s.source_ref_value as db_source_ref_value,
                       s.source_ref_id as db_source_ref_id,
                       s.usr_id        as db_usr_id,
                       X.UOW_NAME      as xls_UOW_name,
                       X.SOURCE_REFERENCE_VALUE as xls_source_ref_value,
                       x.source_reference_type  as xls_source_ref_type, 
                       X_uow.Uow_Id             as xls_uow_id
                from pp_d_uow_source_ref s
                left outer join PP_D_UNIT_OF_WORK s_uow on s.uow_id = s_uow.uow_id  
                LEFT OUTER JOIN PP_D_UOW_SOURCE_REF_excel X on s.SOURCE_REF_VALUE = X.SOURCE_REFERENCE_VALUE
                                                            and s.SOURCE_REF_DETAIL_IDENTIFIER = decode(x.source_reference_type,'TASK TYPE','TASK ID',x.source_reference_type)
                left outer join PP_D_UNIT_OF_WORK X_uow on X.UOW_NAME = X_uow.Unit_Of_Work_Name                                                                                   
                WHERE 1=1
                 --and s.SOURCE_REF_VALUE = 'Application In Process'
                )
    loop

     if cur_rec.change_needed = 'Y'
     then 
        
          dbms_output.put_line('update pp_d_uow_source_ref Z 
                                set uow_id = '||cur_rec.xls_uow_id||
                                ' where 1=1
                                and Z.SOURCE_REF_VALUE = '||''''||cur_rec.db_source_ref_value||''''||
                                ' and Z.SOURCE_REF_DETAIL_IDENTIFIER = '||''''||cur_rec.db_source_ref_type||''''||';'
                               );  
        
     /*  update pp_d_uow_source_ref Z
          set uow_id = cur_rec.xls_uow_id
        where 1=1
          and Z.SOURCE_REF_VALUE = cur_rec.db_source_ref_value
          and Z.SOURCE_REF_DETAIL_IDENTIFIER = cur_rec.db_source_ref_type;    */     
     
     end if;

    end loop;

commit;

end;