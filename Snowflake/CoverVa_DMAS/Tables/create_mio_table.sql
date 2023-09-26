CREATE OR REPLACE sequence coverva_dmas.seq_mio_data_id;

CREATE TABLE coverva_dmas.mio_inventory_full_load(
    MIO_Data_Id NUMBER DEFAULT coverva_dmas.seq_mio_data_id.nextval,    
    Filename VARCHAR, 
    First_Name VARCHAR NULL,
    Last_Name VARCHAR NULL,    
    LDAP_ID  VARCHAR NULL,
    Tracking_Number  VARCHAR NULL,    
    Task_Status  VARCHAR NULL,    
    Denial_Reason  VARCHAR NULL,    
    Transferred_To  VARCHAR NULL,    
    Location  VARCHAR NULL, 
    Status_Reason  VARCHAR NULL,    
    Additional_Case_Outcomes  VARCHAR NULL,    
    Number_Approved  VARCHAR NULL,    
    VCL_Doc_Type_Requested  VARCHAR NULL,    
    VCL_Due_Date TIMESTAMP_NTZ NULL,
    Task_Status_Date TIMESTAMP_NTZ NULL,
    Update_Date TIMESTAMP_NTZ NULL    );

ALTER TABLE coverva_dmas.mio_inventory_full_load ADD PRIMARY KEY(MIO_Data_Id);


INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('MIO_INVENTORY','MIO_INVENTORY_FULL_LOAD','COVERVA_DMAS','first_name,last_name,ldap_id,tracking_number, task_status,denial_reason,transferred_to,location,status_reason,additional_case_outcomes,number_approved,vcl_doc_type_requested,vcl_due_date,task_status_date,update_date,filename'
      ,'first_name,last_name,ldap_id,case_number, task_status,denial_reason,transferred_to,location,why,additional_case_outcomes,number_approved,vcl_doc_type_requested,TRY_CAST(vcl_due AS DATE) vcl_due,TRY_CAST(disposition_date AS TIMESTAMP) dispo_date,TRY_CAST(updated AS TIMESTAMP) update_date,filename'
      ,'WHERE 1=1','Y','Y','N');