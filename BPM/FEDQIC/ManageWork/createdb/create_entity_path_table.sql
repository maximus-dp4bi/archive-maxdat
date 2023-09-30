 CREATE TABLE "MAXDAT"."D_BPM_ENTITY_APPROVED_PATH" 
   (	"ENTITY_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"NEXT_ENTITY_ID" NUMBER(18,0) NOT NULL ENABLE, 
	 CONSTRAINT "D_BPM_TASK_TYPE_ENTITY_FK3" FOREIGN KEY ("ENTITY_ID")
	  REFERENCES "MAXDAT"."D_BPM_ENTITY" ("ENTITY_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
Grant select on "MAXDAT"."D_BPM_ENTITY_APPROVED_PATH" to MAXDAT_READ_ONLY;
insert into d_bpm_entity_approved_path values (26,26);
insert into d_bpm_entity_approved_path values (26,12);
insert into d_bpm_entity_approved_path values (26,10);
insert into d_bpm_entity_approved_path values (26,6);
insert into d_bpm_entity_approved_path values (12,12);
insert into d_bpm_entity_approved_path values (12,16);
insert into d_bpm_entity_approved_path values (12,13);
insert into d_bpm_entity_approved_path values (12,6);
insert into d_bpm_entity_approved_path values (12,10);
insert into d_bpm_entity_approved_path values (5,5);
insert into d_bpm_entity_approved_path values (5,6);
insert into d_bpm_entity_approved_path values (5,10);
insert into d_bpm_entity_approved_path values (10,10);
insert into d_bpm_entity_approved_path values (10,12);
insert into d_bpm_entity_approved_path values (10,5);
insert into d_bpm_entity_approved_path values (6,6);
insert into d_bpm_entity_approved_path values (13,13);
insert into d_bpm_entity_approved_path values (13,16);
insert into d_bpm_entity_approved_path values (16,16);
insert into d_bpm_entity_approved_path values (16,12);
insert into d_bpm_entity_approved_path values (16,17);
insert into d_bpm_entity_approved_path values (17,17);
insert into d_bpm_entity_approved_path values (17,23);
insert into d_bpm_entity_approved_path values (17,6);
insert into d_bpm_entity_approved_path values (17,18);
insert into d_bpm_entity_approved_path values (17,22);
insert into d_bpm_entity_approved_path values (17,19);
insert into d_bpm_entity_approved_path values (18,18);
insert into d_bpm_entity_approved_path values (18,6);
insert into d_bpm_entity_approved_path values (18,17);
insert into d_bpm_entity_approved_path values (18,19);
insert into d_bpm_entity_approved_path values (18,22);
insert into d_bpm_entity_approved_path values (22,22);
insert into d_bpm_entity_approved_path values (22,17);
insert into d_bpm_entity_approved_path values (22,18);
insert into d_bpm_entity_approved_path values (19,19);
insert into d_bpm_entity_approved_path values (19,17);
