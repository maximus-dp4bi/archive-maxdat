alter table CC_EVENT_STG
add (  event_created_by   VARCHAR2(80),
       ref_type           VARCHAR2(32)
    )
;
