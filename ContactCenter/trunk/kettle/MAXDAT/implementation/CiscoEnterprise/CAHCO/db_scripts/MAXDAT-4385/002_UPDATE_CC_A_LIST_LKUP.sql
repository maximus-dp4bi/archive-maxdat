update cc_a_list_lkup
set out_var = ''''||'800'||''''||',''866'||''''||',''888'||''''
where name = 'CAHCO_HANDLED_CALLS_DNIS_CODE'
and list_type = 'DNIS_CODE'
and value = 'CAHCO_HANDLED_CALLS_DNIS_CODE';

update cc_a_list_lkup
set out_var = ''''||'777'||''''
where name = 'CAHCO_DNIS_CODE'
and list_type = 'DNIS_CODE'
and value = 'CAHCO_DNIS_CODE';

--update cc_a_list_lkup
--set out_var = '6106,6107,6126,6152'
--where name = 'CAHCO_IVR_call_types'
--and list_type = 'IVR_CALLTYPES'
--and value = 'CAHCO_IVR_call_types';

commit;