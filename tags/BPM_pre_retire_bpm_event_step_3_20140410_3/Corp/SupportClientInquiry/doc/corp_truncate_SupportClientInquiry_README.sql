Steps to truncate SCI ETL Tables

1. ETL Control Record
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch/20130907_1147_reset_SCI_ctl_last_contact_id.sql

2. ETL Staging Tables
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch/truncate_etl_staging_CLIENT_INQUIRY.sql

3. BPM Semantic Layer
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/patch/truncate_data_model_CLIENT_INQUIRY.sql