update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('05/25/2016', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-22486' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('05/25/2016', 'mm/dd/yyyy'), STG_DONE_DATE = to_date('05/25/2016', 'mm/dd/yyyy') where dcn = '13265339';

commit;
