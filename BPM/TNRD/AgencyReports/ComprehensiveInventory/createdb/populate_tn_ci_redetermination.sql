--pop app
 DECLARE  
  CURSOR temp_cur IS
 SELECT clnt_fname first_name
      ,clnt_mi middle_name
      ,clnt_lname last_name
      ,clnt_dob dob
      ,clnt_ssn ssn     
      ,DECODE(clnt_gender_cd, 'M','Male','F','Female',null) gender 
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN clnt_generic_field1_date ELSE NULL END POOL_FILE_SELECT_DATE
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN TO_CHAR(clnt_generic_field1_date,'YYYYMMDD') ELSE NULL END MED_RFI_SELECTION_DATE      
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN 
        CASE WHEN clnt_generic_field8_txt IS NOT NULL THEN
         (SELECT value
          FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
          WHERE cc.client_id =  cl.client_id 
          AND cc.cscl_adlk_id != '00'
          AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                         WHERE cc.client_id = cc1.client_id
                         AND cc1.cscl_adlk_id != '00'))||' '||clnt_generic_field8_txt 
        ELSE (SELECT subprogram_codes
              FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
              WHERE cc.client_id =  cl.client_id 
              AND cc.cscl_adlk_id != '00'
              AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                             WHERE cc.client_id = cc1.client_id
                             AND cc1.cscl_adlk_id != '00')) END 
       ELSE NULL END previous_aid_category
      ,'Self' relationship_person1
      ,CASE WHEN cl.supplemental_nbr IS NOT NULL THEN clnt_generic_field1_date ELSE NULL END CK_POOL_FILE_SELECTION_DATE
      ,ah.application_id
      ,ah.status_date
      ,ah.app_form_cd
      ,ah.status_cd
      ,CASE WHEN ah.ref_value_1 = '1' THEN 'Y' ELSE 'N' END cob_indicator
      ,ai.app_individual_id
      ,cl.client_id
      ,cl.clnt_cin rid
      ,cl.case_id
      ,cl.case_cin
      ,ae.elig_outcome_cd
      ,ae.elig_outcome_reason_cd
      ,ae.program_cd
      ,ae.program_subtype_cd new_aid_category
      ,cl.supplemental_nbr
      ,CASE WHEN EXISTS(SELECT 1 FROM etl_l_app_renewal r WHERE r.matched_client_id = cl.clnt_client_id) THEN 'Y' ELSE 'N' END in_rfi_yn
FROM 
 app_header_stg ah
 JOIN app_individual_stg ai on ah.application_id = ai.application_id and ai.applicant_ind = 1
 JOIN client_stg cl  on ai.client_id = cl.client_id
 LEFT JOIN app_elig_outcome_stg ae on ah.application_id = ae.application_id
