delete from coverkids_approval_stg
where cumulative_ind IN('W', 'Y')
and application_id in(select application_id from coverkids_approval_stg
where trunc(create_date) = to_date('05/15/2018', 'MM/DD/YYYY') 
and cumulative_ind = 'N');

delete from coverkids_approval_stg
where trunc(create_date) = to_date('05/15/2018', 'MM/DD/YYYY') 
and cumulative_ind = 'N';

commit;

select * from coverkids_approval_stg
where application_id in(115139,
283749,
866227,
867099,
867106,
870867,
871210,
870930,
873704,
871222,
876235,
876087,
877021,
876831,
878012,
877340,
878050,
878039,
878173,
878108,
878538,
878260,
882044,
883871,
885880,
886418,
887838,
886996,
893725,
888621,
897095,
895258,
902271,
897155,
903620,
903102,
909043,
905233,
911025,
913343,
914121,
914374,
914904,
915737,
917716,
916459,
918951,
921116,
921186,
972747,
972753,
1151652,
1152020,
1152763,
1153486);