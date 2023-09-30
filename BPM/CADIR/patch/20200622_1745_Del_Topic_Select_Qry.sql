create or replace function DEL_TOPIC_SELECT_QRY
    (p_type in varchar2)
    return CLOB
  as

    v_list_null varchar2(100) := null;
    v_guideline varchar2(4) := null;

    Select_Qry CLOB;
    Where_Clause CLOB;
    Final_Qry CLOB;

    list_agg_toolong  EXCEPTION;
    PRAGMA EXCEPTION_INIT (list_agg_toolong, -1489);

  begin

    If p_type in ('MTUS','CA_MTUS') Then

     SELECT Get_Topic_Select_Qry(p_type ,'ALL') Slct_Q
          , Case p_type When 'MTUS' Then 'MT17' Else 'CA17' End guideline
     INTO Select_Qry , v_guideline
       FROM DUAL;

       BEGIN

          SELECT  NVL(LISTAGG(SLCT_ISS_DISPUTE_ID,',') WITHIN GROUP (ORDER BY SLCT_ISS_DISPUTE_ID) ,0) WHERE_STMNT
            INTO  Where_Clause
           From (  SELECT DISTINCT SLCT_ISS_DISPUTE_ID
                     FROM S_CRS_IMR_SELECTS
                    WHERE SLCT_GUIDELINE = v_guideline AND ACTIVE = 1
                    GROUP BY SLCT_ISS_DISPUTE_ID, SLCT_TOPIC_ID, SLCT_CHAPTER_ID, SLCT_GUIDELINE
                   HAVING COUNT(1) > 1 ) A  ;

     EXCEPTION
       WHEN list_agg_toolong then

        For I in (SELECT DISTINCT to_char(SLCT_ISS_DISPUTE_ID) AS ISS_DISP_ID
              FROM S_CRS_IMR_SELECTS
               WHERE SLCT_GUIDELINE = v_guideline AND ACTIVE = 1
            GROUP BY SLCT_ISS_DISPUTE_ID, SLCT_TOPIC_ID, SLCT_CHAPTER_ID, SLCT_GUIDELINE
              HAVING COUNT(1) > 1 )
        Loop
          If Where_Clause is null then
             Where_Clause := I.ISS_DISP_ID;
          Else
             Where_Clause := Where_Clause||','||I.ISS_DISP_ID;
          End If;
        End Loop;
       End;

       Final_Qry := 'SELECT SLCT_ID,
                            SLCT_ISS_DISPUTE_ID,
                            SLCT_TOPIC_ID,
                            SLCT_CHAPTER_ID,
                            SLCT_GUIDELINE,
                            0 Inactive
                      FROM ( ' || Select_Qry || ' ) Q WHERE SLCT_ISS_DISPUTE_ID IN ( '
                      || Where_Clause ||' ) ORDER BY SLCT_ID';

    End if;


    return NVL(Final_Qry,v_list_null);
  exception when others then
     return v_list_null;
  end;


/

grant execute on MAXDAT_CADR.DEL_TOPIC_SELECT_QRY to MAXDAT_READ_ONLY; 


