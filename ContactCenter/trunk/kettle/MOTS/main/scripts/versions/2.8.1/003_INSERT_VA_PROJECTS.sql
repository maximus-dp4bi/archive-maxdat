
INSERT INTO D_PROJECT (PROJECT_NAME, D_DIVISION_ID) VALUES ('VA EB', 1);

INSERT INTO D_PROGRAM (PROGRAM_NAME) VALUES ('M3');

INSERT INTO D_PROGRAM (PROGRAM_NAME) VALUES ('CCC');



INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.8.1','003','003_INSERT_VA_PROJECTS');

COMMIT;