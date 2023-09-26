create table qc_skill_group (
verint_skill varchaR2(40)
, TX_EB_SKILL_GROUP VARCHAR2(40)
, SAMPLE_GROUP VARCHAR2(40)
, START_DATE DATE
, END_DATE DATE
, ADDED_dATE DATE
, ADDED_BY VARCHAR2(30)
);

CREATE OR REPLACE VIEW QC_SKILL_GROUP_SV AS 
SELECT * FROM QC_SKILL_GROUP;

grant select on QC_SKILL_GROUP_sv to maxdat_read_only;
grant select on QC_SKILL_GROUP_sv to maxdat_reports;