WHERE ah.application_id >= 320 
 AND ah.application_id != 618390
 and not exists(select 1 from tn_ci_redetermination ci where ah.application_id = ci.application_id);

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         INSERT INTO tn_ci_redetermination(APPLICATION_ID,	CLIENT_ID,	CASE_ID,	APP_INDIVIDUAL_ID,	MEDICAID_RFI_SELECTION_DATE
                                          ,RID, SUPPLEMENTAL_NBR,	CASE_CIN,	FIRST_NAME,	MIDDLE_NAME,	LAST_NAME,	GENDER,	DATE_OF_BIRTH,	SSN	
                                         ,PREVIOUS_AID_CATEGORY,	NEW_AID_CATEGORY,APP_FORM_CD,STATUS_DATE,PROGRAM_CD,ELIG_OUTCOME_CD , ELIG_OUTCOME_REASON_CD
                                        ,COB_INDICATOR,MAXE_ATS_APPLICATION_STATUS,RELATIONSHIP_PERSON1)
         VALUES( temp_tab(indx).APPLICATION_ID,	temp_tab(indx).CLIENT_ID,	temp_tab(indx).CASE_ID,	temp_tab(indx).APP_INDIVIDUAL_ID,	temp_tab(indx).MED_RFI_SELECTION_DATE
                ,temp_tab(indx).RID, temp_tab(indx).SUPPLEMENTAL_NBR,	temp_tab(indx).CASE_CIN,	temp_tab(indx).FIRST_NAME,	temp_tab(indx).MIDDLE_NAME,	temp_tab(indx).LAST_NAME
                ,temp_tab(indx).GENDER, temp_tab(indx).dob,	temp_tab(indx).SSN	
                ,temp_tab(indx).PREVIOUS_AID_CATEGORY, temp_tab(indx).NEW_AID_CATEGORY,temp_tab(indx).APP_FORM_CD,temp_tab(indx).STATUS_DATE,temp_tab(indx).PROGRAM_CD
                ,temp_tab(indx).ELIG_OUTCOME_CD,temp_tab(indx).ELIG_OUTCOME_REASON_CD,temp_tab(indx).COB_INDICATOR,temp_tab(indx).status_cd
                ,temp_tab(indx).RELATIONSHIP_PERSON1);                                        

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop packet
DECLARE  
  CURSOR temp_cur IS
   SELECT lr.lmreq_id, lr.letter_type,ci.application_id
   FROM tn_ci_redetermination ci
     join (
     SELECT letter_id lmreq_id,letter_type, reference_id application_id, letter_case_id,ROW_NUMBER() OVER(PARTITION BY letter_case_id ORDER BY letter_create_ts) rn
     FROM letters_stg lr
       JOIN letter_request_link_stg ls ON lr.letter_id = ls.lmreq_id AND ls.reference_type = 'APP_HEADER'
     WHERE lr.letter_type_cd IN('TN 401','TN 401a')
     AND lr.letter_status_cd = 'MAIL'
     AND lr.letter_request_type IN('L','S')
     ) lr ON ci.case_id = lr.letter_case_id
  WHERE rn = 1
  and ci.renewal_packet_id is null;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET RENEWAL_PACKET_ID = temp_tab(indx).lmreq_id
             ,RENEWAL_PACKET_TYPE = temp_tab(indx).letter_type
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop auth rep
DECLARE  
  CURSOR temp_cur IS 
  
  SELECT ar.authorized_representative,ci.application_id
  FROM tn_ci_redetermination ci
    join (SELECT ac_case_id,ac_first_name||' '||ac_last_name authorized_representative
             ,ROW_NUMBER() OVER (PARTITION BY ac_case_id ORDER BY authorized_contact_id DESC) rn
      FROM authorized_contact_stg      
      WHERE ac_type_code = 'AUTH_REP'
      AND ac_status_code != 'V'
      AND ac_end_date IS NULL) ar on ci.case_id = ar.ac_case_id
WHERE rn = 1;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET AUTHORIZED_REPRESENTATIVE = temp_tab(indx).authorized_representative
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop app receipt
DECLARE  
  CURSOR temp_cur IS 
  
 SELECT ap.received_date,
       ap.scan_date,    
       ap.method_of_receipt,
       ci.application_id
FROM tn_ci_redetermination ci
 join (       
SELECT s.received_date,ds.report_label method_of_receipt, case_id,link_ref_id application_id,d.scan_date,ROW_NUMBER() OVER (PARTITION BY case_id ORDER BY s.received_date) rn
FROM document_stg d 
 INNER JOIN document_set_stg s 
   ON d.document_set_id = s.document_set_id 
 INNER JOIN doc_link_stg dl 
   ON d.document_id = dl.document_id  
 INNER JOIN document_source_lkup ds
   ON s.doc_source_cd = ds.value 
WHERE doc_type_cd = 'APPLICATION' 
AND link_type_cd = 'APPLICATION' 
AND NOT EXISTS(SELECT 1 FROM app_event_log_stg ae WHERE dl.link_ref_id = ae.application_id AND ae.app_event_cd ='APPLICANT_RELINKED' AND ae.create_ts >= dl.create_ts)) ap on ci.case_id = ap.case_id 
WHERE rn = 1
;


  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET method_of_receipt = temp_tab(indx).method_of_receipt
             ,scan_date = temp_tab(indx).scan_date
             ,RENEWAL_RECEIPT_DATE = temp_tab(indx).received_date
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

