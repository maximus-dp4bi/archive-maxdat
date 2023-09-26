create or replace function GET_TOPIC_SELECT
    (p_treatment_id in Number)
    return CLOB
  as
    v_cnt number := 0;
    v_Chapter_id number;
    slct_found boolean;

    v_list_null varchar2(100) := null;
    col_sep varchar2(10);
    col_val_sep varchar2(10);
    Final_List CLOB;
    Section_List CLOB;

    v_MT   varchar2(50);
    v_CA   varchar2(50);
    v_MT17 varchar2(100);
    v_CA17 varchar2(100);
    v_tmp_Str  varchar2(100);


  begin

      Select Value Into col_val_sep
        From Corp_Etl_Control
       Where Name = 'DWC_COLVALUE_SEP';

      Select Value Into col_sep
        From Corp_Etl_Control
       Where Name = 'DWC_COL_SEPARATOR';

      Select CHP_SELECTED, CA_CHP_SELECTED, CHP_2017_SELECTED, CA_CHP_2017_SELECTED
        Into v_MT, v_CA, v_MT17, v_CA17
        From s_Crs_imr_issues_in_dispute
       Where Issue_in_dispute_id = p_treatment_id;

     FOR I IN ( Select ID, CD FROM ( Select '1' ID, 'MT' CD From Dual   union
             Select '2' ID, 'MT17' CD From Dual union
             Select '3' ID, 'CA17' CD From Dual union
             Select '4' ID, 'CA' CD From Dual ) A ORDER BY ID )
     LOOP
       v_cnt := 0;

       Select decode (I.CD, 'MT', v_MT, 'CA', v_CA, 'MT17', v_MT17, 'CA17', v_CA17)
       Into v_tmp_Str from dual;

       Select REGEXP_COUNT(v_tmp_Str, '1', 1) into v_cnt from dual;

       if v_cnt > 5 then v_cnt := 5; end if;

       If v_cnt != 0 then

          For Cntr in 1..v_cnt
          Loop

              IF I.CD in ('MT','CA') Then

                Select md_id
                Into v_Chapter_id
                From d_crs_metadata
                 Where md_type  = 'CHAPTER_DETAIL'
                 and md_order = Instr(v_tmp_Str, 1, 1, Cntr)
                 and md_id < 999;

              Else

                Select md_id
                Into v_Chapter_id
                From d_crs_metadata
                 Where md_type  = 'CHAPTER_DETAIL'
                 and md_order = Instr(v_tmp_Str, 1, 1, Cntr)
                 and md_id > 5000;

              End If;

              Slct_Found := FALSE;
              Section_List := Null;              

              For S IN (Select Distinct to_Char(Slct_topic_id) Slct_topic , md_id 
                         from s_crs_imr_Selects s, d_crs_metadata m 
                        where m.md_type = 'TOPIC_DETAIL'
                          and m.md_id = s.slct_topic_id
                          and slct_guideline = I.CD
                          and slct_Chapter_id = v_Chapter_id
                          and active = 1
                          and slct_iss_dispute_id = p_treatment_id
                        Order by md_id 
                        )
              Loop
                  Slct_Found := TRUE;
                  If Section_List Is Null then 
                     Section_List := S.Slct_topic;
                  Else
                     Section_List := Section_List||col_val_sep||S.Slct_topic ;
                  End if;
              End Loop;
                  
              If Not Slct_Found Then
                  If Final_List is Null Then 
                     Final_List := col_sep;
                  Else 
                     Final_List := Final_List ||col_sep;   
                  End If;                 
              Else
                  If Final_List is Null Then 
                     Final_List := TRIM(Section_List);
                  Else 
                     Final_List := Final_List ||col_sep|| TRIM(Section_List);   
                  End If;   
              End If;

          End Loop;

        If v_cnt = 1 Then Final_List := Final_List ||col_sep||col_sep||col_sep||col_sep; End if;
        If v_cnt = 2 Then Final_List := Final_List ||col_sep||col_sep||col_sep; End if;
        If v_cnt = 3 Then Final_List := Final_List ||col_sep||col_sep; End if;
        If v_cnt = 4 Then Final_List := Final_List ||col_sep; End if;

       End If;

       If v_cnt = 0 and Final_List is Not Null Then Final_List := Final_List ||col_sep||col_sep||col_sep||col_sep||col_sep; End if;
       If v_cnt = 0 and Final_List is Null Then Final_List := col_sep||col_sep||col_sep||col_sep; End if;

     END LOOP;

    return NVL(Final_List,v_list_null);
  exception when others then
     return v_list_null;
  end;



/

grant execute on MAXDAT_CADR.GET_TOPIC_SELECT to MAXDAT_READ_ONLY; 


