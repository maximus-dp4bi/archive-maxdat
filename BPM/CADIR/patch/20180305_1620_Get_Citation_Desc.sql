create or replace function GET_CITATION_DESC
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
  
    Select REGEXP_COUNT(p_type_cd, '1', 1) into v_cnt from dual;
    -- limit to only 5 citations
    if v_cnt > 5 then v_cnt := 5; end if;
    
    v_list_null := col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep||col_sep;

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
       
    return NVL(v_list,v_list_null);
  exception when others then
     return v_list_null;     
  end;
/
