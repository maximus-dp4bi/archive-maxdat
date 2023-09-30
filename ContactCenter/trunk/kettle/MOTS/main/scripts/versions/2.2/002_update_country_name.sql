
update cc_d_country
set country_name = 'USA'
where country_name = 'United States of America';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.2','002','002_UPDATE_COUNTRY_NAME');

COMMIT;