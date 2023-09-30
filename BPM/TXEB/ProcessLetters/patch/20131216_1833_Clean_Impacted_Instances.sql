/*
Created on 16-Dec-2013 by Raj A.
Project: TXEB
Process: Process Letters.

Issue:
On 05-Dec-2013, kettle scripts deployment caused all instances to Complete.

Description:
This script will update the cancel related attributes to null after moving data into a temp table. Then the updated data is inserted into the main BPM stage table, 
corp_etl_proc_letters,which will cause the AFTER INSERT trigger to fire and hence data is moved into BPM events and Semantic layer.

*/
--A TRUE BACKUP table. This table will NOT touched at all; NO updates will happen on this table.
create table corp_etl_proc_letters_BKP as
select * from corp_etl_proc_letters;

--Cancel attributes will be updated to null in this table. Then, this data is inserted into the main BPM stage table, corp_etl_proc_letters.
create table corp_etl_proc_letters_BKP_UPD as
select * from corp_etl_proc_letters;

create unique index CEPLBU_UIX1 on CORP_ETL_PROC_LETTERS_BKP_UPD (CEPN_ID) tablespace MAXDAT_INDX parallel compute statistics;
create index CEPLBU_IX1 on CORP_ETL_PROC_LETTERS_BKP_UPD (STG_LAST_UPDATE_DATe) tablespace MAXDAT_INDX parallel compute statistics; 

truncate table corp_etl_proc_letters;

declare
v_count number := 0;

begin

    for cur_rec in 
    (
    select cepn_id       
    from corp_etl_proc_letters_BKP_UPD
    where stg_last_update_date > to_date('2013-12-05','YYYY-MM-DD')
    ) 
    loop
      
          update corp_etl_proc_letters_BKP_UPD
            set cancel_dt = null,
                cancel_by = null,
          	cancel_method = null,
          	cancel_reason = null,
          	instance_status = 'Active',
          	complete_dt = null
          where cepn_id = cur_rec.cepn_id;
          
            v_count := v_count+1;
            if MOD(v_count,10000) = 0
            then
              commit;	  
            end if;
       
    end loop;

end;
/