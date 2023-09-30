update cc_f_agent_by_date
set d_site_id=0
where d_site_id in (1,2,3);

update cc_f_agent_activity_by_date
set d_site_id=0
where d_site_id in (1,2,3);

commit;

delete from cc_d_site
where d_site_id in (1,2,3);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.1','103','103_UPDATE_OBSOLETE_SITE_ID_IN_FACTS');

commit;