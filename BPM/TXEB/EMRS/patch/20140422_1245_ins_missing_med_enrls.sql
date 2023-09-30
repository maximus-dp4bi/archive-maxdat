INSERT INTO emrs_f_enrollment (source_record_id
      ,client_number
      ,case_number
      ,provider_number
      ,managed_care_start_date
      ,managed_care_end_date
      ,enrollment_status_change_date
      ,number_count
      ,cost_share_start_date
      ,cost_share_end_date
      ,co_pay_amount
      ,enrollment_fee_assessed
      ,enrollment_fee_assessed_date
      ,enrollment_fee_paid
      ,enrollment_fee_paid_date
      ,met_cost_share_cap_date
      ,enrollment_fee_frequency
      ,chip_annual_enroll_date
      ,certification_date
      ,medicaid_recertification_date
      ,eligibility_receipt_date
      ,source_table_name
      ,people_in_family
      ,county_id
      ,csda_id
      ,coverage_category_id
      ,enrollment_action_status_id
      ,fpl_id
      ,plan_id
      ,program_id
      ,risk_group_id
      ,stat_in_grp_id
      ,sub_program_id
      ,aid_category_id
      ,citizenship_id      
      ,selection_source_id      
      ,selection_reason_id      
      ,language_code_id
      ,date_period_id
      ,time_period_id
      ,change_reason_id
      ,term_reason_code_id
	    ,race_id
	    ,provider_type_id
      ,plan_type_id
      ,fpl_percentage)
SELECT source_selection_record_id source_record_id
      ,source_client_id client_number
      ,source_case_id case_number
      ,source_network_id provider_number
      ,s.managed_care_start_date
      ,s.managed_care_end_date
      ,s.enrollment_status_change_date
      ,s.number_count
      ,s.cost_share_start_date
      ,s.cost_share_end_date
      ,s.co_pay_amount
      ,s.enrollment_fee_assessed
      ,s.enrollment_fee_assessed_date
      ,s.enrollment_fee_paid
      ,s.enrollment_fee_paid_date
      ,s.met_cost_share_cap_date
      ,s.enrollment_fee_frequency
      ,s.chip_annual_enroll_date
      ,s.certification_date
      ,s.medicaid_recertification_date
      ,s.eligibility_receipt_date
      ,s.source_table_name
      ,s.people_in_family
      ,COALESCE(edc.county_id,0) county_id
      ,COALESCE(eds.csda_id,0) csda_id
      ,COALESCE(ecc.coverage_category_id,0) coverage_category_id
      ,COALESCE(eda.enrollment_action_status_id,0) enrollment_action_status_id
      ,COALESCE(edf.fpl_id,0) fpl_id
      ,COALESCE(edp.plan_id,edpu.plan_id,0) plan_id
      ,COALESCE(edpr.program_id,0) program_id
      ,COALESCE(edrg.risk_group_id,0) risk_group_id
      ,COALESCE(edsg.status_in_group_id,0) stat_in_grp_id
      ,COALESCE(edsp.sub_program_id,0) sub_program_id
      ,COALESCE(edac.aid_category_id,0) aid_category_id
      ,COALESCE(edcs.citizenship_id,0) citizenship_id      
      ,COALESCE(edss.selection_source_id,0) selection_source_id      
      ,COALESCE(edsr.selection_reason_id,0) selection_reason_id      
      ,COALESCE(edl.language_code_id,0) language_code_id
      ,COALESCE(eddr.date_period_id,0) date_period_id
      ,COALESCE(edtr.time_period_id,0) time_period_id
      ,COALESCE(edcr.change_reason_id,0) change_reason_id
      ,COALESCE(edmr.term_reason_code_id,0) term_reason_code_id
	  ,COALESCE(edre.race_id,0) race_id
	  ,COALESCE(edpt.provider_type_id,0) provider_type_id
      ,COALESCE(edpp.plan_type_id,0) plan_type_id
      ,s.fpl_percentage
