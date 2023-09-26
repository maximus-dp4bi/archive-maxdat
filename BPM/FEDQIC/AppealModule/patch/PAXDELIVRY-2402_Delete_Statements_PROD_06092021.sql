
####### CORP_ETL_DOCUMENT ###########
delete from maxdat.corp_etl_document where appeal_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

######## CORP_ETL_APPEAL ###########
delete from maxdat.corp_etl_appeal where appeal_part_id in ( 1580,1581 ) ;

######## CORP_ETL_CLAIM_LINE_ITEM ########### ( NEW ) 
delete from maxdat.corp_etl_claim_line_item where claim_id  in ( select a.CLAIM_ID from maxdat.d_qic_claim a inner join maxdat.d_mw_appeal_instance b on
a.appeal_id = b.appeal_id where b.appeal_part_id in ( 1580,1581 ));

######## CORP_ETL_CLAIM ########### ( NEW ) 
delete from maxdat.corp_etl_claim where appeal_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

####### FEDQIC_DOCUMENT_STG ########### ( NEW ) - Not done in UAT
delete from maxdat.fedqic_document_stg where id_parent in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

######## fedqic_appeal_stg ########### ( NEW ) - Not done in UAT
delete from maxdat.fedqic_appeal_stg where c_part in ( 1580,1581 ) ;

######## FEDQIC_CLAIM_LINE_ITEM_STG ########### ( NEW ) - Not done in UAT
delete from maxdat.fedqic_claim_line_item_stg where id_parent  in ( select a.CLAIM_ID from maxdat.d_qic_claim a inner join maxdat.d_mw_appeal_instance b on
a.appeal_id = b.appeal_id where b.appeal_part_id in ( 1580,1581));

######## FEDQIC_CLAIM_STG ########### ( NEW ) - Not done in UAT
delete from maxdat.fedqic_claim_stg where id_parent in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580, 1581));

####### D_QIC_DOCUMENT #########
delete from maxdat.d_qic_document where appeal_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

###### F_APPEAL_TASKS_BY_DAY #######
delete from maxdat.f_appeal_tasks_by_day where appeal_part_id in ( 1580 , 1581 ) ;

###### F_APPEALS_BY_DAY_BY_PART #######
delete from maxdat.F_APPEALS_BY_DAY_BY_PART where appeal_part_id in ( 1580 , 1581 ) ;

######  D_MW_TASK_HISTORY #########
delete from maxdat.d_mw_task_history where mw_bi_id in ( 
select mw_bi_id from maxdat.d_mw_task_instance a inner join maxdat.d_mw_appeal_instance b
on
a.source_reference_id = b.appeal_id where b.appeal_part_id in ( 1580 , 1581 )) ;

####### D_MW_TASK_INSTANCE ########
delete from maxdat.d_mw_task_instance where source_reference_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 )) ;

######## CORP_ETL_MW ###########
delete from maxdat.corp_etl_MW where source_reference_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

####### D_QIC_CLAIM_LINE_ITEM ############ 
delete from maxdat.d_qic_claim_line_item where claim_id  in ( select a.CLAIM_ID from maxdat.d_qic_claim a inner join maxdat.d_mw_appeal_instance b on
a.appeal_id = b.appeal_id where b.appeal_part_id in ( 1580,1581 ));

####### D_QIC_CLAIM ############ 
delete from maxdat.d_qic_claim where appeal_id in ( select appeal_id from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ));

####### D_MW_APPEAL_INSTANCE#####
delete  from maxdat.d_mw_appeal_instance where appeal_part_id in ( 1580 , 1581 ) ;

######## D_APPEAL_PARTS ###########
delete from maxdat.d_appeal_parts where part_id in ( 1580,1581 );

######## D_BUSINESS_UNITS ###########
delete from maxdat.d_business_units where business_unit_id in ( 1580,1581 );

####### Materialized Views ########### ( NEW ) - Not done in UAT

delete from maxdat.appeal_staff_performance_by_day_mv where appeal_part in ( 'Part D-Drug', 'Part D-LEP');

delete  from maxdat.appeal_details_by_day_mv where appeal_part in ( 'Part D-Drug', 'Part D-LEP');

delete from maxdat.appeal_tasks_by_day_mv where appeal_part in ( 'Part D-Drug', 'Part D-LEP');

