/*
SND 12212023 INEB changes for Call Reasons report
*/

create or replace VIEW PUBLIC.INEB_CONTACT_RECORD_PROGRAM_TYPE_SV AS
SELECT * FROM MARSDB.MARSDB_CONTACT_RECORD_PROGRAM_TYPE_VW
WHERE PROJECT_ID = 118;

create or replace view PUBLIC.INEB_CONTACT_PROGRAM_REASON_XWALK_SV as
SELECT  d.project_id
    , I.source_table for_table
    , I.UI_INDEPENDENT_DISPLAY_FIELD for_context
    , I.SELECTION_VALUE for_value
    , c.source_table list_table
    , C.CONDITIONAL_DISPLAY_FIELD list_context
    , C.SELECTION_VALUE list_value
    , d.effective_start_date
    , nvl(d.effective_end_Date,'9999-01-01') effective_end_date
FROM
    marsdb.marsdb_DISPLAY_MAPPING_vw D
        INNER JOIN
    marsdb.marsdb_INDEPENDENT_DISPLAY_vw I ON d.project_id = i.project_id and D.INDEPENDENT_DISPLAY_ID = I.INDEPENDENT_DISPLAY_ID
        INNER JOIN
    marsdb.marsdb_CONDITIONAL_DISPLAY_vw C ON d.project_id = i.project_id and D.CONDITIONAL_DISPLAY_ID = C.CONDITIONAL_DISPLAY_ID
WHERE
    I.SELECTION_VALUE IS NOT NULL
        AND C.SELECTION_VALUE IS NOT NULL
        AND D.EFFECTIVE_END_DATE IS NULL
    and d.project_id = 118
    and upper(i.ui_independent_display_field) like '%PROGR%'
    and upper(c.conditional_display_field) like '%CONTACT%REASON%'
    and nvl(d.effective_end_date,'9999-01-01') > d.effective_start_date
    ;