-- pop latest app receipt
DECLARE  
  CURSOR temp_cur IS 
  
 SELECT ap.received_date,       
       ci.application_id
FROM tn_ci_redetermination ci
 join (       
SELECT s.received_date, case_id,link_ref_id application_id,ROW_NUMBER() OVER (PARTITION BY case_id ORDER BY s.received_date DESC) rn
FROM document_stg d 
 INNER JOIN document_set_stg s 
   ON d.document_set_id = s.document_set_id 
 INNER JOIN doc_link_stg dl 
   ON d.document_id = dl.document_id    
WHERE doc_type_cd = 'APPLICATION' 
AND link_type_cd = 'APPLICATION' 
AND NOT EXISTS(SELECT 1 FROM app_event_log_stg ae WHERE dl.link_ref_id = ae.application_id AND ae.app_event_cd ='APPLICANT_RELINKED' AND ae.create_ts >= dl.create_ts)) ap on ci.case_id = ap.case_id 
WHERE rn = 1;


  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET LATEST_APP_RECEIPT_DATE = temp_tab(indx).received_date
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

-- pop latest MI doc receipt
DECLARE  
  CURSOR temp_cur IS 
  
 SELECT ap.received_date,       
       ci.application_id
FROM tn_ci_redetermination ci
 join (       
SELECT s.received_date,dl.link_ref_id application_id,ROW_NUMBER() OVER (PARTITION BY dl.link_ref_id ORDER BY s.received_date DESC) rn
FROM document_stg d 
 INNER JOIN document_set_stg s 
   ON d.document_set_id = s.document_set_id 
 INNER JOIN doc_link_stg dl 
   ON d.document_id = dl.document_id    
WHERE 1=1
AND doc_type_cd IN('APPLICATION' ,'INSURANCE_PROOF','INCOME_PROOF','CITIZENSHIP_PROOF')
AND link_type_cd = 'APPLICATION' 
AND NOT EXISTS(SELECT 1 FROM app_event_log_stg ae WHERE dl.link_ref_id = ae.application_id AND ae.app_event_cd ='APPLICANT_RELINKED' AND ae.create_ts >= dl.create_ts)) ap on ci.application_id = ap.application_id 
WHERE rn = 1;



  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET LATEST_DOC_RECEIPT_DATE = temp_tab(indx).received_date
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
--pop mmis status
DECLARE  
  CURSOR temp_cur IS 
  
 SELECT ci.application_id, process_ts last_status_update_date,mmis_app_status status_code
FROM tn_ci_redetermination ci join etl_e_app_status_staging_stg ss on ci.application_id = ss.application_id
WHERE process_ts = (SELECT MAX(process_ts)
                    FROM etl_e_app_status_staging_stg ss1 
                    WHERE ss1.application_id = ss.application_id);



  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET LAST_STATUS_SENT_TO_MMIS = temp_tab(indx).last_status_update_date
             ,STATUS_CODE_SENT_TO_MMIS = temp_tab(indx).status_code
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
--pop accent date
DECLARE  
  CURSOR temp_cur IS 
SELECT das.accent_processed_date,ci.application_id
FROM  tn_ci_redetermination ci join(
       SELECT process_ts accent_processed_date, application_id,
              ROW_NUMBER() OVER (PARTITION BY application_id ORDER BY create_ts DESC,etl_e_daily_accent_staging_id DESC) rn                      
       FROM etl_e_daily_accent_staging_stg
       WHERE transaction_cd = 'A'
       AND process_ts IS NOT NULL
       ) das on ci.application_id = das.application_id
WHERE rn = 1;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET ACCENT_PROCESSED_DATE = temp_tab(indx).accent_processed_date     
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop res addr

DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id, ad.*
FROM tn_ci_redetermination ci
 join (SELECT ad.addr_street_1 as res_street_address1
      ,ad.addr_street_2 as res_street_address2
      ,ad.addr_city as res_city
      ,ad.addr_state_cd as res_state
      ,ad.addr_zip as res_zip_code
      ,ec.report_label res_county
      ,ad.addr_id res_addr_id
      ,ad.addr_case_id
      ,ROW_NUMBER() OVER (PARTITION BY ad.addr_case_id ORDER BY DECODE(ad.addr_type_cd,'MR',1,2)) rn      
      FROM  address_stg ad 
   LEFT OUTER JOIN county_lkup ec    
    ON ad.addr_ctlk_id = ec.value  
WHERE ad.addr_type_cd IN('RS','MR')
AND ad.addr_end_date IS NULL ) ad on ci.case_id = ad.addr_case_id
WHERE rn = 1;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET HOME_ADDRESS1 = temp_tab(indx).res_street_address1
            ,HOME_ADDRESS2 = temp_tab(indx).res_street_address2
            ,HOME_ADDRESS_CITY	= temp_tab(indx).res_city
            ,HOME_ADDRESS_STATE	=temp_tab(indx).res_state
            ,HOME_ADDRESS_ZIP	=temp_tab(indx).res_zip_code
            ,HOME_ADDRESS_COUNTY	=temp_tab(indx).res_county
            ,RES_ADDR_ID = temp_tab(indx).res_addr_id
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop mail addr

DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id, ad.*
FROM tn_ci_redetermination ci
 join (SELECT ad.addr_street_1 as ml_street_address1
      ,ad.addr_street_2 as ml_street_address2
      ,ad.addr_city as ml_city
      ,ad.addr_state_cd as ml_state
      ,ad.addr_zip as ml_zip_code
      ,ec.report_label ml_county
      ,ad.addr_id mail_addr_id
      ,ad.addr_case_id
      ,ROW_NUMBER() OVER (PARTITION BY ad.addr_case_id ORDER BY DECODE(ad.addr_type_cd,'ML',1,2)) rn      
      FROM  address_stg ad 
   LEFT OUTER JOIN county_lkup ec    
    ON ad.addr_ctlk_id = ec.value  
WHERE ad.addr_type_cd IN('ML','MM')
AND ad.addr_end_date IS NULL ) ad on ci.case_id = ad.addr_case_id
WHERE rn = 1;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 	MAIL_ADDRESS1	= temp_tab(indx).ml_street_address1
              ,	MAIL_ADDRESS2	= temp_tab(indx).ml_street_address2
              ,	MAIL_ADDRESS_CITY	= temp_tab(indx).ml_city
              ,	MAIL_ADDRESS_STATE	= temp_tab(indx).ml_state
              ,	MAIL_ADDRESS_ZIP	= temp_tab(indx).ml_zip_code
              ,	MAIL_ADDRESS_COUNTY	= temp_tab(indx).ml_county
              ,MAIL_ADDR_ID = temp_tab(indx).mail_addr_id
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

-- pop mi

DECLARE  
  CURSOR temp_cur IS 
SELECT ah.application_id
       ,MAX(satisfied_date) verification_return_date
       ,(SELECT CASE WHEN MAX(satisfied_date) IS NOT NULL THEN 'Y' ELSE 'N' END FROM app_missing_info_stg i 
         WHERE satisfied_reason_cd = 'work_num' AND i.application_id = ah.application_id) work_num_verified
FROM tn_ci_redetermination ah
  JOIN app_missing_info_stg m
   ON ah.application_id = m.application_id   
GROUP BY ah.application_id;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 	WORK_NUMBER_VERIFIED =  temp_tab(indx).work_num_verified
              ,VERIFICATION_RETURN_DATE =  temp_tab(indx).verification_return_date
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop task
DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id,TRUNC(create_ts) date_hcfa_referral, t.task_name referral_task_type
FROM tn_ci_redetermination ci
  JOIN step_instance_stg s on ci.application_id = s.ref_id
 INNER JOIN d_task_types t
   ON s.step_definition_id = t.task_type_id
