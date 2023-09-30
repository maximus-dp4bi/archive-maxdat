\echo `date`
\echo 'Starting counts'
select count(*) from maxdat_support.eligibility_assessment_paris_va_sv; 
select count(*) from maxdat_support.eligibility_assessment_paris_inter_sv;
select count(*) from maxdat_support.eligibility_assessment_client_sv;
select count(*) from maxdat_support.eligibility_exception_sv;
select count(*) from maxdat_support.exception_totals_sv;

REFRESH MATERIALIZED view maxdat_support.eligibility_assessment_paris_va_sv;
REFRESH MATERIALIZED view maxdat_support.eligibility_assessment_paris_inter_sv;
REFRESH MATERIALIZED view maxdat_support.eligibility_assessment_client_sv;
REFRESH MATERIALIZED view maxdat_support.eligibility_exception_sv;
REFRESH MATERIALIZED view maxdat_support.exception_totals_sv;
\echo 'Ending counts'
select count(*) from maxdat_support.eligibility_assessment_paris_va_sv;
select count(*) from maxdat_support.eligibility_assessment_paris_inter_sv;
select count(*) from maxdat_support.eligibility_assessment_client_sv;
select count(*) from maxdat_support.eligibility_exception_sv;
select count(*) from maxdat_support.exception_totals_sv;
\echo `date`
\q
