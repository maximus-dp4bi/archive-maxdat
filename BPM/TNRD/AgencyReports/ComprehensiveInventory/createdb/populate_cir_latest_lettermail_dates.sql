alter session set current_schema = MAXDAT;

 MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  tn_ci_redetermination s
   USING (
SELECT ci.application_id
   ,TN401_mail_date
   ,TN401a_mail_date
   ,TN401R_initial_mail_date
   ,TN401aR_initial_mail_date
   ,TN401R_last_mail_date
   ,TN401aR_last_mail_date
   ,TN402_mail_date
   ,TN403_mail_date
   ,TN404_mail_date
   ,TN405_mail_date
   ,TN405a_mail_date
   ,TN406a_mail_date
   ,TN406b_mail_date
   ,TN406c_mail_date
   ,TN406d_mail_date
   ,TN406e_mail_date
   ,TN406f_mail_date
   ,TN406g_mail_date
   ,TN406h_mail_date
   ,TN406i_mail_date
   ,TN406j_mail_date
   ,TN406l_mail_date
   ,TN406m_mail_date
   ,TN406n_mail_date
   ,TN406o_mail_date
   ,TN406p_mail_date
   ,TN407_mail_date
   ,TN408_mail_date
   ,TN409_mail_date
   ,TN408ftp_mail_date
   ,TN409ftp_mail_date
   ,TN410msp_mail_date
   ,TN411_mail_date
   ,TN403qmb_mail_date
   ,TN412_mail_date
   ,TN413_mail_date
   ,TN413a_mail_date   
   ,new_TN401_mail_date
   ,new_TN401a_mail_date
   ,new_TN401R_initial_mail_date
   ,new_TN401aR_initial_mail_date
   ,new_TN401R_last_mail_date
   ,new_TN401aR_last_mail_date
   ,new_TN402_mail_date
   ,new_TN403_mail_date
   ,new_TN404_mail_date
   ,new_TN405_mail_date
   ,new_TN405a_mail_date
   ,new_TN406a_mail_date
   ,new_TN406b_mail_date
   ,new_TN406c_mail_date
   ,new_TN406d_mail_date
   ,new_TN406e_mail_date
   ,new_TN406f_mail_date
   ,new_TN406g_mail_date
   ,new_TN406h_mail_date
   ,new_TN406i_mail_date
   ,new_TN406j_mail_date
   ,new_TN406l_mail_date
   ,new_TN406m_mail_date
   ,new_TN406n_mail_date
   ,new_TN406o_mail_date
   ,new_TN406p_mail_date
   ,new_TN407_mail_date
   ,new_TN408_mail_date
   ,new_TN409_mail_date
   ,new_TN408ftp_mail_date
   ,new_TN409ftp_mail_date
   ,new_TN410msp_mail_date
   ,new_TN411_mail_date
   ,new_TN403qmb_mail_date
   ,new_TN412_mail_date
   ,new_TN413_mail_date
   ,new_TN413a_mail_date
   ,new_l_401_401a_date
FROM tn_ci_redetermination ci
JOIN (
SELECT application_id,letter_case_id
   ,MAX(TN401_mail_date) new_TN401_mail_date
   ,MAX(TN401a_mail_date) new_TN401a_mail_date
   ,MAX(TN401R_mail_date) new_TN401R_last_mail_date
   ,MAX(TN401aR_mail_date) new_TN401aR_last_mail_date
   ,MIN(TN401R_mail_date) new_TN401R_initial_mail_date
   ,MIN(TN401aR_mail_date) new_TN401aR_initial_mail_date
   ,MAX(TN402_mail_date) new_TN402_mail_date
   ,MAX(TN403_mail_date) new_TN403_mail_date
   ,MAX(TN404_mail_date) new_TN404_mail_date
   ,MAX(TN405_mail_date) new_TN405_mail_date
   ,MAX(TN405a_mail_date) new_TN405a_mail_date
   ,MAX(TN406a_mail_date) new_TN406a_mail_date
   ,MAX(TN406b_mail_date) new_TN406b_mail_date
   ,MAX(TN406c_mail_date) new_TN406c_mail_date
   ,MAX(TN406d_mail_date) new_TN406d_mail_date
   ,MAX(TN406e_mail_date) new_TN406e_mail_date
   ,MAX(TN406f_mail_date) new_TN406f_mail_date
   ,MAX(TN406g_mail_date) new_TN406g_mail_date
   ,MAX(TN406h_mail_date) new_TN406h_mail_date
   ,MAX(TN406i_mail_date) new_TN406i_mail_date
   ,MAX(TN406j_mail_date) new_TN406j_mail_date
   ,MAX(TN406l_mail_date) new_TN406l_mail_date
   ,MAX(TN406m_mail_date) new_TN406m_mail_date
   ,MAX(TN406n_mail_date) new_TN406n_mail_date
   ,MAX(TN406o_mail_date) new_TN406o_mail_date
   ,MAX(TN406p_mail_date) new_TN406p_mail_date
   ,MAX(TN407_mail_date) new_TN407_mail_date
   ,MAX(TN408_mail_date) new_TN408_mail_date
   ,MAX(TN409_mail_date) new_TN409_mail_date
   ,MAX(TN408ftp_mail_date) new_TN408ftp_mail_date
   ,MAX(TN409ftp_mail_date) new_TN409ftp_mail_date
   ,MAX(TN410msp_mail_date) new_TN410msp_mail_date
   ,MAX(TN411_mail_date) new_TN411_mail_date
   ,MAX(TN403qmb_mail_date) new_TN403qmb_mail_date
   ,MAX(TN412_mail_date) new_TN412_mail_date
   ,MAX(TN413_mail_date) new_TN413_mail_date
   ,MAX(TN413a_mail_date) new_TN413a_mail_date
   --,MAX(renewal_packet_id) new_renewal_packet_id
   ,MAX(l_401_401a_date) new_l_401_401a_date
   --,MAX(renewal_packet_type) new_renewal_packet_type   
FROM (   
SELECT DISTINCT COALESCE(lr.reference_id,cl.application_id) application_id,ls.letter_case_id
  ,CASE WHEN letter_type_cd IN('TN 401','TN 401a') THEN letter_id ELSE NULL END renewal_packet_id
  ,CASE WHEN letter_type_cd IN('TN 401','TN 401a') THEN letter_type ELSE NULL END renewal_packet_type
  ,CASE WHEN letter_type_cd IN('TN 401','TN 401a') AND letter_request_type = 'L' THEN letter_mailed_date ELSE NULL END l_401_401a_date
  ,CASE WHEN letter_type_cd = 'TN 401' THEN letter_mailed_date ELSE NULL END TN401_mail_date
  ,CASE WHEN letter_type_cd = 'TN 401a' THEN letter_mailed_date ELSE NULL END TN401a_mail_date
  ,CASE WHEN letter_type_cd = 'TN 401R' THEN letter_mailed_date ELSE NULL END TN401R_mail_date
  ,CASE WHEN letter_type_cd = 'TN 401aR' THEN letter_mailed_date ELSE NULL END TN401aR_mail_date
  ,CASE WHEN letter_type_cd = 'TN 402' THEN letter_mailed_date ELSE NULL END TN402_mail_date
  ,CASE WHEN letter_type_cd = 'TN 403' THEN letter_mailed_date ELSE NULL END TN403_mail_date
  ,CASE WHEN letter_type_cd = 'TN 404' THEN letter_mailed_date ELSE NULL END TN404_mail_date
  ,CASE WHEN letter_type_cd = 'TN 405' THEN letter_mailed_date ELSE NULL END TN405_mail_date
  ,CASE WHEN letter_type_cd = 'TN 405a' THEN letter_mailed_date ELSE NULL END TN405a_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406a' THEN letter_mailed_date ELSE NULL END TN406a_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406b' THEN letter_mailed_date ELSE NULL END TN406b_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406c' THEN letter_mailed_date ELSE NULL END TN406c_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406d' THEN letter_mailed_date ELSE NULL END TN406d_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406e' THEN letter_mailed_date ELSE NULL END TN406e_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406f' THEN letter_mailed_date ELSE NULL END TN406f_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406g' THEN letter_mailed_date ELSE NULL END TN406g_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406h' THEN letter_mailed_date ELSE NULL END TN406h_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406i' THEN letter_mailed_date ELSE NULL END TN406i_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406j' THEN letter_mailed_date ELSE NULL END TN406j_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406l' THEN letter_mailed_date ELSE NULL END TN406l_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406m' THEN letter_mailed_date ELSE NULL END TN406m_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406n' THEN letter_mailed_date ELSE NULL END TN406n_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406o' THEN letter_mailed_date ELSE NULL END TN406o_mail_date
  ,CASE WHEN letter_type_cd = 'TN 406p' THEN letter_mailed_date ELSE NULL END TN406p_mail_date
  ,CASE WHEN letter_type_cd = 'TN 407' THEN letter_mailed_date ELSE NULL END TN407_mail_date
  ,CASE WHEN letter_type_cd = 'TN 408' THEN letter_mailed_date ELSE NULL END TN408_mail_date
  ,CASE WHEN letter_type_cd = 'TN 409' THEN letter_mailed_date ELSE NULL END TN409_mail_date
  ,CASE WHEN letter_type_cd = 'TN 408ftp' THEN letter_mailed_date ELSE NULL END TN408ftp_mail_date
  ,CASE WHEN letter_type_cd = 'TN 409ftp' THEN letter_mailed_date ELSE NULL END TN409ftp_mail_date
  ,CASE WHEN letter_type_cd = 'TN 410msp' THEN letter_mailed_date ELSE NULL END TN410msp_mail_date
  ,CASE WHEN letter_type_cd = 'TN 411' THEN letter_mailed_date ELSE NULL END TN411_mail_date
  ,CASE WHEN letter_type_cd = 'TN 403qmb' THEN letter_mailed_date ELSE NULL END TN403qmb_mail_date
  ,CASE WHEN letter_type_cd = 'TN 412' THEN letter_mailed_date ELSE NULL END TN412_mail_date
  ,CASE WHEN letter_type_cd = 'TN 413' THEN letter_mailed_date ELSE NULL END TN413_mail_date
  ,CASE WHEN letter_type_cd = 'TN 413a' THEN letter_mailed_date ELSE NULL END TN413a_mail_date  
FROM letters_stg ls
  JOIN app_case_link_stg cl ON ls.letter_case_id = cl.case_id
  LEFT JOIN letter_request_link_stg lr ON ls.letter_id = lr.lmreq_id AND lr.reference_type = 'APP_HEADER'  
WHERE 1=1
--(letter_create_ts >= TO_DATE('${CIR_LAST_UPDATE_DATE}','YYYY/MM/DD HH24:MI:SS') 
--OR letter_update_ts >= TO_DATE('${CIR_LAST_UPDATE_DATE}','YYYY/MM/DD HH24:MI:SS') )
AND letter_status_cd = 'MAIL'
AND ( (letter_request_type IN('L','S') AND letter_type_cd IN('TN 401','TN 401a','TN 402','TN 403','TN 404','TN 405','TN 405a','TN 406a','TN 406b','TN 406c'
                       ,'TN 406d','TN 406e','TN 406f','TN 406g','TN 406h','TN 406i','TN 406j','TN 406l','TN 406m','TN 406n','TN 406o','TN 406p','TN 407'
                       ,'TN 408','TN 409','TN 411','TN 408ftp','TN 409ftp','TN 403qmb','TN 410msp','TN 413','TN 413a','TN 412') )
  OR (letter_type_cd IN ('TN 401R','TN 401aR' )) )
)                       
GROUP BY letter_case_id,application_id ) n ON ci.application_id = n.application_id
) tmp ON (s.application_id = tmp.application_id)
WHEN MATCHED THEN UPDATE
SET	TN412_MAIL_DATE	=	tmp.new_TN412_MAIL_DATE
,	TN401_MAIL_DATE	=	tmp.new_TN401_MAIL_DATE
,	TN401A_MAIL_DATE	=	tmp.new_TN401A_MAIL_DATE
,	TN402_MAIL_DATE	=	tmp.new_TN402_MAIL_DATE
,	TN403_MAIL_DATE	=	tmp.new_TN403_MAIL_DATE
,	TN403QMB_MAIL_DATE	=	tmp.new_TN403QMB_MAIL_DATE
,	TN404_MAIL_DATE	=	tmp.new_TN404_MAIL_DATE
,	TN405_MAIL_DATE	=	tmp.new_TN405_MAIL_DATE
,	TN405A_MAIL_DATE	=	tmp.new_TN405A_MAIL_DATE
,	TN406A_MAIL_DATE	=	tmp.new_TN406A_MAIL_DATE
,	TN406B_MAIL_DATE	=	tmp.new_TN406B_MAIL_DATE
,	TN406C_MAIL_DATE	=	tmp.new_TN406C_MAIL_DATE
,	TN406D_MAIL_DATE	=	tmp.new_TN406D_MAIL_DATE
,	TN406E_MAIL_DATE	=	tmp.new_TN406E_MAIL_DATE
,	TN406F_MAIL_DATE	=	tmp.new_TN406F_MAIL_DATE
,	TN406G_MAIL_DATE	=	tmp.new_TN406G_MAIL_DATE
,	TN406H_MAIL_DATE	=	tmp.new_TN406H_MAIL_DATE
,	TN406I_MAIL_DATE	=	tmp.new_TN406I_MAIL_DATE
,	TN406J_MAIL_DATE	=	tmp.new_TN406J_MAIL_DATE
,	TN406L_MAIL_DATE	=	tmp.new_TN406L_MAIL_DATE
,	TN406M_MAIL_DATE	=	tmp.new_TN406M_MAIL_DATE
,	TN406N_MAIL_DATE	=	tmp.new_TN406N_MAIL_DATE
,	TN406P_MAIL_DATE	=	tmp.new_TN406P_MAIL_DATE
,	TN406O_MAIL_DATE	=	tmp.new_TN406O_MAIL_DATE
,	TN407_MAIL_DATE	=	tmp.new_TN407_MAIL_DATE
,	TN408_MAIL_DATE	=	tmp.new_TN408_MAIL_DATE
,	TN409_MAIL_DATE	=	tmp.new_TN409_MAIL_DATE
,	TN401R_INITIAL_MAIL_DATE	=	tmp.new_TN401R_INITIAL_MAIL_DATE
,	TN401AR_INITIAL_MAIL_DATE	=	tmp.new_TN401AR_INITIAL_MAIL_DATE
,	TN401R_LAST_MAIL_DATE	=	tmp.new_TN401R_LAST_MAIL_DATE
,	TN401AR_LAST_MAIL_DATE	=	tmp.new_TN401AR_LAST_MAIL_DATE
,	TN411_MAIL_DATE	=	tmp.new_TN411_MAIL_DATE
,	TN408FTP_MAIL_DATE	=	tmp.new_TN408FTP_MAIL_DATE
,	TN409FTP_MAIL_DATE	=	tmp.new_TN409FTP_MAIL_DATE
,	TN410MSP_MAIL_DATE	=	tmp.new_TN410MSP_MAIL_DATE
,	TN413_MAIL_DATE	=	tmp.new_TN413_MAIL_DATE
,	TN413A_MAIL_DATE	=	tmp.new_TN413A_MAIL_DATE
,l_401_401a_date = tmp.new_l_401_401a_date