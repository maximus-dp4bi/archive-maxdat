INSERT INTO tn_coverkids_exception(application_id,client_id,case_id,effective_date,letter_id,directive,exception_comments,create_date,created_by)
SELECT l.reference_id
,l.client_id
,s.letter_case_id
,s.response_due_date
,s.letter_id
,'TERMINATE'
,'Members were added as exceptions since the state needed them processed while the CK logic is being analyzed.TNERPS-5162'
,sysdate
,user
FROM letters_stg s
join letter_request_link_stg l on s.letter_id = l.lmreq_id
and l.reference_id in(879615,
877386,
906482,
880616,
891566,
914996,
912206,
899113,
880058,
875104,
880672,
875223)
and s.letter_status_cd = 'MAIL'
and s.letter_type_cd IN('TN 408')
and letter_create_ts >= to_date('08/28/2018','mm/dd/yyyy')
;


COMMIT;