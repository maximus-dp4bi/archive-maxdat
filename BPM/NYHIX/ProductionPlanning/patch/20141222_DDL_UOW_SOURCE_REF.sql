/*
Created on 12/22/2014 by Raj A for NYHIX-12475, 12571 & 12587
Description:
*/
ALTER TABLE MAXDAT.PP_D_UOW_SOURCE_REF 
DROP CONSTRAINT PP_D_UOW_SOURCE_REF_UK;

DROP INDEX PP_D_UOW_SOURCE_REF_UK;

ALTER TABLE MAXDAT.PP_D_UOW_SOURCE_REF 
DROP CONSTRAINT PP_D_UOW_SOURCE_REF_UN;

ALTER TABLE MAXDAT.PP_D_UOW_SOURCE_REF 
DROP CONSTRAINT PP_D_UOW_SOURCE_REF_UN1;

DROP INDEX PP_D_UOW_SOURCE_REF_UN;
DROP INDEX PP_D_UOW_SOURCE_REF_UN1;

 alter table MAXDAT.PP_D_UOW_SOURCE_REF
   add constraint PP_D_UOW_SOURCE_REF_UN unique (UOW_ID, SOURCE_REF_TYPE_ID, SOURCE_REF_VALUE, source_ref_id, EFFECTIVE_DATE);
 alter table MAXDAT.PP_D_UOW_SOURCE_REF
   add constraint PP_D_UOW_SOURCE_REF_UN1 unique (UOW_ID, SOURCE_REF_TYPE_ID, SOURCE_REF_VALUE, source_ref_id, END_DATE);
   
/*
Below is added by Raj. DMLs were provided by Rey.
During NYHIX-12587, below record errored out due to PRD data.
*/   
update pp_d_uow_source_ref z   
set end_date = trunc(sysdate - 1)
where z.uow_id=19 and Z.SOURCE_REF_VALUE = 'DPR - Financial Management'
   and Z.SOURCE_REF_DETAIL_IDENTIFIER = 'TASK ID';
   
   
insert into maxdat.pp_d_uow_source_ref
  (usr_id, uow_id, source_ref_type_id, source_ref_value, source_ref_detail_identifier, effective_date, end_date, source_ref_id)
values
  (1028, 26, 1, 'DPR - Financial Management', 'TASK ID', trunc(sysdate-1), to_date('07-07-2077', 'dd-mm-yyyy'), null);
   