WHERE task_name IN('Voluntary Terminations','LTSS+','Other Non-MAGI+','MSP Only','Medically Eligible Review')
AND ref_type = 'APP_HEADER'
AND step_instance_id = (SELECT MAX(step_instance_id)
                        FROM step_instance_stg si
						 INNER JOIN d_task_types ti
						   ON si.step_definition_id = ti.task_type_id
                        WHERE s.ref_type = si.ref_type
                        AND s.ref_id = si.ref_id					                       
                        AND ti.task_name IN('Voluntary Terminations','LTSS+','Other Non-MAGI+','MSP Only','Medically Eligible Review')
						);

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 	REFERRAL_TASK_TYPE =  temp_tab(indx).referral_task_type
              ,DATE_HCFA_REFERRAL =  temp_tab(indx).date_hcfa_referral
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop elig end
DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id,MAX(response_due_date) elig_end_date
FROM tn_ci_redetermination ci
  JOIN letter_request_link_stg ls ON ci.application_id =ls.reference_id
  JOIN letters_stg lr ON lr.letter_id = ls.lmreq_id
WHERE lr.letter_type_cd IN('TN 411', 'TN 408', 'TN 408ftp') 
AND lr.letter_status_cd = 'MAIL'
AND ls.reference_type = 'APP_HEADER' 
GROUP BY ci.application_id;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 	ELIGIBILITY_END_DATE =  temp_tab(indx).elig_end_date            
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--pop letters
DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id
     ,cl.TN412_mail_date
	   ,cl.TN401_mail_date
	   ,cl.TN401a_mail_date
	   ,cl.TN402_mail_date
	   ,cl.TN403_mail_date
	   ,cl.TN404_mail_date
	   ,cl.TN405_mail_date
	   ,cl.TN405a_mail_date
	   ,cl.TN406a_mail_date
	   ,cl.TN406b_mail_date
	   ,cl.TN406c_mail_date
	   ,cl.TN406d_mail_date
	   ,cl.TN406e_mail_date
	   ,cl.TN406f_mail_date
	   ,cl.TN406g_mail_date
	   ,cl.TN406h_mail_date
	   ,cl.TN406j_mail_date
	   ,cl.TN406i_mail_date
	   ,cl.TN406l_mail_date
	   ,cl.TN406m_mail_date
	   ,cl.TN406n_mail_date
     ,cl.TN406o_mail_date
     ,cl.TN407_mail_date
     ,cl.TN408_mail_date
      ,cl.TN409_mail_date
       ,cl.TN411_mail_date
       ,cl.TN408ftp_mail_date
       ,cl.TN409ftp_mail_date  
       ,cl.TN403qmb_mail_date  
       ,cl.TN410msp_mail_date 
       ,cl.TN401R_last_mail_date
       ,cl.TN401aR_last_mail_date
       ,cl.TN413_mail_date
       ,cl.TN413a_mail_date
       ,cl.TN401R_initial_mail_date
       ,cl.TN401aR_initial_mail_date       
       ,CASE WHEN cl.TN405_mail_date IS NOT NULL OR cl.TN405a_mail_date IS NOT NULL OR cl.TN402_mail_date IS NOT NULL OR
                  cl.TN403_mail_date IS NOT NULL OR cl.TN404_mail_date IS NOT NULL OR cl.TN403qmb_mail_date IS NOT NULL
                  or cl.TN413_mail_date IS NOT NULL OR cl.TN413a_mail_date IS NOT NULL THEN 'Y' ELSE 'N' END approval_ltr_mailed
       ,CASE WHEN cl.TN408_mail_date IS NOT NULL OR cl.TN409_mail_date IS NOT NULL OR cl.TN410msp_mail_date IS NOT NULL OR
                  cl.TN408ftp_mail_date IS NOT NULL OR cl.TN409ftp_mail_date IS NOT NULL OR cl.TN411_mail_date IS NOT NULL THEN 'Y' ELSE 'N' END denial_ltr_mailed      