FROM emrs_s_enrollment_stg_adhoc s
  INNER JOIN emrs_d_time_period edtr
    ON edtr.hour_minute_military = s.create_ts_hrmin
    AND edtr.second = s.create_ts_second
  INNER JOIN emrs_d_date_period eddr
    ON eddr.date_standard_2 = s.create_ts
  LEFT OUTER JOIN emrs_d_program edpr
    ON edpr.program_code =  s.program_type_code 
  LEFT OUTER JOIN emrs_d_sub_program edsp
    ON edsp.sub_program_code = s.sub_program_code
    AND edsp.parent_program_id = edpr.program_id 
  LEFT OUTER JOIN emrs_d_risk_group edrg
    ON edrg.risk_group_code = s.risk_group_code
    AND edrg.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_status_in_group edsg
    ON edsg.status_in_group_code = s.status_in_group_code
    AND edsg.managed_care_program = s.program_type_code    
 LEFT OUTER JOIN emrs_d_coverage_category ecc
    ON ecc.coverage_category_code = s.coverage_code
    AND ecc.coverage_category_type = 'COVERAGE'
    AND ecc.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_citizenship_status edcs
     ON edcs.citizenship_code = s.citizenship_status_code
     AND edcs.managed_care_program = s.program_type_code    
  LEFT OUTER JOIN emrs_d_enrollment_action_statu eda
    ON eda.enrollment_action_status_code = s.enrollment_action_status_code
    AND eda.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_language edl
    ON edl.language_code  = s.language_code
    AND edl.managed_care_program = s.program_type_code     
  LEFT OUTER JOIN emrs_d_aid_category edac
    ON edac.aid_category_code = s.aid_category_code
    AND edac.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_selection_source edss
     ON edss.selection_source_code = s.selection_source_code
     AND edss.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_selection_reason edsr
     ON edsr.selection_reason_code = s.selection_reason_code
     AND edsr.managed_care_program = s.program_type_code 
  LEFT OUTER JOIN emrs_d_provider_type edpt
    ON edpt.provider_code = s.provider_type_code
    AND edpt.managed_care_program = s.program_type_code  
  LEFT OUTER JOIN emrs_d_plan_type edpp
    ON edpp.plan_type = s.plan_type_code
    AND edpp.managed_care_program = s.program_type_code     
  LEFT OUTER JOIN emrs_d_race edre
    ON edre.race_code = s.race_code
    AND edre.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_plan edp
    ON edp.plan_code = s.source_plan_code
    AND edp.csda = s.csda_code
    AND edp.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_plan edpu
    ON edpu.plan_code = s.source_plan_code
    AND edpu.csda = '0'
    AND edpu.managed_care_program = s.program_type_code    
  LEFT OUTER JOIN emrs_d_care_serv_deliv_area eds
    ON eds.csda_code = s.csda_code 
    AND eds.managed_care_program = s.program_type_code            
  LEFT OUTER JOIN emrs_d_county edc
    ON  edc.county_code =  s.county_code
    AND edc.csdaid =  s.csda_code
    AND edc.plan_service_type = s.plan_service_type        
  LEFT OUTER JOIN emrs_d_change_reason edcr
    ON edcr.change_reason_code = s.change_reason_code
    AND edcr.change_reason_code_plan = s.source_plan_code
    AND edcr.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_termination_reason edmr
    ON edmr.plan_name = s.source_plan_code
    AND edmr.reason_code = s.change_reason_code
    AND edmr.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_federal_poverty_level edf
    ON edf.fpl_number_in_family = s.people_in_family
    AND TO_CHAR(sysdate,'YYYY') = TO_CHAR(fpl_year,'YYYY')
