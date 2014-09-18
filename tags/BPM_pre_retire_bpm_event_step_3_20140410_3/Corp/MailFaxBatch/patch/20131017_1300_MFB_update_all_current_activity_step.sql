update corp_etl_mfb_batch
set current_step=
case when cancel_dt is not null then 'End - Cancelled' 
when ased_release_dms is not null then 'End - Released to DMS' 
when assd_release_dms is not null then 'Release to DMS' 
when ased_populate_reports is not null then 'Release to DMS' 
when assd_populate_reports is not null then 'Populate Reports Data' 
when ased_create_pdf is not null then 'Populate Reports Data' 
when assd_create_pdf is not null then 'Create PDFs' 
when ased_validate_data is not null then 'Create PDFs' 
when assd_validate_data is not null then 'Review Batch (KTM Validation Module)' 
when ased_classification is not null then 'Review Batch (KTM Validation Module)' 
when assd_classification is not null then 'Classify Document and Extract Metadata' 
when gwf_qc_required = 'Y' and ased_perform_qc is not null then 'Classify Document and Extract Metadata' 
when gwf_qc_required = 'N' and ased_scan_batch is not null then 'Classify Document and Extract Metadata' 
when gwf_qc_required = 'Y' and ased_scan_batch is not null then 'Perform QC' 
when gwf_qc_required = 'Y' and assd_perform_qc is not null then 'Perform QC' 
when assd_scan_batch is not null then 'Perform Scan' 
else 'Unknown' end;
commit;
