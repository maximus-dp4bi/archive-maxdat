-- Alter table D_BPM_ENTITY
alter table d_bpm_entity modify
(
    timeliness_threshold        NUMBER(4,0)    
);

-- Alter table D_BPM_FLOW_INSTANCE
alter table d_bpm_flow_instance modify
(
    flow_name           VARCHAR2(140)
);

-- Alter table D_BPM_FLOW
alter table d_bpm_flow modify
(
    flow_name           VARCHAR2(140)
);