FROM tn_ci_redetermination ci
join (
  SELECT 
       ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 412') TN412_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 401') TN401_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 401a') TN401a_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 401R') TN401R_initial_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 401aR') TN401aR_initial_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 402') TN402_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 403') TN403_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 404') TN404_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 405') TN405_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 405a') TN405a_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406a') TN406a_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406b') TN406b_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406c') TN406c_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406d') TN406d_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406e') TN406e_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406f') TN406f_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406g') TN406g_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406h') TN406h_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406j') TN406j_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406i') TN406i_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406l') TN406l_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406m') TN406m_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406n') TN406n_mail_date
	   ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 406o') TN406o_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 407') TN407_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 408') TN408_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 409') TN409_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 411') TN411_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 408ftp') TN408ftp_mail_date
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 409ftp') TN409ftp_mail_date  
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 403qmb') TN403qmb_mail_date  
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 410msp') TN410msp_mail_date  
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 413') TN413_mail_date  
       ,ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 413a') TN413a_mail_date   
       ,(SELECT MAX(letter_mailed_date) FROM letters_stg lr WHERE letter_type_cd = 'TN 401R' AND lr.letter_case_id = acl.case_id AND lr.letter_status_cd = 'MAIL') TN401R_last_mail_date
       ,(SELECT MAX(letter_mailed_date) FROM letters_stg lr WHERE letter_type_cd = 'TN 401aR' AND lr.letter_case_id = acl.case_id AND lr.letter_status_cd = 'MAIL') TN401aR_last_mail_date
       ,acl.application_id
  FROM app_case_link_stg acl
   ) cl on ci.application_id = cl.application_id;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 		TN412_MAIL_DATE	=	temp_tab(indx).TN412_MAIL_DATE