where s.source_selection_record_id in(
46742069	,
46931809	,
46363413	,
45542952	,
45560494	,
45545238	,
45520821	,
45522009	,
45504808	,
45516016	,
45549614	,
45523882	,
45527275	,
45557749	,
45539564	,
45534345	,
45498557	,
45546839	,
45533513	,
46384443	,
46349748	,
46332942	,
46333022	,
46314366	,
46345493	,
46316660	,
46324435	,
46334844	,
46353075	,
46349543	,
46329418	,
46349549	,
46325124	,
46358109	,
46384249	,
46740312	,
46716836	,
46935087	,
46836659	,
47017456	,
46847747	,
47017447	,
47068803	,
46898593	,
47017462	,
46896159	,
46853226	,
46924839	,
46927979	,
46716001	,
46839485	,
46891609	,
46891608	,
47028402	,
47040469	,
47017453	,
46917115	,
46840524	,
46872201	,
38453569	,
38559091	,
38507187	,
45553915	,
46347872	,
46375166	,
46740304	,
45506935	,
45539572	,
47018564	,
47040382	,
45531066	,
46333012	,
46343642	,
46384245	,
46715111	,
46371289	,
46399304	,
47022049	,
46933764	,
46740310	,
46949312	,
46836658	,
46727980	,
46349547	,
46347109	,
46332999	,
46345491	,
46371283	,
46407860	,
46395752	,
46912347	,
47018563	,
38548495	,
46384441	,
46334848	,
47017461	,
47017449	,
46856086	,
46839484	,
46362306	,
45561714	,
46335639	,
46342931	,
46347874	,
46375165	,
47040381	,
38548498	,
38559093	,
45517510	,
45539576	,
46390164	,
46397827	,
46841370	,
47017450	,
47068439	,
45520822	,
45535360	,
46714494	,
46912892	,
45499685	,
45535070	,
46906796	,
47017452	,
38455027	,
45524327	,
45523881	,
46343640	,
46384246	,
46879720	,
38421196	,
38523557	,
38525213	,
45539551	,
45539552	,
45565430	,
46323885	,
46723838	,
46712366	,
46732508	,
46706089	,
42911801	,
45531758	,
46336926	,
46331153	,
46898599	,
45554871	,
45501355	,
46935835	,
46911523	,
46754476	,
46839486	,
46847977	,
47018569	,
47025280	,
45539586	,
45499686	,
46389033	,
46708673	,
46949334	,
45513539	,
46407713	,
47040268	,
45507707	,
46841371	,
46837856	,
46712306	,
46912319	,
38451420	,
45517512	,
45523883	,
46340158	,
45557031	,
46327486	,
46402749	,
46841372	,
46732512	,
47040277	,
46338908	,
46384248	,
47020733	,
46929280	,
38507194	,
45516839	,
45554185	,
45552581	,
46334849	,
46850408	,
46879754	,
47040530	,
47020732	,
46732513	,
45520820	,
46407614	,
46841367	,
46754472	,
46949066	,
45523982	,
46354430	,
46347873	,
46752999	,
46839342	,
46754475	,
46934976	,
45134624	,
45549162	,
46713776	,
46911524	,
46896161	,
46935776	,
45510083	,
46357107	,
46740305	,
46916146	,
46889032	,
46732511	,
46359514	,
45517514	,
46327038	,
47017458	,
46898784	,
38455026	,
46931889	,
45541762	,
45542893	,
47025281	,
47024672	,
46727636	,
46746082	,
46904159	,
45539453	,
46335481	,
46332404	,
46839343	,
45539543	,
46327037	,
46401388	,
46839345	,
46889033	,
45534391	,
45568281	,
46388996	,
46712822	,
47017457	,
46883016	,
46836661	,
46836662	,
46922312	,
46935843	,
46725777	,
46846328	,
45543588	,
45521775	,
47017459	,
46723514	,
46754470	,
47018565	,
45512766	,
45513253	,
45531722	,
46339158	,
46333028	,
46338907	,
46354176	,
46375169	,
46914638	,
46712307	,
46839441	,
47024042	,
47068412	,
47017451	,
46764712	,
45561262	,
46332941	,
46392933	,
46891610	,
47022430	,
47040622	,
45559880	,
45549160	,
45531721	,
46871151	,
46924045	,
46359942	,
46742068	,
46388681	,
46883026	,
46836660	,
42913355	,
45507781	,
45534404	,
46706090	,
46891606	,
46399250	,
46340673	,
46402748	,
46935790	,
46361391	,
46742067	,
45502583	,
46318649	,
47017454	,
46839482	,
46841369	,
46935822	,
46935803	,
45523880	,
45559029	,
45557750	,
46334847	,
46727051	,
47068512	,
46951323	,
46363412	,
45549167	,
46357106	,
46375015	,
45546192	,
45549016	,
45516840	,
46349540	,
46922673	,
46859808	,
46872099	,
45564814	,
45565252	,
46357981	,
46407365	,
46397080	,
46754477	,
47017460	,
47024542	,
47017455	,
46839065	,
46836663	,
46931257	,
45553620	,
46332659	,
47017448	,
46903003	,
46908126	,
46886327	,
46935823	,
47022431	,
46935852	,
45539225	,
45523879	,
45534093	,
46716359	,
46740311	,
47040359	,
47017464	,
46921786	,
46871149	,
46879747	,
46732509	,
46954559	,
45554481	,
45531595	,
45528720	,
45517515	,
46842604	,
47040249	,
45526092	,
46348310	,
46333005	,
47024656	,
46839481	,
46915952	,
45567269	,
45534403	,
45521772	,
46706088	,
46706086	,
46837027	,
46916780	,
45517513	,
46347110	,
46249656	,
46345492	,
46388777	,
46915454	,
46935840	,
46841373	,
46908419	,
46915741	,
46843749	,
45546885	,
45504135	,
45564815	,
46349536	,
46715059	,
46898646	,
47040245	,
47018570	,
45514579	,
46725165	,
46714614	,
47017463	);

commit;