create or replace function GET_TOPIC_SELECT_QRY
    (p_type in varchar2
	,p_change in varchar2 DEFAULT 'CDC')
    return varchar2 parallel_enable result_cache
  as
  
    v_col varchar2(20) ;
    v_tab varchar2(20) ;
    v_guideline varchar2(10);
    v_list_null varchar2(100) := null;
    Sql_stmt varchar2(4000) := null; 
    v_max_id number(20);	

  begin

     If p_type in ('MTUS','CA_MTUS') Then 
       
         If p_type = 'MTUS' THEN 
            v_col := 'C_2017_TOP_';
            v_tab := 'M_ISS_2017_TOP_';
            v_guideline := 'MT17';
         Elsif p_type = 'CA_MTUS' THEN 
            v_col := 'C_CA_2017_TOP_';
            v_tab := 'M_ISS_CA_2017_TOP_';
            v_guideline := 'CA17';
         End If;   
           
         For I in ( Select MD_ORDER idx, MD_ID        
                      From D_CRS_METADATA
                     Where MD_Type = 'CHAPTER_DETAIL'
                       and MD_ID > 5000
                     Order by MD_ORDER)
         Loop
            
			IF p_change = 'CDC' THEN 
			
				Select NVL(MAX(slct_id),0) into v_max_id from s_Crs_imr_selects where slct_chapter_id = I.md_id and slct_guideline = v_guideline;
				   
				if I.idx = 1 then 
				
				   Sql_stmt := 'Select ID SLCT_ID, ID_OWNER SLCT_ISS_DISPUTE_ID , LIST_ORDER SLCT_ORDER, '||v_col||I.idx||'_SELECTS SLCT_TOPIC_ID,'
								||i.md_id||' SLCT_CHAPTER_ID ,'''||v_guideline||''' SLCT_GUIDELINE From '
								  || v_tab||I.idx||'_SELECTS WHERE ID > '|| v_max_id ;
								  
				Else

				   Sql_stmt := Sql_stmt ||CHR(13) ||' Union '||CHR(13)
							   || 'Select ID, ID_OWNER, LIST_ORDER, '||v_col||I.idx||'_SELECTS, '||i.md_id||','''||v_guideline||''' From '
							   || v_tab||I.idx||'_SELECTS WHERE ID > '|| v_max_id ;
							   
				End if;   
			
			ELSIF P_Change = 'ALL' THEN

			   if I.idx = 1 then 
				
				   Sql_stmt := 'Select ID SLCT_ID, ID_OWNER SLCT_ISS_DISPUTE_ID , LIST_ORDER SLCT_ORDER, '||v_col||I.idx||'_SELECTS SLCT_TOPIC_ID,'
								||i.md_id||' SLCT_CHAPTER_ID ,'''||v_guideline||''' SLCT_GUIDELINE From '
								  || v_tab||I.idx||'_SELECTS' ;
								  
				Else

				   Sql_stmt := Sql_stmt ||CHR(13) ||' Union '||CHR(13)
							   || 'Select ID, ID_OWNER, LIST_ORDER, '||v_col||I.idx||'_SELECTS, '||i.md_id||','''||v_guideline||''' From '
							   || v_tab||I.idx||'_SELECTS' ;
							   
				End if;
				
		    END IF;
             
         End Loop;
      
      End If;
     
    return NVL(Sql_stmt,v_list_null);
  exception when others then
     return v_list_null;
  end;

/

grant execute on MAXDAT_CADR.GET_TOPIC_SELECT_QRY to MAXDAT_READ_ONLY; 