,	TN401_MAIL_DATE	=	temp_tab(indx).TN401_MAIL_DATE
,	TN401A_MAIL_DATE	=	temp_tab(indx).TN401A_MAIL_DATE
,	TN402_MAIL_DATE	=	temp_tab(indx).TN402_MAIL_DATE
,	TN403_MAIL_DATE	=	temp_tab(indx).TN403_MAIL_DATE
,	TN403QMB_MAIL_DATE	=	temp_tab(indx).TN403QMB_MAIL_DATE
,	TN404_MAIL_DATE	=	temp_tab(indx).TN404_MAIL_DATE
,	TN405_MAIL_DATE	=	temp_tab(indx).TN405_MAIL_DATE
,	TN405A_MAIL_DATE	=	temp_tab(indx).TN405A_MAIL_DATE
,	TN406A_MAIL_DATE	=	temp_tab(indx).TN406A_MAIL_DATE
,	TN406B_MAIL_DATE	=	temp_tab(indx).TN406B_MAIL_DATE
,	TN406C_MAIL_DATE	=	temp_tab(indx).TN406C_MAIL_DATE
,	TN406D_MAIL_DATE	=	temp_tab(indx).TN406D_MAIL_DATE
,	TN406E_MAIL_DATE	=	temp_tab(indx).TN406E_MAIL_DATE
,	TN406F_MAIL_DATE	=	temp_tab(indx).TN406F_MAIL_DATE
,	TN406G_MAIL_DATE	=	temp_tab(indx).TN406G_MAIL_DATE
,	TN406H_MAIL_DATE	=	temp_tab(indx).TN406H_MAIL_DATE
,	TN406I_MAIL_DATE	=	temp_tab(indx).TN406I_MAIL_DATE
,	TN406J_MAIL_DATE	=	temp_tab(indx).TN406J_MAIL_DATE
,	TN406L_MAIL_DATE	=	temp_tab(indx).TN406L_MAIL_DATE
,	TN406M_MAIL_DATE	=	temp_tab(indx).TN406M_MAIL_DATE
,	TN406N_MAIL_DATE	=	temp_tab(indx).TN406N_MAIL_DATE
,	TN406O_MAIL_DATE	=	temp_tab(indx).TN406O_MAIL_DATE
,	TN407_MAIL_DATE	=	temp_tab(indx).TN407_MAIL_DATE
,	TN408_MAIL_DATE	=	temp_tab(indx).TN408_MAIL_DATE
,	TN409_MAIL_DATE	=	temp_tab(indx).TN409_MAIL_DATE
,	TN401R_INITIAL_MAIL_DATE	=	temp_tab(indx).TN401R_INITIAL_MAIL_DATE
,	TN401AR_INITIAL_MAIL_DATE	=	temp_tab(indx).TN401AR_INITIAL_MAIL_DATE
,	TN401R_LAST_MAIL_DATE	=	temp_tab(indx).TN401R_LAST_MAIL_DATE
,	TN401AR_LAST_MAIL_DATE	=	temp_tab(indx).TN401AR_LAST_MAIL_DATE
,	TN411_MAIL_DATE	=	temp_tab(indx).TN411_MAIL_DATE
,	TN408FTP_MAIL_DATE	=	temp_tab(indx).TN408FTP_MAIL_DATE
,	TN409FTP_MAIL_DATE	=	temp_tab(indx).TN409FTP_MAIL_DATE
,	TN410MSP_MAIL_DATE	=	temp_tab(indx).TN410MSP_MAIL_DATE
,	TN413_MAIL_DATE	=	temp_tab(indx).TN413_MAIL_DATE
,	TN413A_MAIL_DATE	=	temp_tab(indx).TN413A_MAIL_DATE
,APPROVAL_LTR_MAILED = temp_tab(indx).APPROVAL_LTR_MAILED
,DENIAL_LTR_MAILED = temp_tab(indx).DENIAL_LTR_MAILED          
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS 
    SELECT m.household_size
           ,m.household_income
           ,m.citizen_ind us_citizen_indicator
           ,m.eligible_immigrant_attest eligible_immigrant_alleged
           ,m.other_coverage
           ,m.parent_ct_category parent_caretaker_indicator
           ,m.residency_verified
           ,CASE WHEN medicaid_eligible = 'Y' THEN 'Medicaid'
             WHEN chip_eligible = 'Y' THEN 'CHIP'
             ELSE 'None' END mitc_result_redetermination
           ,m.student_indicator
           ,m.pregnancy pregnancy_indicator
           ,ci.application_id
    FROM tn_ci_redetermination ci
      JOIN magi_service_audit_log_stg m ON ci.application_id = m.application_id
    WHERE magi_log_id = (SELECT MAX(magi_log_id)
                         FROM magi_service_audit_log_stg m1 
                         WHERE m1.application_id = m.application_id
                         and m1.magi_transaction_data_id is not null)
                             ;


  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 	HOUSEHOLD_SIZE = temp_tab(indx).HOUSEHOLD_SIZE
              ,HOUSEHOLD_INCOME = temp_tab(indx).HOUSEHOLD_INCOME
              ,US_CITIZEN_INDICATOR = temp_tab(indx).US_CITIZEN_INDICATOR
              ,ELIGIBLE_IMMIGRANT_ALLEGED	= temp_tab(indx).ELIGIBLE_IMMIGRANT_ALLEGED
              ,OTHER_COVERAGE = temp_tab(indx).OTHER_COVERAGE
              ,PARENT_CARETAKER_INDICATOR = temp_tab(indx).PARENT_CARETAKER_INDICATOR
              ,RESIDENCY_VERIFIED = temp_tab(indx).RESIDENCY_VERIFIED
              ,MITC_RESULT_REDETERMINATION = temp_tab(indx).MITC_RESULT_REDETERMINATION
              ,STUDENT_INDICATOR = temp_tab(indx).STUDENT_INDICATOR
              ,PREGNANCY_INDICATOR = temp_tab(indx).PREGNANCY_INDICATOR
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS
 SELECT clnt_fname first_name
      ,clnt_mi middle_name
      ,clnt_lname last_name
      ,clnt_dob dob
      ,clnt_ssn ssn     
      ,DECODE(clnt_gender_cd, 'M','Male','F','Female',null) gender 
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN clnt_generic_field1_date ELSE NULL END POOL_FILE_SELECT_DATE
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN TO_CHAR(clnt_generic_field1_date,'YYYYMMDD') ELSE NULL END MED_RFI_SELECTION_DATE      
      ,CASE WHEN cl.supplemental_nbr IS NULL THEN 
        CASE WHEN clnt_generic_field8_txt IS NOT NULL THEN
         (SELECT value
          FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
          WHERE cc.client_id =  cl.client_id 
          AND cc.cscl_adlk_id != '00'
          AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                         WHERE cc.client_id = cc1.client_id
                         AND cc1.cscl_adlk_id != '00'))||' '||clnt_generic_field8_txt 
        ELSE (SELECT subprogram_codes
              FROM case_client_stg cc INNER JOIN aid_category_lkup ea ON cc.cscl_adlk_id = ea.value         
              WHERE cc.client_id =  cl.client_id 
              AND cc.cscl_adlk_id != '00'
              AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                             WHERE cc.client_id = cc1.client_id
                             AND cc1.cscl_adlk_id != '00')) END 
       ELSE NULL END previous_aid_category
      ,'Self' relationship_person1
      ,CASE WHEN cl.supplemental_nbr IS NOT NULL THEN clnt_generic_field1_date ELSE NULL END CK_POOL_FILE_SELECTION_DATE
      ,ah.application_id
      ,ah.status_date
      ,ah.app_form_cd
      ,ah.status_cd
      ,CASE WHEN ah.ref_value_1 = '1' THEN 'Y' ELSE 'N' END cob_indicator
      ,ai.app_individual_id
      ,cl.client_id
      ,cl.clnt_cin rid
      ,cl.case_id
      ,cl.case_cin
      ,ae.elig_outcome_cd
      ,ae.elig_outcome_reason_cd
      ,ae.program_cd
      ,ae.program_subtype_cd new_aid_category
      ,cl.supplemental_nbr
      ,CASE WHEN EXISTS(SELECT 1 FROM etl_l_app_renewal_stg r WHERE r.matched_client_id = cl.client_id) THEN 'Y' ELSE 'N' END in_rfi_yn
