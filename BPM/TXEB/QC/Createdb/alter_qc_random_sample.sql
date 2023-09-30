alter table qc_random_Sample add (LANGUAGE varchar2(10));

grant select on QC_RANDOM_SAMPLE_SV to maxdat_read_only;
grant select on QC_RANDOM_SAMPLE_SV to maxdat_reports;
grant select on QC_RANDOM_SAMPLE_SV to maxdatread;

grant select on QC_RANDOM_SAMPLE to maxdat_read_only;
grant select on QC_RANDOM_SAMPLE to maxdat_reports;
grant select on QC_RANDOM_SAMPLE to maxdatread;
