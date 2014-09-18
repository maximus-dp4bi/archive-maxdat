create public synonym cc_s_vm_in_queue for maxdat.CC_S_VM_IN_QUEUE;
   
grant select on cc_s_vm_in_queue to public;

create or replace view cc_s_vm_in_queue_sv as select * from cc_s_vm_in_queue;

create public synonym cc_s_vm_in_queue_sv for maxdat.CC_S_VM_IN_QUEUE_sv;

grant select on cc_s_vm_in_queue_sv to public;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.1','101','101_create_public_synonym_and_view');

commit;