FROM tn_ci_redetermination  ci
 JOIN app_header_stg ah on ci.application_id = ah.application_id
 JOIN app_individual_stg ai on ah.application_id = ai.application_id and ai.applicant_ind = 1
 JOIN client_stg cl  on ai.client_id = cl.client_id
 LEFT JOIN app_elig_outcome_stg ae on ah.application_id = ae.application_id
WHERE ah.application_id >= 320 
 AND ah.application_id != 618390
;
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET medicaid_rfi_selection_date =	temp_tab(indx).MED_RFI_SELECTION_DATE
                ,rid = temp_tab(indx).RID
                ,supplemental_nbr = temp_tab(indx).SUPPLEMENTAL_NBR
                ,CASE_CIN =	temp_tab(indx).CASE_CIN
                ,FIRST_NAME	= temp_tab(indx).FIRST_NAME
                ,MIDDLE_NAME =	temp_tab(indx).MIDDLE_NAME
                ,LAST_NAME =	temp_tab(indx).LAST_NAME
                ,GENDER = temp_tab(indx).GENDER
                ,date_of_birth = temp_tab(indx).dob
                ,SSN=	temp_tab(indx).SSN	
                ,PREVIOUS_AID_CATEGORY = temp_tab(indx).PREVIOUS_AID_CATEGORY
                ,NEW_AID_CATEGORY =  temp_tab(indx).NEW_AID_CATEGORY
                ,APP_FORM_CD = temp_tab(indx).APP_FORM_CD
                ,STATUS_DATE = temp_tab(indx).STATUS_DATE
                ,PROGRAM_CD = temp_tab(indx).PROGRAM_CD
                ,ELIG_OUTCOME_CD = temp_tab(indx).ELIG_OUTCOME_CD
                ,ELIG_OUTCOME_REASON_CD = temp_tab(indx).ELIG_OUTCOME_REASON_CD
                ,COB_INDICATOR = temp_tab(indx).COB_INDICATOR
                ,MAXE_ATS_APPLICATION_STATUS = temp_tab(indx).status_cd
                ,RELATIONSHIP_PERSON1 = temp_tab(indx).RELATIONSHIP_PERSON1
                ,CK_POOL_FILE_SELECTION_DATE = temp_tab(indx).CK_POOL_FILE_SELECTION_DATE
                ,in_rfi_yn = temp_tab(indx).in_rfi_yn
                ,POOL_FILE_SELECT_DATE = temp_tab(indx).POOL_FILE_SELECT_DATE
            where application_id =   temp_tab(indx).application_id              ;                                        

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/