
alter session set current_schema = MAXDAT;

alter table tn_coverkids_Exception
add (exclude_flag varchar2(1) default 'N');


INSERT INTO tn_coverkids_exception(application_id,client_id,case_id,effective_date,letter_id,directive,exception_comments,exclude_flag,create_date,created_by)
select application_id,client_id,case_id,to_date(effective_date,'yyyymmdd'),letter_id,directive,'Members that need to be excluded because COB was established after TN 408. TNERPS-5162/5151','Y',sysdate,user
from (
 SELECT application_id
         ,app_individual_id
         ,client_id
         ,case_id
         ,household_id
         ,CASE WHEN directive = 'START' THEN effective_date ELSE TO_CHAR(response_due_date,'YYYYMMDD') END effective_date
         ,letter_mailed_date
         ,age_19
         ,directive
         ,gender_m
         ,in_yes
         ,in_no
         ,in_start_directive
         ,pend_ck_found
         ,letter_update_ts         
         ,first_name
         ,last_name
         ,middle_name
         ,suffix
         ,dob
         ,ssn
         ,gender 
         ,FLOOR(months_between(COALESCE(CASE WHEN directive = 'START' THEN response_due_date + 1 ELSE TRUNC(sysdate) END,TRUNC(sysdate)),clnt_dob)/12) clnt_age
         ,letter_id
  FROM(SELECT ah.application_id
           ,ai.app_individual_id
           ,ai.client_id      
           ,cls.case_id
           ,clnt.supplemental_nbr household_id              
           ,s.effective_date
           ,s.letter_mailed_date
           ,19 age_19       
           ,CASE WHEN letter_type_cd IN('TN 408ftp', 'TN 411') AND  --ah.status_cd = 'INPROCESS' AND                 
             EXISTS(SELECT 1 
                  FROM app_event_log_stg av
                    JOIN app_individual_stg ai ON av.application_id = ai.application_id AND applicant_ind = 1
                    JOIN doc_link_stg dl ON ai.client_id = dl.client_id
                    JOIN  document_stg d ON dl.document_id = d.document_id
                    JOIN document_set_stg ds ON d.document_set_id = ds.document_set_id    
                  WHERE ah.application_id = av.application_id
                  AND link_type_cd = 'APPLICATION'
                  AND app_event_cd = 'PEND_CK'
                  AND TRUNC(av.create_ts) = TRUNC(dl.create_ts)
                  AND ((TRUNC(ds.received_date) >= s.letter_mailed_date AND TRUNC(ds.received_date) <= response_due_date)
                     OR (TRUNC(ds.received_date) < s.letter_mailed_date AND TRUNC(dl.create_ts) >= s.letter_mailed_date))
                  ) THEN 'START' ELSE 'TERMINATE' END directive 
           ,'M' gender_m
           ,'Y' in_yes
           ,'N' in_no
           ,'START' in_start_directive
           ,CASE WHEN letter_type_cd IN('TN 408ftp', 'TN 411') AND
              EXISTS(SELECT 1 
                     FROM app_event_log_stg av
                       JOIN app_individual_stg ai ON av.application_id = ai.application_id AND applicant_ind = 1
                       JOIN doc_link_stg dl ON ai.client_id = dl.client_id
                       JOIN  document_stg d ON dl.document_id = d.document_id
                       JOIN document_set_stg ds ON d.document_set_id = ds.document_set_id    
                     WHERE ah.application_id = av.application_id
                     AND link_type_cd = 'APPLICATION'
                     AND app_event_cd = 'PEND_CK'
                     AND TRUNC(av.create_ts) = TRUNC(dl.create_ts)
                     AND TRUNC(av.create_ts) >= letter_requested_on AND TRUNC(av.create_ts) <= s.letter_mailed_date) THEN 'Y' ELSE 'N' END pend_ck_found       
           ,s.letter_update_ts      
           ,s.response_due_date
           ,clnt.clnt_fname first_name
           ,clnt.clnt_lname last_name
           ,clnt.clnt_mi middle_name
           ,clnt.suffix
           ,TO_CHAR(clnt.clnt_dob,'YYYYMMDD') dob
           ,clnt.clnt_ssn ssn
           ,COALESCE(clnt.clnt_gender_cd,'U') gender 
           ,clnt.clnt_dob
           ,letter_id
        FROM app_header_stg ah
          INNER JOIN app_individual_stg ai
            ON ah.application_id = ai.application_id
          INNER JOIN app_case_link_stg cls
            ON ah.application_id = cls.application_id
          LEFT JOIN app_elig_outcome_stg ae
            ON ah.application_id = ae.application_id
            AND ai.app_individual_id = ae.app_individual_id
          INNER JOIN client_stg clnt 
            ON ai.client_id = clnt.client_id
          INNER JOIN (SELECT *
               FROM (
                 SELECT l.reference_id,letter_update_ts,letter_mailed_date,letter_sent_on,letter_requested_on,letter_type_cd,response_due_date,letter_id,
                        ROW_NUMBER() OVER (PARTITION BY l.reference_id,s.letter_type_cd ORDER BY s.letter_mailed_date,s.letter_id DESC) rn,
                        TO_CHAR(response_due_date + 1 ,'YYYYMMDD' ) effective_date
                 FROM letters_stg s
                   INNER JOIN letter_request_link_stg l ON s.letter_id = l.lmreq_id
                   JOIN corp_etl_control ds ON ds.name = 'COVERKIDS_RPT_START_DATE'
                   WHERE l.reference_type = 'APP_HEADER'
                 AND letter_type_cd IN('TN 411', 'TN 408ftp','TN 408')
                 AND s.letter_request_type IN('L','S')
                 AND s.letter_status_cd = 'MAIL'
                 AND s.letter_update_ts >= TO_DATE(ds.value,'YYYY/MM/DD HH24:MI:SS')-75)
               WHERE rn = 1) s ON ah.application_id = s.reference_id

        WHERE 1=1
        AND clnt.supplemental_nbr IS NOT NULL -- CK members denied for Coverkids but approved for other programs 
        AND (ae.program_cd != 'CHIP' OR ae.program_cd IS NULL)
        AND NOT EXISTS(SELECT 1 FROM etl_e_daily_accent_staging_stg das WHERE das.transaction_cd = 'A' AND das.process_ts IS NOT NULL
                       AND das.application_id = ah.application_id
                       AND TRUNC(das.process_ts) >= TRUNC(s.letter_update_ts) )  
        )       
 WHERE ( --(pend_ck_found = 'N' AND directive = 'TERMINATE') OR 
   (directive = 'START' AND application_id  IN (865143	,
865159	,
865536	,
865909	,
866664	,
866754	,
867267	,
867347	,
867394	,
867400	,
867432	,
867578	,
867623	,
867767	,
867933	,
868191	,
869495	,
869710	,
869796	,
869811	,
869985	,
870608	,
870743	,
871585	,
871690	,
871907	,
872068	,
872233	,
872595	,
872745	,
873410	,
873493	,
873582	,
873950	,
874248	,
874688	,
874918	,
874943	,
875811	,
876305	,
876375	,
876378	,
876844	,
876864	,
876897	,
876916	,
877153	,
878077	,
878245	,
878463	,
878505	,
878544	,
878785	,
878919	,
879123	,
879131	,
879394	,
879856	,
880298	,
880473	,
880497	,
881111	,
881372	,
881404	,
882062	,
882179	,
882331	,
882722	,
882901	,
883038	,
883539	,
883602	,
883802	,
884090	,
884349	,
884391	,
884837	,
885244	,
885319	,
885465	,
885576	,
885688	,
886194	,
886728	,
887420	,
887599	,
888408	,
889057	,
889448	,
889535	,
889595	,
889877	,
890042	,
890703	,
890740	,
891058	,
891110	,
891128	,
891528	,
891784	,
892256	,
892496	,
892635	,
892746	,
892780	,
892881	,
893492	,
893800	,
893931	,
894376	,
894380	,
895317	,
895463	,
896014	,
896337	,
897549	,
897854	,
898035	,
898255	,
898387	,
898612	,
898920	,
899355	,
899709	,
899965	,
900096	,
900184	,
900746	,
900834	,
900900	,
900979	,
901153	,
901265	,
901375	,
901482	,
901613	,
902114	,
902655	,
903031	,
903314	,
903654	,
903853	,
904124	,
904173	,
904456	,
904852	,
905150	,
905477	,
905811	,
905965	,
906061	,
906390	,
906841	,
907847	,
908091	,
908192	,
908588	,
908683	,
909317	,
909461	,
909676	,
909742	,
909868	,
910087	,
910248	,
910456	,
910894	,
911492	,
912061	,
912396	,
912581	,
912750	,
912806	,
914452	,
916297	,
916350	,
916784	,
917043	,
917097	,
917474	,
917666	,
917724	,
918068	,
918101	,
918120	,
918241	,
918284	,
918457	,
918575	,
918832	,
919246	,
919284	,
919430	,
920027	,
920093	,
920799	,
920898	,
921314	,
921379	,
921503	,
972023	,
972229	,
1151373	,
1151578	,
1151911	,
1152245	,
1153868	,
1244671	,
1245175	,
870035
	) ) )  ) appr
where NOT EXISTS(SELECT 1 FROM coverkids_approval_stg ck WHERE ck.application_id = appr.application_id AND ck.letter_mailed_date = appr.letter_mailed_date AND ck.directive = appr.directive AND cumulative_ind = 'N')
and not exists(select 1 from tn_coverkids_exception t where appr.application_id = t.application_id and t.exclude_flag = 'Y');

commit;