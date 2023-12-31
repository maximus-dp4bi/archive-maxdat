update maxdat.f_idr_by_date f
set complete_dt=to_date('06-JUN-17 10:36:38', 'dd-MON-yyyy HH24:MI:SS'),
    INCIDENT_STATUS_DT=to_date('06-JUN-17 10:36:38', 'dd-MON-yyyy HH24:MI:SS')
where IDR_BI_ID = 36558605;

update maxdat.f_idr_by_date f
set complete_dt=to_date('06-JUN-17 16:15:37', 'dd-MON-yyyy HH24:MI:SS'),
    INCIDENT_STATUS_DT=to_date('06-JUN-17 16:15:37', 'dd-MON-yyyy HH24:MI:SS')
where IDR_BI_ID =36534082;
commit;

update  maxdat.f_idr_by_date f
set complete_dt=to_date('06-JUN-17 14:16:28', 'dd-MON-yyyy HH24:MI:SS'),
    INCIDENT_STATUS_DT=to_date('06-JUN-17 14:16:28', 'dd-MON-yyyy HH24:MI:SS')
where idr_bi_id=36570503;
commit;

update maxdat.f_idr_by_date f
set f.complete_dt=(select s.cur_complete_dt from maxdat.d_idr_current_sv s where s.IDR_BI_ID = f.IDR_BI_ID)
where f.IDR_BI_ID in (36572937,36524347,36573145,36536350,36573152,36573156,36573157,36573164,
36573170,36520362,36573231,36519402,36518329,36520386,36520434,36527365,36573577,36515571,
36573633,36521451,36517338,36573706,36515602,36536393,36523556,36544744,36572497,36541509,
36572798,36551783,36544913,36533859,36532982,36670319,36531023,36532081,36551302,36566424,
36543114,36542163,36542164,36530178,36570702,36544478,36519246,36569614,36553586);
commit;