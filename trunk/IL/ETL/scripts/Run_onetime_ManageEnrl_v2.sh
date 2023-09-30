/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_NO_LONGER_ELIG_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_NEW_ENRL_PKT_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Plan_Selection.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_Plan_Slct_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Update_Enrollment_Status.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_Upd_Enrl_Status_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Calc_Age.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_Calc_Age_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_Apply_UPD_Rules_to_WIP.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_UPD_Rules_to_WIP_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_WIP_to_BPM_StageTable.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_WIP_to_BPM_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
/u01/app/appadmin/product/pentaho/data-integration/pan.sh -file="/u01/maximus/maxdat-dev/IL/ETL/scripts/ManageEnrollmentActivity/ManageEnroll_set_MAX_Clnt_enl_stat_ID.ktr" -level=Basic >> /u01/maximus/maxdat-dev/IL/ETL/logs/ManageEnrl_set_MAX_Clnt_enrl_stat_$(date +%Y%m%d_%H%M%S).log
#creates il_run_init_check.txt
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
