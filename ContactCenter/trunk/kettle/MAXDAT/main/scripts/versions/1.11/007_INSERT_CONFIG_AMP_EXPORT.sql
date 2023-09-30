/* Soundra 5/2/2016
List of Metrics and the sources they need. All metrics need ACD, so it is not explicitly stored. Only metrics which need non-mandatory sources are configured.
*/

Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','PEAK_WEEK_PERCENTAGE','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
