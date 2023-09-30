-- 7/25/13 New TXEB attributes added to ILEB

ALTER TABLE corp_etl_client_inquiry ADD
(created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
);

ALTER TABLE corp_etl_clnt_inqry_oltp ADD
(created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
);

ALTER TABLE corp_etl_clnt_inqry_wip ADD
(created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
);

ALTER TABLE corp_etl_client_inquiry_dtl ADD
(client_under_twentyone VARCHAR2(1)
);

ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD
(client_under_twentyone VARCHAR2(1)
);


