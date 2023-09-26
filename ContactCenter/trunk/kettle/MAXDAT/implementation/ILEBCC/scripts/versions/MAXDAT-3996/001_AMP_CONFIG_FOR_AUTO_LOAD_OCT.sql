update cc_a_list_lkup set list_type = 'ACD,IVR' , out_var = 'ACD,IVR' where name = 'AMPEXP_PROJECT_SOURCE_LIST'
and value = 'MI MSS';

commit;