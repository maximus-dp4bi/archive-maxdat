update corp_etl_clnt_or_activity_lkup
set outreach_type = '1093 - Extra Effort Referral'
where outreach_type = 'Extra Effort Referrals';

commit;