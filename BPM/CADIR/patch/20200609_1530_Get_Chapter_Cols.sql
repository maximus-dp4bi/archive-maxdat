create or replace function GET_CHAPTER_COLS
    (p_type in varchar2)
    return varchar2 parallel_enable result_cache
  as
  
    v_pre varchar2(20) ;
    v_list_null varchar2(100) := null;
    Slct_col_list varchar2(3000) := null;      

  begin

     If p_type in ('MTUS','CA_MTUS') Then 
       
         If p_type = 'MTUS' THEN 
            v_pre := 'C_CHP_2017_';
         Elsif p_type = 'CA_MTUS' THEN 
            v_pre := 'C_CA_CHP_2017_';
         End If;   
           
         For I in ( Select MD_ORDER idx
                      From D_CRS_METADATA
                     Where MD_Type = 'CHAPTER_DETAIL'
                       and MD_ID > 5000
                     Order by MD_ORDER)
         Loop
               
            if I.idx = 1 then 
               Slct_col_list := 'NVL('||v_pre||I.idx||'_SELECTED,0)';
            Else
               Slct_col_list := Slct_col_list||'||NVL('||v_pre||I.idx||'_SELECTED,0)';
            End if;   
             
         End Loop;
      
      End If;
     
    return NVL(Slct_col_list,v_list_null);
  exception when others then
     return v_list_null;
  end;

/
  
grant execute on MAXDAT_CADR.GET_CHAPTER_COLS to MAXDAT_READ_ONLY; 


  
