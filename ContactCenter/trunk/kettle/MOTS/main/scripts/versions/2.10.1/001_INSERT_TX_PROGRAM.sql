
insert into d_program (program_name, create_date, last_modified_date)
values ('Multiple - EB/THS/CHIP', SYSDATE, SYSDATE);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.10.1','001','001_INSERT_TX_PROGRAM');

COMMIT;