update PP_D_UOW_SOURCE_REF
set UOW_ID=19
where end_date>=sysdate
and source_ref_detail_identifier!='PIPKINS EVENTS'
and source_ref_value in 
(
'APPEAL'
,'Document Problem Resolution'
,'DPR - Account Correction'
,'DPR - Appeals'
,'DPR - Application in Process'
,'DPR - Complaint'
,'DPR - Doc/Form Type Mismatch Task'
,'DPR - Financial Management'
,'DPR - FM Returned Mail'
,'DPR - Free Form Follow-Up'
,'DPR - Multiple Applications'
,'DPR - Orphan Document'
,'DPR - Returned Mail Application'
,'DPR - Wrong Program'
,'NYHBE Verification Doc Research Task'
,'Returned Mail Data Entry Task'
);

update PP_D_UOW_SOURCE_REF
set UOW_ID=18
where end_date>=sysdate
and source_ref_detail_identifier!='PIPKINS EVENTS'
and source_ref_value in 
(
'Data Entry-Verification Document Task'
);

update PP_D_UOW_SOURCE_REF
set UOW_ID=9
where end_date>=sysdate
and source_ref_detail_identifier!='PIPKINS EVENTS'
and source_ref_value in 
(
'DPR - Other'
,'HSDE-QC'
,'HSDE-QC VHT'
,'Other'
);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,8,1,'DPR - SHOP Employee Task','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,19,1,'Application In Process','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,19,1,'DPR - Document Problem Resolution','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,19,1,'Financial Management','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,19,1,'FM Returned Mail','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

insert into PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID)
values (SEQ_PP_USR_ID.NEXTVAL,19,1,'Returned Mail - Application','TASK ID',SYSDATE,to_date('07-JUL-77','dd-mon-yy'),NULL);

update PP_D_UOW_SOURCE_REF
set end_date=to_date('07-JUL-77','dd-mon-yy')
where source_ref_detail_identifier='PIPKINS EVENTS'
and end_date is null

commit;







