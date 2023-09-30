create or replace PROCEDURE SP_BLD_CDC_VIEWS 
(
	p_subscription_name	VARCHAR2,
	p_debug				boolean default false
)
/******************************************

	v6.3	12/1/2022   Russell Bergeron
        Created to replace use of EXTEND_WINDOW 
        with support for Shareplex
            12/2/2022   Russell Bergeron
        Added space after I  and D in decode
            12/9/2022   Russell Bergeron
        Added DBMS_ROWID.rowid_row_number(SHAREPLEX_SOURCE_ROWID) for source to RSID$ 

******************************************/
IS
   v_cdc       		cdc_parameters%ROWTYPE;
   v_sql 	    	VARCHAR2(4000);
   v_sql_VW       	VARCHAR2(4000);
   v_sql_max     	VARCHAR2(1000);
   v_start_cscn		number;
   v_end_cscn		number;


  BEGIN

    SELECT *
	  into v_cdc
      FROM cdc_parameters
     WHERE subscription_name = p_subscription_name;
    
    v_sql_max := 'SELECT max (SHAREPLEX_SOURCE_SCN) MX_SCN from '||v_cdc.cdc_table;
    EXECUTE IMMEDIATE v_sql_max INTO v_end_cscn;
    
    UPDATE CDC_SUBSCRIPTIONS_STAGE
       SET EARLIEST_SCN = LATEST_SCN + 1,
           LATEST_SCN = v_end_cscn 
     where subscription_name = p_subscription_name;
   
    SELECT EARLIEST_SCN,
           LATEST_SCN
      into v_start_cscn,
           v_end_cscn
      from CDC_SUBSCRIPTIONS_STAGE 
      where subscription_name = p_subscription_name;  
   
v_sql_VW := 'CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE".'||v_cdc.source_view||'  AS 
Select decode(Shareplex_source_operation,'||q'['UPDATE BEFORE','UO','UPDATE AFTER','UN','INSERT','I ','DELETE','D ']'||') "OPERATION$", 
       Shareplex_source_SCN "CSCN$",  
       Shareplex_source_TIME "COMMIT_TIMESTAMP$", 
       NULL "XIDUSN$",
       NULL "XIDSLT$", 
       NULL "XIDSEQ$",   
       NULL "DDLDESC$", 
       NULL "DDLOPER$", 
       NULL "DDLPDOBJN$", 
       DBMS_ROWID.rowid_row_number(SHAREPLEX_SOURCE_ROWID) "RSID$", 
       NULL "TARGET_COLMAP$", 
       Shareplex_source_TIME "TIMESTAMP$",    
       NULL "USERNAME$", 
       CTV.*
   FROM "FLCPD0_CDC".'||v_cdc.cdc_table||
 ' CTV where shareplex_source_scn >= '||v_start_cscn||' and shareplex_source_scn <= '||v_end_cscn;
 
   	EXECUTE IMMEDIATE v_sql_vw;
END SP_BLD_CDC_VIEWS;