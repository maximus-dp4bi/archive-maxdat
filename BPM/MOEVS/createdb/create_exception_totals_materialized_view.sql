ALTER TABLE maxdat_support.exception_totals_sv OWNER TO DBA
alter MATERIALIZED view maxdat_support.exception_totals_sv rename to exception_totals_sv_old;


CREATE MATERIALIZED VIEW maxdat_support.exception_totals_sv
as
select case_id, create_ts,program_type from (
		select distinct des.case_id,
		des.create_ts,
		ep.report_label as program_type
		from eb.ds_elig_eval_status des
		inner join (select distinct cc.program_cd, cc.cscl_case_id from eb.case_client cc  
        where cc.cscl_status_cd = 'O') in2 on in2.cscl_case_id = des.case_id
        LEFT JOIN eb.enum_program_type ep ON in2.program_cd::text = ep.value::text	
		where des.history_ind = false
		) in1
with no data;
		

ALTER TABLE maxdat_support.exception_totals_sv  OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.exception_totals_sv TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.exception_totals_sv  TO maxdat_reports;
REFRESH MATERIALIZED view maxdat_support.exception_totals_sv;