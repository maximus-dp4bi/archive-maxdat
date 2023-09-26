CREATE OR REPLACE sequence coverva_dmas.seq_alert_log_id;
CREATE OR REPLACE sequence coverva_dmas.seq_file_check_lkup_id;

CREATE TABLE coverva_dmas.dmas_alert_log(
alert_log_id NUMBER DEFAULT coverva_dmas.seq_alert_log_id.nextval,
alert_lookup_id NUMBER,
alert_message VARCHAR,
filename VARCHAR,
create_dt TIMESTAMP_NTZ,
update_dt TIMESTAMP_NTZ,
is_active VARCHAR,
alert_type VARCHAR);

ALTER TABLE coverva_dmas.dmas_alert_log ADD primary key(alert_log_id);

ALTER TABLE coverva_dmas.dmas_file_log ADD (cdc_processed VARCHAR DEFAULT 'N',cdc_processed_date TIMESTAMP_NTZ);

CREATE TABLE coverva_dmas.dmas_file_check_lkup(
file_check_lkup_id NUMBER DEFAULT coverva_dmas.seq_file_check_lkup_id.nextval,
filename_prefix VARCHAR,
file_check_query VARCHAR,
error_message VARCHAR,
is_active VARCHAR,
create_dt TIMESTAMP_NTZ,
update_dt TIMESTAMP_NTZ);

ALTER TABLE coverva_dmas.dmas_file_check_lkup ADD primary key(file_check_lkup_id);

delete from coverva_dmas.dmas_file_check_lkup;
INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CVIU_INVENTORY','SELECT CASE WHEN COUNT(t_number) > 0 THEN 1 ELSE 0 END check_file_indicator FROM <table_name> WHERE (t_number LIKE ''%Ind%'' OR t_number LIKE ''%Sw%'')','Incorrect Tracking Number format','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CVIU_INVENTORY','SELECT CASE WHEN COUNT(t_number) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT t_number,COUNT(t_number) count_app FROM <table_name> GROUP BY t_number HAVING COUNT(t_number) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CPU_I_INVENTORY','SELECT CASE WHEN COUNT(t_number) > 0 THEN 1 ELSE 0 END check_file_indicator FROM <table_name> WHERE (t_number LIKE ''%Ind%'' OR t_number LIKE ''%Sw%'')','Incorrect Tracking Number format','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CPU_I_INVENTORY','SELECT CASE WHEN COUNT(t_number) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT t_number,COUNT(t_number) count_app FROM <table_name> GROUP BY t_number HAVING COUNT(t_number) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('MPT','SELECT CASE WHEN COUNT(*) = SUM(CASE WHEN converted_t_ IS NULL OR LENGTH(id) = 0 THEN 1 ELSE 0 END) THEN 1 ELSE 0 END check_file_indicator FROM <table_name>','NULL Tracking Number for all or some records','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('MPT','SELECT CASE WHEN COUNT(id) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT id,COUNT(id) count_app FROM <table_name> WHERE LENGTH(id) = 0 GROUP BY id HAVING COUNT(id) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('APPMETRIC','SELECT CASE WHEN COUNT(app_number) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT app_number,COUNT(app_number) count_app FROM <table_name> GROUP BY app_number HAVING COUNT(app_number) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('APPMETRIC_PW','SELECT CASE WHEN COUNT(application_number) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT application_number,COUNT(application_number) count_app FROM <table_name> GROUP BY application_number HAVING COUNT(application_number) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('PPIT','SELECT CASE WHEN COUNT(application_) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT application_,COUNT(application_) count_app FROM <table_name> GROUP BY application_ HAVING COUNT(application_) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CPUREPORT','SELECT CASE WHEN COUNT(trackingnum) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT trackingnum,COUNT(trackingnum) count_app FROM <table_name> GROUP BY trackingnum HAVING COUNT(trackingnum) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CPUREPORT_YESTERDAY','SELECT CASE WHEN COUNT(trackingnum) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT trackingnum,COUNT(trackingnum) count_app FROM <table_name> GROUP BY trackingnum HAVING COUNT(trackingnum) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CPUREPORT_TRNS_YESTERDAY','SELECT CASE WHEN COUNT(trknum) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT trknum,COUNT(trknum) count_app FROM <table_name> GROUP BY trknum HAVING COUNT(trknum) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CM_044','SELECT CASE WHEN COUNT(tracking_) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT tracking_,COUNT(tracking_) count_app FROM <table_name> GROUP BY tracking_ HAVING COUNT(tracking_) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_file_check_lkup(filename_prefix,file_check_query,error_message,is_active,create_dt,update_dt)
VALUES('CM_043','SELECT CASE WHEN COUNT(tracking_) > 100 THEN 1 ELSE 0 END check_file_indicator FROM(SELECT tracking_,COUNT(tracking_) count_app FROM <table_name> GROUP BY tracking_ HAVING COUNT(tracking_) > 1)',
'Too many duplicate records found','Y',current_timestamp(),current_timestamp());

