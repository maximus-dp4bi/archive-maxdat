    alter table NYHIX_ETL_DOC_NOTIFICATIONS
    drop column instance_status_date;
    
    alter table NYHIX_ETL_DOC_NOTIF_OLTP
    drop column instance_status_date;
    
    alter table NYHIX_ETL_DOC_NOTIF_WIP_BPM
    drop column instance_status_date;
    
    alter table D_NYHIX_DOC_NOTIF_CURRENT
    drop column instance_status_date;
    
    alter table NYHIX_ETL_DOC_NOTIFICATIONS
    rename column ASF_VERIFY_DOC to ASF_VERIFY_DN;
    
    alter table NYHIX_ETL_DOC_NOTIF_OLTP
    rename column ASF_VERIFY_DOC to ASF_VERIFY_DN;
    
    alter table NYHIX_ETL_DOC_NOTIF_WIP_BPM
    rename column ASF_VERIFY_DOC to ASF_VERIFY_DN;
    
    alter table D_NYHIX_DOC_NOTIF_CURRENT
    rename column ASF_VERIFY_DOC to ASF_VERIFY_DN;
    
    create or replace view D_NYHIX_DOC_NOTIF_CURRENT_SV as
    select * from D_NYHIX_DOC_NOTIF_CURRENT;