-- insert TX EB project record
insert into d_project (d_project_id, project_name, d_division_id, create_date, last_modified_date)
values (13, 'TX Eligibility Support', 2, to_date('2014/05/20', 'yyyy/mm/dd'), to_date('2014/05/20', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.4','011','011_INSERT_TX_ES_PROJECT');

COMMIT;