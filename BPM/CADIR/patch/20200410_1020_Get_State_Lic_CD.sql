Create or replace function GET_SPECIALTY_STATE_LIC_CD
    (p_imr_id in varchar2,
     p_type_cd in varchar2)
    return varchar2 parallel_enable result_cache
  as
    v_list varchar2(100) := null;

    col_sep varchar2(10) := '||';

  begin

    If p_type_cd = 'P' Then
      
      Select st_abb into v_list
        From ( SELECT ST.STATE_ABBREVIATION St_abb
                    , Row_Number() over ( ORDER BY DECODE(ST.STATE_ABBREVIATION, NULL,0,'CA', 0, LS.LIST_ORDER)) RN
                 FROM S_CRS_IMR_EXPERT_LICENSE_STATE LS,
                      D_CRS_STATES ST
                WHERE LS.EXPERT_REVIEW_ID = ( SELECT MAX(EXPERT_REVIEW_ID) FROM S_CRS_IMR_EXPERT_REVIEW C WHERE C.IMR_ID = P_IMR_ID) 
                  AND LS.STATE_ID = ST.STATE_ID) A
        Where RN = 1;
      
    Elsif p_type_cd = 'S' Then  
	
	    Select Value Into col_sep
		  From Corp_Etl_Control
		 Where Name = 'DWC_COLVALUE_SEP';
      
      Select LISTAGG(ST_Abb,col_sep) WITHIN GROUP (ORDER BY RN) into v_list
        From ( SELECT ST.STATE_ABBREVIATION St_abb
                    , Row_Number() over ( ORDER BY DECODE(ST.STATE_ABBREVIATION, NULL,0,'CA', 0, LS.LIST_ORDER)) RN
                 FROM S_CRS_IMR_EXPERT_LICENSE_STATE LS,
                      D_CRS_STATES ST
                WHERE LS.EXPERT_REVIEW_ID = ( SELECT MAX(EXPERT_REVIEW_ID) FROM S_CRS_IMR_EXPERT_REVIEW C WHERE C.IMR_ID = P_IMR_ID) 
                  AND LS.STATE_ID = ST.STATE_ID) A
        Where RN > 1;
      
    else v_list := null;  

    End if;        

    return v_list;
  exception when others then
      return null;
  end;
