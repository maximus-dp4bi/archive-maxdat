update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('11/25/2015', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-18707' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('11/25/2015', 'mm/dd/yyyy') where dcn = '12310247';
update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('11/25/2015', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-18707' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('11/25/2015', 'mm/dd/yyyy') where dcn = '12310248';
update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('11/25/2015', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-18707' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('11/25/2015', 'mm/dd/yyyy') where dcn = '12310249';

commit;
