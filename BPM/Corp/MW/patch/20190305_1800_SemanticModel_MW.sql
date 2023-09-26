alter table d_mw_task_instance add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);

alter table gtt_mw_task_instance add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);
