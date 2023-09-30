Create table Assgined_dt_fix_09032014 
as
Select Assignment_id, Tracking_ID, mw_processed
  From Cadir_Maxdat_Stg MS
 Inner Join cadir_role_stg RS  ON RS.role_id = MS.role_id
 Where MS.c_assigned_Date is null  
   And MS.subject_type = 2
   And RS.name <> 'Closed Cases Queue';
 
create index Fix_Assigned_dt_INDXAS on Assgined_dt_fix_09032014 (ASSIGNMENT_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 
  
create or replace public synonym Assgined_dt_fix_09032014  for Assgined_dt_fix_09032014 ;  