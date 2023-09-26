update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('1/27/2016', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-19580' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('1/27/2016', 'mm/dd/yyyy'), STG_DONE_DATE = to_date('1/27/2016', 'mm/dd/yyyy') where dcn = '12533590';
update NYHIX_ETL_MAIL_FAX_DOC_V2 set CANCEL_DT  = to_date('1/27/2016', 'mm/dd/yyyy') ,CANCEL_BY = 'NYHIX-19698' ,ASF_CANCEL_DOC = 'Y' ,CANCEL_REASON = 'Inactivated' ,CANCEL_METHOD = 'Exception' ,INSTANCE_STATUS = 'Complete' ,INSTANCE_END_DATE = to_date('1/27/2016', 'mm/dd/yyyy'), STG_DONE_DATE = to_date('1/27/2016', 'mm/dd/yyyy') where dcn = '12563119';

commit;
