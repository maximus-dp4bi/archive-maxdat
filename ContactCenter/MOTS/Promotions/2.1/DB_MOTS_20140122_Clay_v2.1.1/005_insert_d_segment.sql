
insert into d_segment (d_segment_id, segment_name, create_date, last_modified_date)
values (2, 'Human Services', SYSDATE, SYSDATE);

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME, SCRIPT_RUN_DATE) VALUES ('2.1', 5, '005_insert_d_segment.sql', SYSDATE);