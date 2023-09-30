ALTER table CORP_CLNT_OUTREACH_NOTIFY_LKUP
ADD (timeliness_num NUMBER);

UPDATE corp_clnt_outreach_notify_lkup
SET timeliness_num = to_number(timeliness);

commit;

ALTER table CORP_CLNT_OUTREACH_NOTIFY_LKUP
DROP column timeliness;

ALTER table CORP_CLNT_OUTREACH_NOTIFY_LKUP
RENAME column timeliness_num to timeliness;