update corp_etl_list_lkup set value = 'State Supervisory Review-Financial Management'
where value = 'State Supervisory Review-Financial ManagementP'
and  name = 'ProcessComp_Fwding_Target'
and list_type = 'COMPLAINT';

Commit;