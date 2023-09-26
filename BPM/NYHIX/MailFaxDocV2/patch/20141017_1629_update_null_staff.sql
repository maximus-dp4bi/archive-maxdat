update D_NYHIX_MFD_CURRENT_V2
set DOC_UPDATED_BY_STAFF_ID = '0'
where DOC_UPDATED_BY_STAFF_ID  is null;
    
update D_NYHIX_MFD_CURRENT_V2
set ENV_UPDATED_BY_STAFF_ID = '0'
where ENV_UPDATED_BY_STAFF_ID  is null;
    
update D_NYHIX_MFD_CURRENT_V2
set TRASHED_BY = '0'
where TRASHED_BY  is null;

commit;