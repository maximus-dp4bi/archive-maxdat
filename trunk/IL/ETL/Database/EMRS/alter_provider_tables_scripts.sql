ALTER TABLE emrs_d_provider
DROP constraint PROV_SPECGROUP_FK;

DROP TABLE emrs_d_specialty_group;

DROP TABLE erms_d_specialty_group_ref;

ALTER TABLE emrs_d_provider
DROP COLUMN specialty_group_id;

ALTER TABLE emrs_d_provider
MODIFY provider_title VARCHAR2(32);