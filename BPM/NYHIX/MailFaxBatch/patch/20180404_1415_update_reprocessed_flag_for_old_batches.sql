alter session set current_schema = MAXDAT;
----  NYHIX-39629 and NYHIX-39327
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070'
);

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070'
);


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070'
);
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-HRA2018-03-23-12-04-25-070',
'679515-3/30/2018-9:42:13 AM-139895',
'679074-3/29/2018-1:28:39 PM-149087',
'NYSOH-FAX-HRA2018-03-23-12-04-25-070');





 