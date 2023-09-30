insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_DAYS'
,'INCIDENT_TIMELINESS'
,'JEOPARDY DAYS'
,20 
,null
,null
,sysdate
,null
,'Process Incidents Jeopardy Days'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_DAYS'
,'INCIDENT_TIMELINESS'
,'TIMELINESS DAYS'
,30 
,null
,null
,sysdate
,null
,'Incidents Timeliness Days'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_CALC'
,'INCIDENT_TIMELINESS'
,'TIMELINESS CALC'
,'B' 
,null
,null
,sysdate
,null
,'Incidents Timeliness Calculation'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY1_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'0.5'
,'1' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 1.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;


insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY2_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'1'
,'2' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 2.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY3_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'2'
,'3' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 3.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY4_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'3'
,'4' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 4.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY5_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'4'
,'5' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 5.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY6_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'5'
,'6' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 6.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY7_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'6'
,'7' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 7.  VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY8_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'7'
,'8' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 8. VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY9_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'8'
,'9' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 9. VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_JEOPARDY_PRIORITY10_CALC'
,'JEOPARDY_PRIORITY_CALC'
,'9'
,'10' 
,null
,null
,sysdate
,null
,'Jeopardy calculation for Incidents Priority 10. VALUE field has the jeopardy target. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY1_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'1'
,'1' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 1.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;


insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY2_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'2'
,'2' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 2.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY3_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'3'
,'3' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 3.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY4_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'4'
,'4' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 4.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY5_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'5'
,'5' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 5.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY6_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'6'
,'6' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 6.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY7_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'7'
,'7' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 7.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY8_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'8'
,'8' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 8.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY9_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'9'
,'9' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 9.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'PI_TIMELINESS_PRIORITY10_CALC'
,'TIMELINESS_PRIORITY_CALC'
,'10'
,'10' 
,null
,null
,sysdate
,null
,'Timeliness calculation for Incidents Priority 10.  VALUE field has the timeliness threshold. OUT_VAR field has the priority value.'
,sysdate
,sysdate)  ;

commit;