select 'Before Update', count(*)
from corp_etl_mfb_envelope_stg
where env_creation_date is null;

update corp_etl_mfb_envelope_stg
set env_creation_date = env_receipt_date
where env_creation_date is null;

select 'After Update', count(*)
from corp_etl_mfb_envelope_stg
where env_creation_date is null;

select 'Before Update', count(*)
from corp_etl_mfb_envelope
where env_creation_date is null;

update corp_etl_mfb_envelope
set env_creation_date = env_receipt_date
where env_creation_date is null;

select 'After Update', count(*)
from corp_etl_mfb_envelope
where env_creation_date is null;

commit;

