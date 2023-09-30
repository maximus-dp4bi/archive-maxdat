INSERT INTO BPM_PROJECT_LKUP 
   (
     BPRJ_ID
     ,NAME
   )
VALUES 
   (
     10,
     'Manage Work Rel 6'
   );

INSERT INTO BPM_PROCESS_LKUP
    (
    BPROL_ID
    , NAME
    , DESCRIPTION
    )
VALUES
    (
    2002
    , 'Manage Work Rel 6'
    , 'Review and perform work assigned and integrate production planning'
    );

INSERT INTO BPM_SOURCE_LKUP
    (
    BSL_ID
    , NAME
    , BSTL_ID
    )
VALUES
    (
    2002
    , 'CORP_ETL_MW'
    , 1
    );

INSERT INTO BPM_EVENT_MASTER
    (
    BEM_ID
    , BRL_ID
    , BPRJ_ID
    , BPRG_ID
    , BPROL_ID
    , NAME
    , DESCRIPTION
    , EFFECTIVE_DATE
    , END_DATE
    )
VALUES
    (
    2002
    , 1
    , 10 -- This value is set by getting the next available ID by get max on the MOTSMXDD database, BPM_PROJECT_LKUP table (see svn://rcmxapp1d.maximus.com/maxdat/BPM/doc/BPM_Developers_Guide.docx, Page 11)
    , 1
    , 2002
    , 'OPS MW Rel 6' -- Update to reflect the project being deployed into
    , 'Operations MW Rel 6' -- Update to reflect the project being deployed into
    , to_date ('2017-10-13 18:38:17', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2077-07-07', 'YYYY-MM-DD')
    );

COMMIT;
