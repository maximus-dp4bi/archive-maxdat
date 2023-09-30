
ALTER TABLE maxdat_support.eligibility_exception_sv OWNER TO DBA;
alter MATERIALIZED view maxdat_support.eligibility_exception_sv rename to eligibility_exception_sv_old;

--drop materialized view maxdat_support.eligibility_exception_sv;

CREATE MATERIALIZED VIEW maxdat_support.eligibility_exception_sv
AS 
SELECT program,
  --reason,
  case when reason = 'NULL' then null else reason end AS reason,
  create_ts,
  case_id,
  client_id
FROM(
  SELECT ep.report_label AS program
        -- ,ddr.reason_cd as reason
        ,UNNEST(STRING_TO_ARRAY(coalesce(ddr.reason_cd,'NULL'), ',')) AS reason
         ,DATE_TRUNC('day'::text, ddr.create_ts) AS create_ts
		 ,ddr.case_id as case_id
	     ,cscl_clnt_client_id client_id
         ,dense_rank() over(partition by ep.report_label,ddr.reason_cd, DATE_TRUNC('day'::text, ddr.create_ts),cc.cscl_clnt_client_id order by cscl_id) rown
  FROM (SELECT q1.*
  	    FROM (
			 SELECT dd.ds_data_rec_id ddr_id,dd.case_id,de.*,-- de.ds_type_cd, de.ds_id,
      		    rank() OVER (PARTITION BY dd.case_id, date_trunc('month', dd.create_ts),ds_type_cd ORDER BY dd.create_ts DESC) AS rank
	         FROM eb.ds_data_rec dd
      		   JOIN eb.data_request dr ON dd.data_request_id = dr.data_request_id
		       JOIN (SELECT dee.ds_data_rec_id, din.source_cd ds_type_cd,dee.reason_cd::varchar as reason_cd,din.client_id,     dee.gross_mthly_hh_income,dee.create_ts
					 FROM eb.ds_elig_eval_status dee  	 
					  JOIN eb.ds_income din ON din.ds_data_rec_id = dee.ds_data_rec_id
					  WHERE dee.history_ind = false
				UNION
					SELECT de.ds_data_rec_id,ex.ds_type_cd,de.reason_cd::varchar as reason_cd,dec.client_id, de.gross_mthly_hh_income gross_mthly_hh_income,de.create_ts
					FROM eb.ds_elig_eval_status de
				    join eb.ds_elig_eval_client_status dec on dec.elig_eval_status_id = de.elig_eval_status_id
 					JOIN eb.elig_client_status_ds_xwalk ex on dec.elig_eval_client_status_id = ex.elig_eval_client_status_id
					) de ON dd.ds_data_rec_id = de.ds_data_rec_id
	        WHERE dr.status_cd::text = 'RECEIVED'::text
        ) q1 WHERE q1.rank = 1)  ddr
	LEFT JOIN eb.case_client cc ON cc.cscl_clnt_client_id = ddr.client_id AND 
	          cc.cscl_case_id = ddr.case_id AND (cc.cscl_status_cd = 'O' 
	  or (cc.cscl_status_cd = 'C' AND CAST(ddr.create_ts AS DATE) BETWEEN cc.cscl_status_begin_date 
	  AND coalesce(cc.cscl_status_end_date,CAST(ddr.create_ts AS DATE))) 
	  ) 	
	LEFT JOIN eb.ds_elig_eval_status dee ON dee.ds_data_rec_id = ddr.ds_data_rec_id
	LEFT JOIN eb.enum_program_type ep ON cc.program_cd::text = ep.value::text	
	)excp
WHERE rown = 1
with no data;
	

ALTER TABLE maxdat_support.eligibility_exception_sv OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_exception_sv TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_exception_sv TO maxdat_reports;
REFRESH MATERIALIZED view maxdat_support.eligibility_exception_sv;
