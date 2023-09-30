-- F_SERVICE_LEVEL_AGREEMENT
CREATE INDEX F_SERVICE_LEVEL_AGREEMENT_IDX ON F_SERVICE_LEVEL_AGREEMENT 
    ( 
     D_SLA_PROJECT_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX F_SERVICE_LEVEL_AGREEMENT_IX ON F_SERVICE_LEVEL_AGREEMENT 
    ( 
     D_REPORTING_PERIOD_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_REPORTING_PERIOD
CREATE UNIQUE INDEX D_REPORTING_PERIOD__IDXv2 ON D_REPORTING_PERIOD 
    ( 
     TYPE ASC , 
     END_DATE DESC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- F_METRIC
CREATE INDEX F_METRIC__IDXv2 ON F_METRIC 
    ( 
     D_METRIC_PROJECT_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX F_METRIC__IDXv3 ON F_METRIC 
    ( 
     D_REPORTING_PERIOD_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_METRIC_PROJECT
CREATE INDEX D_METRIC_PROJECT__IDXv2 ON D_METRIC_PROJECT 
    ( 
     D_METRIC_DEFINITION_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_METRIC_PROJECT__IDXv3 ON D_METRIC_PROJECT 
    ( 
     D_PROGRAM_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_METRIC_PROJECT__IDXv4 ON D_METRIC_PROJECT 
    ( 
     D_PROJECT_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_METRIC_PROJECT__IDXv5 ON D_METRIC_PROJECT 
    ( 
     ACTUAL_EFF_DT DESC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_METRIC_PROJECT__IDXv6 ON D_METRIC_PROJECT 
    ( 
     FORECAST_EFF_DT DESC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

--D_METRIC_DEFINITION
CREATE INDEX D_METRIC_DEFINITION__IDXv2 ON D_METRIC_DEFINITION 
    ( 
     FUNCTIONAL_AREA ASC , 
     CATEGORY ASC , 
     SUB_CATEGORY ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_METRIC_DEFINITION__IDXv3 ON D_METRIC_DEFINITION 
    ( 
     D_DATA_TYPE_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_PROJECT
CREATE INDEX D_PROJECT__IDXv2 ON D_PROJECT 
    ( 
     D_DIVISION_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_DIVISION
CREATE INDEX D_DIVISION__IDXv2 ON D_DIVISION 
    ( 
     D_SEGMENT_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_SLA_PROJECT
CREATE INDEX D_SLA_PROJECT__IDXv2 ON D_SLA_PROJECT 
    ( 
     D_SLA_DEFINITION_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_SLA_PROJECT__IDXv3 ON D_SLA_PROJECT 
    ( 
     D_PROJECT_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_SLA_PROJECT__IDXv4 ON D_SLA_PROJECT 
    ( 
     D_PROGRAM_ID ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_SLA_PROJECT__IDXv5 ON D_SLA_PROJECT 
    ( 
     START_DATE DESC , 
     END_DATE DESC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

-- D_SLA_DEFINITION
CREATE INDEX D_SLA_DEFINITION__IDXv2 ON D_SLA_DEFINITION 
    ( 
     CATEGORY ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX D_SLA_DEFINITION__IDXv3 ON D_SLA_DEFINITION 
    ( 
     FUNCTIONAL_AREA ASC 
    ) 
    LOGGING 
tablespace MOTS_INDEX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('2.4',013,'013_ADD_INDEXES');

commit;
