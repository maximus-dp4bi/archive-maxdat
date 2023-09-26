truncate table cc_c_ivr_ctrls;
truncate table cc_s_ivr_performance_instance_ext;
truncate table cc_s_tmp_class_run;

alter table cc_c_ivr_ctrls add
(
    ctrl_abbr           VARCHAR2(200)       NOT NULL
);

comment on column cc_c_ivr_ctrls.ctrl_abbr  is 'Control Abbreviation.  Unique key of the table.';

alter table cc_c_ivr_ctrls drop constraint cc_c_ivr_ctrls_un;
drop index cc_c_ivr_ctrls_un;

create unique index cc_c_ivr_ctrls_un on cc_c_ivr_ctrls (ctrl_abbr) tablespace maxdat_data;

alter table cisco_enterprise_cc.cc_c_ivr_ctrls add 
(
    constraint cc_c_ivr_ctrls_un unique 
    (   
        ctrl_abbr
    )    
    using index cc_c_ivr_ctrls_un 
    enable
);