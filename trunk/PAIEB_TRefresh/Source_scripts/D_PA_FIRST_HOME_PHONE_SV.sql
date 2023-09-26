CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PA_FIRST_HOME_PHONE_SV AS
SELECT COALESCE(p.phon_id, ac.case_id*-1) as phon_id
        ,ac.case_id
        ,TO_NUMBER(p.phon_area_code||p.phon_phone_number) phone_number
FROM app_case_link ac
LEFT JOIN phone_number p ON (ac.case_id = p.phon_case_id)
                          AND phon_type_cd = 'CH'
                          AND phon_case_id IS NOT NULL
                          AND end_ndt >= TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss'));
