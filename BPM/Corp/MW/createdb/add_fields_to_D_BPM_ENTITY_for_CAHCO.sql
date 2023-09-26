alter table d_bpm_entity add
(
    curr_business_process_pool                  varchar2(50)
);

alter table d_bpm_entity add
(
    curr_entity_source                          varchar2(50)
);

alter table d_bpm_entity add
(
    curr_entity_sort_order                      number(6,0)
);
