CREATE OR REPLACE PROCEDURE UPDATE_PAEAP_BAD_COUNTIES
AS
BEGIN
    execute immediate 'TRUNCATE TABLE MAXDAT_SUPPORT.PAEAP_BAD_COUNTIES'; 
    INSERT INTO MAXDAT_SUPPORT.PAEAP_BAD_COUNTIES (SELECTION_TXN_ID, PLAN_ID, PLAN_ID_EXT, ATTRIB_DISTRICT_CD, COMMENTS)
    SELECT st.SELECTION_TXN_ID SELECTION_TXN_ID,
      st.PLAN_ID PLAN_ID,
      st.PLAN_ID_EXT PLAN_ID_EXT,
      ec.ATTRIB_DISTRICT_CD,
      p.COMMENTS
    FROM selection_txn st
    JOIN plans p        ON (st.PLAN_ID = p.PLAN_ID)
    JOIN enum_county ec ON (ec.VALUE = st.COUNTY)
    WHERE transaction_type_cd = 'DefaultEnroll'
    AND status_cd = 'acceptedByState'
    AND ec.ATTRIB_DISTRICT_CD <> p.COMMENTS
    ORDER BY selection_txn_id DESC;
COMMIT;
END;

