update corp_etl_mailfaxdoc set gwf_autolink_outcome = null where gwf_autolink_outcome = 'X';
update corp_etl_mailfaxdoc set gwf_work_identified = null where gwf_work_identified = 'X';

update D_MFDOC_CURRENT set "Autolink Outcome Flag" =  null  where "Autolink Outcome Flag" = 'X';
update D_MFDOC_CURRENT set "Work Identified Flag" =  null  where "Work Identified Flag" = 'X';

commit;