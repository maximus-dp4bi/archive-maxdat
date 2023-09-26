create or replace function MAXDAT_CADR.GET_CITATION_DESC
    (p_type in varchar2,
     p_type_cd in varchar2)
    return varchar2 parallel_enable result_cache
  as
    v_list varchar2(1000) := null;
    v_list_null varchar2(100) := null;
    v_first varchar2(1) := 'Y';
    v_cnt number := 0;
    v_startpos number := 1;
    v_rsltpos number;

    type vc_list is table of varchar(100) index by varchar2(100);
    l_values vc_list;
    l_lookup    varchar2(100);
    l_lookup_yr varchar2(100);
    col_sep varchar2(10);

    ColSepList1 varchar2(100) := null;
    ColSepList2 varchar2(100) := null;
    ColSepList3 varchar2(100) := null;
    ColSepList4 varchar2(100) := null;

  begin

    Select Value Into col_sep
      From Corp_Etl_Control
     Where Name = 'DWC_COL_SEPARATOR';

    l_values('CA_CHP_1')  := 'General Approaches';                   l_values('CA_CHP_1_YR') := '2004';
    l_values('CA_CHP_2')  := 'Neck and Upper Back Complaints';       l_values('CA_CHP_2_YR') := '';
    l_values('CA_CHP_3')  := 'Shoulder Complaints';                  l_values('CA_CHP_3_YR') := '2004';
    l_values('CA_CHP_4')  := 'Elbow Complaints';                     l_values('CA_CHP_4_YR') := '2004';
    l_values('CA_CHP_5')  := 'Forewarm, Wrist, and Hand Complaints'; l_values('CA_CHP_5_YR') := '2004';
    l_values('CA_CHP_6')  := 'Low Back Complaints';                  l_values('CA_CHP_6_YR') := '2004';
    l_values('CA_CHP_7')  := 'Knee Complaints';                      l_values('CA_CHP_7_YR') := '2004';
    l_values('CA_CHP_8')  := 'Ankle and Foot Complaints';            l_values('CA_CHP_8_YR') := '2004';
    l_values('CA_CHP_9')  := 'Stress-Related Conditions';            l_values('CA_CHP_9_YR') := '2004';
    l_values('CA_CHP_10') := 'Eye';                                  l_values('CA_CHP_10_YR'):= '2004';
    l_values('CA_CHP_11') := 'Acupuncture Treatment';                l_values('CA_CHP_11_YR'):= '2007';
    l_values('CA_CHP_12') := 'Chronic Pain Medical Treatment';       l_values('CA_CHP_12_YR'):= '2009';
    l_values('CA_CHP_13') := 'Postsurgical Treatment';               l_values('CA_CHP_13_YR'):= '2009';
    l_values('CA_CHP_14') := 'Chronic Pain Medical Treatment';       l_values('CA_CHP_14_YR'):= '2016';
    l_values('CA_CHP_15') := 'Opioid Treatment';                     l_values('CA_CHP_15_YR'):= '2016';
    l_values('CA_CHP_16') := 'ACOEM';                                l_values('CA_CHP_16_YR') := '';
    l_values('CA_CHP_17') := 'Acupuncture Treatment Guidelines';          l_values('CA_CHP_17_YR') := '';
    l_values('CA_CHP_18') := 'Chronic Pain Medical Treatment Guidelines'; l_values('CA_CHP_18_YR') := '';
    l_values('CA_CHP_19') := 'Postsurgical Treatment Guidelines';         l_values('CA_CHP_19_YR') := '';

    l_values('CHP_1')  := 'General Approaches';                        l_values('CHP_1_YR') := '2004';
    l_values('CHP_2')  := 'Neck and Upper Back Complaints';            l_values('CHP_2_YR') := '';
    l_values('CHP_3')  := 'Shoulder Complaints';                       l_values('CHP_3_YR') := '2004';
    l_values('CHP_4')  := 'Elbow Complaints';                          l_values('CHP_4_YR') := '2004';
    l_values('CHP_5')  := 'Forearm, Wrist, and Hand Complaints';       l_values('CHP_5_YR') := '2004';
    l_values('CHP_6')  := 'Low Back Complaints';                       l_values('CHP_6_YR') := '2004';
    l_values('CHP_7')  := 'Knee Complaints';                           l_values('CHP_7_YR') := '2004';
    l_values('CHP_8')  := 'Ankle and Foot Complaints';                 l_values('CHP_8_YR') := '2004';
    l_values('CHP_9')  := 'Stress-Related Conditions';                 l_values('CHP_9_YR') := '2004';
    l_values('CHP_10') := 'Eye';                                       l_values('CHP_10_YR'):= '2004';
    l_values('CHP_11') := 'Accupuncture Treatment';                    l_values('CHP_11_YR'):= '2007';
    l_values('CHP_12') := 'Chronic Pain Medical Treatment';            l_values('CHP_12_YR'):= '2009';
    l_values('CHP_13') := 'Postsurgical Treatment';                    l_values('CHP_13_YR'):= '2009';
    l_values('CHP_14') := 'Chronic Pain Medical Treatment';            l_values('CHP_14_YR'):= '2016';
    l_values('CHP_15') := 'Opioid Treatment';                          l_values('CHP_15_YR'):= '2016';
    l_values('CHP_16') := 'ACOEM';                                     l_values('CHP_16_YR') := '';
    l_values('CHP_17') := 'Acupuncture Treatment Guidelines';          l_values('CHP_17_YR') := '';
    l_values('CHP_18') := 'Chronic Pain Medical Treatment Guidelines'; l_values('CHP_18_YR') := '';
    l_values('CHP_19') := 'Postsurgical Treatment Guidelines';         l_values('CHP_19_YR') := '';

    l_values('CHP_2017_1')  := 'Initial Approaches to Treatment';                    l_values('CHP_2017_1_YR') := '2017';
    l_values('CHP_2017_2')  := 'Cervical and Thoracic Spine Disorders';              l_values('CHP_2017_2_YR') := '2016';
    l_values('CHP_2017_3')  := 'Shoulder Disorders';                                 l_values('CHP_2017_3_YR') := '2016';
    l_values('CHP_2017_4')  := 'Elbow Disorders';                                    l_values('CHP_2017_4_YR') := '2013';
    l_values('CHP_2017_5')  := 'Hand, Wrist and Forearm Disorders';                  l_values('CHP_2017_5_YR') := '2016';
    l_values('CHP_2017_6')  := 'Low Back Disorders';                                 l_values('CHP_2017_6_YR') := '2016';
    l_values('CHP_2017_7')  := 'Knee Disorders';                                     l_values('CHP_2017_7_YR') := '2015';
    l_values('CHP_2017_8')  := 'Ankle and Foot Disorders';                           l_values('CHP_2017_8_YR') := '2015';
    l_values('CHP_2017_9')  := 'Eye Disorders';                                      l_values('CHP_2017_9_YR') := '2017';
    l_values('CHP_2017_10') := 'Hip and Groin';                                      l_values('CHP_2017_10_YR'):= '2011';
    l_values('CHP_2017_11') := 'Occupational/Work-Related Asthma Medical Treatment'; l_values('CHP_2017_11_YR'):= '2016';
    l_values('CHP_2017_12') := 'Occupational Interstitial Lung Disease';             l_values('CHP_2017_12_YR'):= '2016';
    l_values('CHP_2017_13') := 'Chronic Pain';                                       l_values('CHP_2017_13_YR'):= '2017';
    l_values('CHP_2017_14') := 'Opioids';                                            l_values('CHP_2017_14_YR'):= '2017';
    l_values('CHP_2017_15') := 'Cornerstones of Disability Prevention and Management';     l_values('CHP_2017_15_YR'):= '2011';
    l_values('CHP_2017_16') := 'General Approach to Initial Assessment and Documentation'; l_values('CHP_2017_16_YR'):= '2016';
    l_values('CHP_2017_17') := 'Prevention';                                               l_values('CHP_2017_17_YR'):= '2011';
    l_values('CHP_2017_18') := 'Traumatic Brain Injury';                                   l_values('CHP_2017_18_YR'):= '2017';
    l_values('CHP_2017_19') := 'Cervical and Thoracic Spine Disorders';                    l_values('CHP_2017_19_YR'):= '2018';
    l_values('CHP_2017_20') := 'Elbow Disorders';                                          l_values('CHP_2017_20_YR'):= '2018';
    l_values('CHP_2017_21') := 'Hand, Wrist and Forearm Disorders';                        l_values('CHP_2017_21_YR'):= '2019';
    l_values('CHP_2017_22') := 'Ankle and Foot Disorders';                                 l_values('CHP_2017_22_YR'):= '2018';
    l_values('CHP_2017_23') := 'Posttraumatic Stress Disorder and Acute Stress Disorder';  l_values('CHP_2017_23_YR'):= '2018';
    l_values('CHP_2017_24') := 'Low Back Disorders';                                       l_values('CHP_2017_24_YR'):= '2019';
    l_values('CHP_2017_25') := 'Introduction to the Workplace Mental Health';              l_values('CHP_2017_25_YR'):= '2019';
    l_values('CHP_2017_26') := 'Hip and Groin Disorders';                                  l_values('CHP_2017_26_YR'):= '2019';
    l_values('CHP_2017_27') := 'Knee Disorders';                                           l_values('CHP_2017_27_YR'):= '2019';
    l_values('CHP_2017_28') := 'Occupational Interstitial Lung Disease';                   l_values('CHP_2017_28_YR'):= '2019';
    l_values('CHP_2017_29') := 'Workplace Mental Health: Depressive Disorders';            l_values('CHP_2017_29_YR'):= '2020';
    l_values('CHP_2017_30') := 'Occupational/Work-Related Asthma';                         l_values('CHP_2017_30_YR'):= '2020';
    l_values('CHP_2017_31') := 'Antiemetics';                                              l_values('CHP_2017_31_YR'):= '2020';
    l_values('CHP_2017_32') := 'Coronavirus (COVID-19)';                                   l_values('CHP_2017_32_YR'):= '2021';
    l_values('CHP_2017_33') := 'Low Back Disorders';                                       l_values('CHP_2017_33_YR'):= '2020';
    l_values('CHP_2017_34') := 'Workplace Mental Health: Anxiety Disorders';               l_values('CHP_2017_34_YR'):= '2021';        
    l_values('CHP_2017_35') := 'Chronic Pain';                                             l_values('CHP_2017_35_YR'):= '2017';        
    l_values('CHP_2017_36') := 'Cornerstones of Disability Prevention and Management';     l_values('CHP_2017_36_YR'):= '2018';        
    l_values('CHP_2017_37') := 'General Approach to Initial Assessment and Documentation'; l_values('CHP_2017_37_YR'):= '2018';        
    l_values('CHP_2017_38') := 'Prevention';                                               l_values('CHP_2017_38_YR'):= '2018';        
    l_values('CHP_2017_39') := 'Elbow Disorders';                                          l_values('CHP_2017_39_YR'):= '2019';
    l_values('CHP_2017_40') := 'Ankle and Foot Disorders';                                 l_values('CHP_2017_40_YR'):= '2019';
    l_values('CHP_2017_41') := 'Cervical and Thoracic Spine';                              l_values('CHP_2017_41_YR'):= '2019';
    l_values('CHP_2017_42') := 'Hand, Wrist, and Forearm Disorders';                       l_values('CHP_2017_42_YR'):= '2019';
    l_values('CHP_2017_43') := 'Initial Approaches to Treatment';                          l_values('CHP_2017_43_YR'):= '2022';
    l_values('CHP_2017_44') := 'Knee Disorders';                                           l_values('CHP_2017_44_YR'):= '2020';	
    l_values('CHP_2017_45') := 'Eye Disorders';                                            l_values('CHP_2017_45_YR'):= '2017';	
    l_values('CHP_2017_46') := 'Hip and Groin Disorders';                                  l_values('CHP_2017_46_YR'):= '2019';	
    l_values('CHP_2017_47') := 'Occupational Interstitial Lung Disease';                   l_values('CHP_2017_47_YR'):= '2020';	
    l_values('CHP_2017_48') := 'Occupational/Work-Related Asthma';                         l_values('CHP_2017_48_YR'):= '2020';	
    l_values('CHP_2017_49') := 'Traumatic Brain Injury';                                   l_values('CHP_2017_49_YR'):= '2018';	
    l_values('CHP_2017_50') := 'Workplace Mental Health: Depressive Disorders';            l_values('CHP_2017_50_YR'):= '2020';	
    l_values('CHP_2017_51') := 'Workplace Mental Health: Introduction';                    l_values('CHP_2017_51_YR'):= '2019';		
    l_values('CHP_2017_52') := 'Workplace Mental Health: Anxiety Disorders';               l_values('CHP_2017_52_YR'):= '2021';		
    l_values('CHP_2017_53') := 'Workplace Mental Health: Posttraumatic Stress Disorder and Acute Stress Disorder';  l_values('CHP_2017_53_YR'):= '2019';
	

    l_values('CA_CHP_2017_1')  := 'Initial Approaches to Treatment';                    l_values('CA_CHP_2017_1_YR') := '2017';
    l_values('CA_CHP_2017_2')  := 'Cervical and Thoracic Spine Disorders';              l_values('CA_CHP_2017_2_YR') := '2016';
    l_values('CA_CHP_2017_3')  := 'Shoulder Disorders';                                 l_values('CA_CHP_2017_3_YR') := '2016';
    l_values('CA_CHP_2017_4')  := 'Elbow Disorders';                                    l_values('CA_CHP_2017_4_YR') := '2013';
    l_values('CA_CHP_2017_5')  := 'Hand, Wrist and Forearm Disorders';                  l_values('CA_CHP_2017_5_YR') := '2016';
    l_values('CA_CHP_2017_6')  := 'Low Back Disorders';                                 l_values('CA_CHP_2017_6_YR') := '2016';
    l_values('CA_CHP_2017_7')  := 'Knee Disorders';                                     l_values('CA_CHP_2017_7_YR') := '2015';
    l_values('CA_CHP_2017_8')  := 'Ankle and Foot Disorders';                           l_values('CA_CHP_2017_8_YR') := '2015';
    l_values('CA_CHP_2017_9')  := 'Eye Disorders';                                      l_values('CA_CHP_2017_9_YR') := '2017';
    l_values('CA_CHP_2017_10') := 'Hip and Groin';                                      l_values('CA_CHP_2017_10_YR'):= '2011';
    l_values('CA_CHP_2017_11') := 'Occupational/Work-Related Asthma Medical Treatment'; l_values('CA_CHP_2017_11_YR'):= '2016';
    l_values('CA_CHP_2017_12') := 'Occupational Interstitial Lung Disease';             l_values('CA_CHP_2017_12_YR'):= '2016';
    l_values('CA_CHP_2017_13') := 'Chronic Pain';                                       l_values('CA_CHP_2017_13_YR'):= '2017';
    l_values('CA_CHP_2017_14') := 'Opioids';                                            l_values('CA_CHP_2017_14_YR'):= '2017';
    l_values('CA_CHP_2017_15') := 'Cornerstones of Disability Prevention and Management';     l_values('CA_CHP_2017_15_YR'):= '2011';
    l_values('CA_CHP_2017_16') := 'General Approach to Initial Assessment and Documentation'; l_values('CA_CHP_2017_16_YR'):= '2016';
    l_values('CA_CHP_2017_17') := 'Prevention';                                               l_values('CA_CHP_2017_17_YR'):= '2011';
    l_values('CA_CHP_2017_18') := 'Traumatic Brain Injury';                                   l_values('CA_CHP_2017_18_YR'):= '2017';
    l_values('CA_CHP_2017_19') := 'Cervical and Thoracic Spine Disorders';                    l_values('CA_CHP_2017_19_YR'):= '2018';
    l_values('CA_CHP_2017_20') := 'Elbow Disorders';                                          l_values('CA_CHP_2017_20_YR'):= '2018';
    l_values('CA_CHP_2017_21') := 'Hand, Wrist and Forearm Disorders';                        l_values('CA_CHP_2017_21_YR'):= '2019';
    l_values('CA_CHP_2017_22') := 'Ankle and Foot Disorders';                                 l_values('CA_CHP_2017_22_YR'):= '2018';
    l_values('CA_CHP_2017_23') := 'Posttraumatic Stress Disorder and Acute Stress Disorder';  l_values('CA_CHP_2017_23_YR'):= '2018';
    l_values('CA_CHP_2017_24') := 'Low Back Disorders';                                       l_values('CA_CHP_2017_24_YR'):= '2019';
    l_values('CA_CHP_2017_25') := 'Introduction to the Workplace Mental Health';              l_values('CA_CHP_2017_25_YR'):= '2019';
    l_values('CA_CHP_2017_26') := 'Hip and Groin Disorders';                                  l_values('CA_CHP_2017_26_YR'):= '2019';
    l_values('CA_CHP_2017_27') := 'Knee Disorders';                                           l_values('CA_CHP_2017_27_YR'):= '2019';
    l_values('CA_CHP_2017_28') := 'Occupational Interstitial Lung Disease';                   l_values('CA_CHP_2017_28_YR'):= '2019';
    l_values('CA_CHP_2017_29') := 'Workplace Mental Health: Depressive Disorders';            l_values('CA_CHP_2017_29_YR'):= '2020';
    l_values('CA_CHP_2017_30') := 'Occupational/Work-Related Asthma';                         l_values('CA_CHP_2017_30_YR'):= '2020';
    l_values('CA_CHP_2017_31') := 'Antiemetics';                                              l_values('CA_CHP_2017_31_YR'):= '2020';
    l_values('CA_CHP_2017_32') := 'Coronavirus (COVID-19)';                                   l_values('CA_CHP_2017_32_YR'):= '2021';
    l_values('CA_CHP_2017_33') := 'Low Back Disorders';                                       l_values('CA_CHP_2017_33_YR'):= '2020';
    l_values('CA_CHP_2017_34') := 'Workplace Mental Health: Anxiety Disorders';               l_values('CA_CHP_2017_34_YR'):= '2021';        
    l_values('CA_CHP_2017_35') := 'Chronic Pain';                                             l_values('CA_CHP_2017_35_YR'):= '2017';        
    l_values('CA_CHP_2017_36') := 'Cornerstones of Disability Prevention and Management';     l_values('CA_CHP_2017_36_YR'):= '2018';        
    l_values('CA_CHP_2017_37') := 'General Approach to Initial Assessment and Documentation'; l_values('CA_CHP_2017_37_YR'):= '2018';        
    l_values('CA_CHP_2017_38') := 'Prevention';                                               l_values('CA_CHP_2017_38_YR'):= '2018';        
    l_values('CA_CHP_2017_39') := 'Elbow Disorders';                                          l_values('CA_CHP_2017_39_YR'):= '2019';
    l_values('CA_CHP_2017_40') := 'Ankle and Foot Disorders';                                 l_values('CA_CHP_2017_40_YR'):= '2019';
    l_values('CA_CHP_2017_41') := 'Cervical and Thoracic Spine';                              l_values('CA_CHP_2017_41_YR'):= '2019';
    l_values('CA_CHP_2017_42') := 'Hand, Wrist, and Forearm Disorders';                       l_values('CA_CHP_2017_42_YR'):= '2019';
    l_values('CA_CHP_2017_43') := 'Initial Approaches to Treatment';                          l_values('CA_CHP_2017_43_YR'):= '2022';
    l_values('CA_CHP_2017_44') := 'Knee Disorders';                                           l_values('CA_CHP_2017_44_YR'):= '2020';	
    l_values('CA_CHP_2017_45') := 'Eye Disorders';                                            l_values('CA_CHP_2017_45_YR'):= '2017';	
    l_values('CA_CHP_2017_46') := 'Hip and Groin Disorders';                                  l_values('CA_CHP_2017_46_YR'):= '2019';	
    l_values('CA_CHP_2017_47') := 'Occupational Interstitial Lung Disease';                   l_values('CA_CHP_2017_47_YR'):= '2020';	
    l_values('CA_CHP_2017_48') := 'Occupational/Work-Related Asthma';                         l_values('CA_CHP_2017_48_YR'):= '2020';	
    l_values('CA_CHP_2017_49') := 'Traumatic Brain Injury';                                   l_values('CA_CHP_2017_49_YR'):= '2018';	
    l_values('CA_CHP_2017_50') := 'Workplace Mental Health: Depressive Disorders';            l_values('CA_CHP_2017_50_YR'):= '2020';	
    l_values('CA_CHP_2017_51') := 'Workplace Mental Health: Introduction';                    l_values('CA_CHP_2017_51_YR'):= '2019';		
    l_values('CA_CHP_2017_52') := 'Workplace Mental Health: Anxiety Disorders';               l_values('CA_CHP_2017_52_YR'):= '2021';		
    l_values('CA_CHP_2017_53') := 'Workplace Mental Health: Posttraumatic Stress Disorder and Acute Stress Disorder';  l_values('CHP_2017_53_YR'):= '2019';


    Select REGEXP_COUNT(p_type_cd, '1', 1) into v_cnt from dual;
    -- limit to only 5 citations
    if v_cnt > 5 then v_cnt := 5; end if;

    v_list_null := col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep;
    ColSepList1 := col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep;
    ColSepList2 := col_sep||col_sep||col_sep||col_sep||col_sep||col_sep;
    ColSepList3 := col_sep||col_sep||col_sep||col_sep;
    ColSepList4 := col_sep||col_sep;

    If v_cnt = 0 then
       v_list := null;
    else
       for i in 1..v_cnt
       loop

          select instr(p_type_cd, 1, v_startpos, i) into v_rsltpos from dual;
           if v_first = 'Y' then
              l_lookup    := upper(p_type)||'_'||v_rsltpos;
              l_lookup_yr := l_lookup||'_YR';
              v_list := l_values(l_lookup)||col_sep||l_values(l_lookup_yr);
              v_first := 'N';
            else
              l_lookup := upper(p_type)||'_'||v_rsltpos;
              l_lookup_yr := l_lookup||'_YR';
              v_list := v_list||col_sep||l_values(l_lookup)||col_sep||l_values(l_lookup_yr);
            end if;

        end loop;
      end if;

      If    v_cnt = 1 then v_list := v_list||ColSepList1;
      Elsif v_cnt = 2 then v_list := v_list||ColSepList2;
      Elsif v_cnt = 3 then v_list := v_list||ColSepList3;
      Elsif v_cnt = 4 then v_list := v_list||ColSepList4;
      End if;

    return NVL(v_list,v_list_null);
  exception when others then
     return v_list_null;
  end;
