/*
Created on 03-Apr-2013 by Raj A.
Description:
This script nulls some attributes for the Active instances in the State Review stage table so they can be self-healed by the code.


SQL used to get the below seven NESR_IDs:
_______________________________
select *
from nyec_etl_state_review
where trunc(new_mi_creation_date) > assd_request_mi_notice
and instance_status = 'Active';  

*/

update nyec_etl_state_review
   set  
 ASSD_REQUEST_MI_NOTICE = null, 
 NEW_MI_CREATION_DATE = null, 
 NEW_MI_FLAG = 'N',
 gwf_mi_required = null,
 new_mi_satisfied = 'N',
 new_Mi_satisfied_date = null, 
 gwf_new_mi_satisfied = null
where nesr_id in (
94000,
102294,
93373,
96239,
101522,
93293,
92966
 );
commit;