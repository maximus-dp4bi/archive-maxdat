set define off;

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CSR','CSR');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CSR3','CSR3');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','Case Closure Queue');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','IV');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','IV_RESEARCH');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','VIC');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','OTHER');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','VIC_RESEARCH');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','EMAIL_QUESTIONS');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','EDIT_LIST');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('E&E','ORPHAN');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('FINANCE','FINANCE');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('FINANCE','APPROVE_IMMEDIATE_REFUNDS');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','DISPUTE');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','RESEARCH_RETRO');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','MERGE_ACCOUNTS');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','CUSTODY');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','CANCEL_MDCD_REFERRAL');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','DUAL_ENROLLMENT');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','CMSN_CHANGE');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','SUPERVISOR_CALLBACK');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','RESEARCH_EXT_ENTITY');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','GRANT_RETRO');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','FHKC_DISPUTE');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Client Services Team','DISPUTE_ACTION');

insert into d_teams (team_id, team_name, team_description, team_supervisor_staff_id) values (1, 'CSR', 'CSR', 0);
insert into d_teams (team_id, team_name, team_description, team_supervisor_staff_id) values (2, 'CSR3', 'CSR3', 0);
insert into d_teams (team_id, team_name, team_description, team_supervisor_staff_id) values (3, 'E&E', 'E&E', 0);
insert into d_teams (team_id, team_name, team_description, team_supervisor_staff_id) values (4, 'FINANCE', 'FINANCE', 0);
insert into d_teams (team_id, team_name, team_description, team_supervisor_staff_id) values (5, 'Client Services Team', 'Client Services Team', 0);
--                                                                                                                                                                   (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts)                                                                                                                                                                                           
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','ORPHAN','B','WRT_ID',41,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','IV','B','WRT_ID',42,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','VIC','B','WRT_ID',43,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','CUSTODY','B','WRT_ID',44,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DISPUTE','B','WRT_ID',45,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','OTHER','B','WRT_ID',46,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','FINANCE','B','WRT_ID',47,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','SUPERVISOR_CALLBACK','B','WRT_ID',48,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','CSR3','B','WRT_ID',49,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','IV_RESEARCH','B','WRT_ID',50,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','VIC_RESEARCH','B','WRT_ID',51,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','MERGE_ACCOUNTS','B','WRT_ID',52,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','RESEARCH_RETRO','B','WRT_ID',53,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','APPROVE_RETRO','B','WRT_ID',54,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','EDIT_LIST','B','WRT_ID',55,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','APPROVE_REFUNDS','B','WRT_ID',56,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','CANCEL_MDCD_REFERRAL','B','WRT_ID',57,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DUAL_ENROLLMENT','B','WRT_ID',58,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','CMSN_CHANGE','B','WRT_ID',60,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','RESEARCH_EXT_ENTITY','B','WRT_ID',61,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','EMAIL_QUESTIONS','B','WRT_ID',62,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','APPROVE_IMMEDIATE_REFUNDS','B','WRT_ID',63,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','GRANT_RETRO','B','WRT_ID',64,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','FHKC_DISPUTE','B','WRT_ID',65,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','FHKC','B','WRT_ID',66,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days_Type','TASK_TYPE','DISPUTE_ACTION','B','WRT_ID',67,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','ORPHAN','4','WRT_ID',41,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','IV','7','WRT_ID',42,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','VIC','4','WRT_ID',43,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','CUSTODY','4','WRT_ID',44,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DISPUTE','3','WRT_ID',45,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','OTHER','4','WRT_ID',46,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','FINANCE','3','WRT_ID',47,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','SUPERVISOR_CALLBACK','1','WRT_ID',48,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','CSR3','2','WRT_ID',49,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','IV_RESEARCH','4','WRT_ID',50,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','VIC_RESEARCH','2','WRT_ID',51,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','MERGE_ACCOUNTS','2','WRT_ID',52,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','RESEARCH_RETRO','3','WRT_ID',53,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','APPROVE_RETRO','2','WRT_ID',54,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','EDIT_LIST','8','WRT_ID',55,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','APPROVE_REFUNDS','2','WRT_ID',56,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','CANCEL_MDCD_REFERRAL','2','WRT_ID',57,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DUAL_ENROLLMENT','4','WRT_ID',58,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','CMSN_C4HANGE','5','WRT_ID',60,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','RESEARCH_EXT_ENTITY','3','WRT_ID',61,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','EMAIL_QUESTIONS','2','WRT_ID',62,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','APPROVE_IMMEDIATE_REFUNDS','3','WRT_ID',63,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','GRANT_RETRO','2','WRT_ID',64,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','FHKC_DISPUTE','2','WRT_ID',65,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','FHKC','2','WRT_ID',66,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Days','TASK_TYPE','DISPUTE_ACTION','3','WRT_ID',67,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','ORPHAN','-1','WRT_ID',41,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','VI','-1','WRT_ID',42,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','VIC','-1','WRT_ID',43,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','CUSTODY','-1','WRT_ID',44,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DISPUTE','-1','WRT_ID',45,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','OTHER','-1','WRT_ID',46,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','FINANCE','-1','WRT_ID',47,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','SUPERVISOR_CALLBACK','-1','WRT_ID',48,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','CSR3','-1','WRT_ID',49,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','IV_RESEARCH','-1','WRT_ID',50,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','VIC_RESEARCH','-1','WRT_ID',51,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','MERGE_ACCOUNTS','-1','WRT_ID',52,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','RESEARCH_RETRO','-1','WRT_ID',53,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','APPROVE_RETRO','-1','WRT_ID',54,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','EDIT_LIST','-1','WRT_ID',55,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','APPROVE_REFUNDS','-1','WRT_ID',56,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','CANCEL_MDCD_REFERRAL','-1','WRT_ID',57,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DUAL_ENROLLMENT','-1','WRT_ID',58,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','CMSN_CHANGE','-1','WRT_ID',60,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','RESEARCH_EXT_ENTITY','-1','WRT_ID',61,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','EMAIL_QUESTIONS','-1','WRT_ID',62,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','APPROVE_IMMEDIATE_REFUNDS','-1','WRT_ID',63,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','GRANT_RETRO','-1','WRT_ID',64,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','FHKC_DISPUTE','-1','WRT_ID',65,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','FHKC','-1','WRT_ID',66,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Jeopardy_Days','TASK_TYPE','DISPUTE_ACTION','-1','WRT_ID',67,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);

insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','ORPHAN','4','WRT_ID',41,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','IV','7','WRT_ID',42,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','VIC','4','WRT_ID',43,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','CUSTODY','4','WRT_ID',44,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','DISPUTE','3','WRT_ID',45,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','OTHER','4','WRT_ID',46,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','FINANCE','3','WRT_ID',47,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','SUPERVISOR_CALLBACK','1','WRT_ID',48,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','CSR3','2','WRT_ID',49,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','IV_RESEARCH','4','WRT_ID',50,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','VIC_RESEARCH','2','WRT_ID',51,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','MERGE_ACCOUNTS','2','WRT_ID',52,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','RESEARCH_RETRO','3','WRT_ID',53,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','APPROVE_RETRO','2','WRT_ID',54,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','EDIT_LIST','8','WRT_ID',55,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','APPROVE_REFUNDS','2','WRT_ID',56,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','CANCEL_MDCD_REFERRAL','2','WRT_ID',57,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','DUAL_ENROLLMENT','4','WRT_ID',58,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','CMSN_CHANGE','5','WRT_ID',60,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','RESEARCH_EXT_ENTITY','3','WRT_ID',61,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','EMAIL_QUESTIONS','2','WRT_ID',62,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','APPROVE_IMMEDIATE_REFUNDS','3','WRT_ID',63,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','GRANT_RETRO','2','WRT_ID',64,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','FHKC_DISPUTE','2','WRT_ID',65,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','FHKC','2','WRT_ID',66,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
insert into CORP_ETL_LIST_LKUP (cell_id,name,list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments, created_ts, updated_ts) VALUES (seq_cell_id.nextval,'ManageWork_SLA_Target_Days','TASK_TYPE','DISPUTE_ACTION','3','WRT_ID',67,trunc(sysdate-1),to_date('07077777','mmddyyyy'),'Initial Load',sysdate,sysdate);
commit;

insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(41, 'ORPHAN','Orphan', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'ORPHAN');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(42, 'IV','IV', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'IV');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(43, 'VIC','VIC', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'VIC');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(44, 'CUSTODY','CUSTODY', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'CUSTODY');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(45, 'DISPUTE','DISPUTE', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'DISPUTE');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(46, 'OTHER','OTHER', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'OTHER');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(47, 'FINANCE','FINANCE', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'FINANCE');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(48, 'SUPERVISOR_CALLBACK','SUPERVISOR CALLBACK', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'SUPERVISOR CALLBACK');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(49, 'CSR3','CSR3', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'CSR3');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(50, 'IV_RESEARCH','IV RESEARCH', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'IV RESEARCH');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(51, 'VIC_RESEARCH','VIC RESEARCH', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'VIC RESEARCH');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(52, 'MERGE_ACCOUNTS','MERGE ACCOUNTS', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'MERGE ACCOUNTS');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(53, 'RESEARCH_RETRO','RESEARCH RETRO', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'RESEARCH RETRO');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(54, 'APPROVE_RETRO','APPROVE RETRO', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'APPROVE RETRO');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(55, 'EDIT_LIST','EDIT LIST', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'EDIT LIST');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(56, 'APPROVE_REFUNDS','APPROVE REFUNDS', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'APPROVE REFUNDS');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(57, 'CANCEL_MDCD_REFERRAL','CANCEL MDCD REFERRAL', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'CANCEL MDCD REFERRAL');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(58, 'DUAL_ENROLLMENT','DUAL ENROLLMENT', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'DUAL ENROLLMENT');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(60, 'CMSN_CHANGE','CMSN CHANGE', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'CMSN CHANGE');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(61, 'RESEARCH_EXT_ENTITY','RESEARCH_EXT_ENTITY', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'RESEARCH EXT ENTITY');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(62, 'EMAIL_QUESTIONS','EMAIL QUESTIONS', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'EMAIL QUESTIONS');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(63, 'APPROVE_IMMEDIATE_REFUNDS','APPROVE IMMEDIATE REFUNDS', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'APPROVE IMMEDIATE REFUNDS');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(64, 'GRANT_RETRO','GRANT_RETRO', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'GRANT RETRO');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(65, 'FHKC_DISPUTE','FHKC DISPUTE', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'FHKC DISPUTE');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(66, 'FHKC','FHKC', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'FHKC');
commit;
insert into step_definition_stg 
(step_definition_id,name,description,time_to_complete,time_unit_cd,forwarding_rule_cd,escalation_rule_cd,priority_cd,
 perform_timeout_ind,step_type_cd,created_by,create_ts,updated_by,update_ts,manual_task_ind,spring_bean,correlation_parts,display_name) 
values(67, 'DISPUTE_ACTION','DISPUTE ACTION', 2, 'days',null,null,null,0, null,'<anonymous>',sysdate, null, null,0,null, null,'DISPUTE ACTION');
commit;


insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (1, 'CSR','CSR');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (2, 'CSR3','CSR3');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (3, 'CANCEL_MDCD_REFERRAL','CANCEL_MDCD_REFERRAL');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (4, 'CMSN_CHANGE','CMSN_CHANGE');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (5, 'CUSTODY','CUSTODY');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (6, 'DISPUTE','DISPUTE');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (7, 'DISPUTE_ACTION', 'DISPUTE_ACTION');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (8, 'DUAL_ENROLLMENT','DUAL_ENROLLMENT');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (9, 'FHKC_DISPUTE','FHKC_DISPUTE');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (10, 'MERGE_ACCOUNTS','MERGE_ACCOUNTS');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (11, 'RESEARCH_EXT_ENTITY','RESEARCH_EXT_ENTITY');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (12, 'RESEARCH_RETRO', 'RESEARCH_RETRO');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (13, 'SUPERVISOR_CALLBACK','SUPERVISOR_CALLBACK');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (15, 'EDIT_LIST','EDIT_LIST');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (16, 'EMAIL_QUESTIONS','EMAIL_QUESTIONS');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (17, 'IV', 'IV');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (18, 'IV_RESEARCH','IV_RESEARCH');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (19, 'ORPHAN','ORPHAN');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (20, 'OTHER','OTHER');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (21, 'VIC','VIC');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (22, 'VIC_RESEARCH','VIC_RESEARCH');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (23, 'APPROVE_IMMEDIATE_REFUNDS');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (24, 'FINANCE');
insert into d_task_types (TASK_TYPE_ID, TASK_NAME,TASK_DESCRIPTION) values (25, 'SUPERVISOR_CALLBACK');

commit;

insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (1, 'CSR', 'CSR');
insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (2, 'CSR3', 'CSR3');
insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (3, 'Client Services Team', 'Client Services Team');
insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (4, 'E&E', 'E&E');
insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (5, 'FINANCE', 'FINANCE');
insert into d_business_units (business_unit_id, business_unit_name, business_unit_description) values (6, 'Supervisor', 'Supervisor');
commit;
