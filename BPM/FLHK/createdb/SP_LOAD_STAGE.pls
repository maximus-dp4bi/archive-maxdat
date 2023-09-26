create or replace procedure
sp_load_stage
(
	p_schema	varchar2 := 'FLCPD0'
)
/**************************************************************************
    Author  - 	David Giorno
    Date    - 	October 1, 2013

    Purpose - 	Load all of the _HIST tables on STAGE from the corresponding
				CDC views of their physical CDC table.  The subscription
				name is a concatenation of the table name and the schema prefix
				passed in, ususally FLCPD0 for production
				Needed to add sp_fix_ai to handle cases where VIDA fail
				to include the person_number in applicant_info

	v6.3	-	removed interface_process

**************************************************************************/
as
    v_begin_ts  	timestamp;
    v_end_ts   		timestamp;
	v_begin_date	date;
	v_end_date		date;

begin

	v_end_ts := sysdate - 1/1440;

	begin

    	update run_etl
       	   set end_ts   = v_end_ts,
          	   state    = 'RUNNING'
     	 where state  = 'NEXT'
       	   and end_ts is NULL
	    return begin_ts
		  into v_begin_ts;

		if	sql%rowcount != 1 then
			raise NO_DATA_FOUND;
		end if;

		delete run_etl
		 where state = 'STILL_RUNNING';

		COMMIT;

	exception
	when OTHERS then
 		insert into job_control ( TABLE_NAME, 	   		START_TS, 	STATUS)
       		 	        values  ( 'SP_LOAD_STAGE', 		sysdate,  	'CHECK - STILL RUNNING FROM YESTERDAY');
    	insert into run_etl 	( run_etl_id,          	BEGIN_ts, 	state)
       		         values 	( run_etl_seq.nextval, 	sysdate, 	'STILL_RUNNING');

		COMMIT;
		RETURN;

	end;

	v_begin_date := to_date(to_char(v_begin_ts,'dd-mon-yyyy hh24:mi:ss'),'dd-mon-yyyy hh24:mi:ss');
    v_end_date   := to_date(to_char(v_end_ts,  'dd-mon-yyyy hh24:mi:ss'),'dd-mon-yyyy hh24:mi:ss');

	-- THESE 6 NEED TO INSERT UPDATES ONLY ON SPECIFIC COLUMNS
	sp_load_cdc_specific ('ACCOUNT_CI_RPT_'			||p_schema	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('ACCOUNT_MEMBERSHIP_RPT_'	||p_schema	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('ACCOUNT_RENEWAL_RPT_'	||p_schema	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('ACCOUNT_RPT_'			||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('COVERAGE_REQUEST_RPT_'	||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('APPLICATION_RPT_'		||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_specific ('PERSON_RPT_'				||p_schema 	, v_begin_date, v_end_date, FALSE );

	-- THE REST INSERT ALL UPDATES
	sp_load_cdc_all ('ACCOUNT_RR_RPT_'				||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('APPLICANT_INFO_RPT_'			||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('COVERAGE_RPT_'				||p_schema	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('DISPUTE_RPT_'					||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('ELIG_DETERM_RPT_'				||p_schema	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('ELIGIBILITY_RESULT_RPT_'		||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('FIN_TRANS_RPT_'				||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('INBOUND_DOCUMENT_RPT_'		||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('INCOME_RPT_'					||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('INCOME_RESP_RPT_'				||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('SUS_TRANS_RPT_'				||p_schema 	, v_begin_date, v_end_date, FALSE );
	sp_load_cdc_all ('WORK_REQUESTS_RPT_'			||p_schema 	, v_begin_date, v_end_date, FALSE );

	sp_stage_deletes (v_begin_ts, v_end_ts);
	sp_deprecate 	 (v_begin_ts, v_end_ts);
	sp_fix_ai    	 (v_begin_ts, v_end_ts);

	sp_stage_counts(v_begin_ts, v_end_ts);

end;
