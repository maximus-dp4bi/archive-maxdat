@echo off
setlocal EnableDelayedExpansion
echo INFO: IMPORTANT - Set reposting configuration in the NICE SQL Server before running this script.

set log_dir=../log
if not exist "%log_dir%" (
  echo ERROR: Log directory %log_dir% does not exist.
  exit /b
)
set log_file=%log_dir%/repost_Avaya_intervals_into_NICE_db_%date:~-4%_%date:~-10,2%.log

echo INFO: Searching for missing intervals.
echo %date% %time% %username% INFO: Searching for missing intervals. >> "%log_file%"
sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -iC:\maximus\NICE\scripts\avaya_missed_interval_query.sql -s";" -oC:\maximus\NICE\scripts\tempMissedIntervals.tmp -W

for /f "skip=2 tokens=1,2,3,4,5,6* delims=;" %%j in (C:\maximus\NICE\scripts\tempMissedIntervals.tmp) do (

    set acd_number=%%j
    set acd_name=%%k
    set acd_timezone=%%l
    set acd_interval_startdate=%%m
    set acd_interval_enddate=%%n
    set acd_missing_hours=%%o

    if "!acd_number!"=="" (
        echo INFO: No missing intervals found.
        echo %date% %time% %username% INFO: No missing intervals found. >> "%log_file%"
        exit /b
    )
	
	echo INFO: Found missing interval for acd.!acd_number! {AcdId=!acd_number!;AcdName=!acd_name!;AcdLocalTimeZoneName=!acd_timezone!;StartMissingIntervalLocal=!acd_interval_startdate!; EndMissingIntervalLocal=!acd_interval_enddate!;MissingHours=!acd_missing_hours!}
	echo %date% %time% %username% INFO: Found Missing interval for acd.!acd_number! {AcdId=!acd_number!;AcdName=!acd_name!;AcdLocalTimeZoneName=!acd_timezone!;StartMissingIntervalLocal=!acd_interval_startdate!;EndMissingIntervalLocal=!acd_interval_enddate!;MissingHours=!acd_missing_hours!} >> "%log_file%"

	echo INFO: Updating database.
	echo %date% %time% %username% INFO: Updating database. >> "%log_file%"

	echo INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing';
	echo %date% %time% %username% INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'; >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing';"

	echo INFO: update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='!acd_interval_enddate!' where c_key='intervalEnd' and c_joboid='Symposium-Acd!acd_number!-Repost';
	echo %date% %time% %username% INFO: update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='!acd_interval_enddate!' where c_key='intervalEnd' and c_joboid='Symposium-Acd!acd_number!-Repost'; >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='!acd_interval_startdate!' where c_key='intervalStart' and c_joboid='Symposium-Acd!acd_number!-Repost';"

	echo INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'
	echo %date% %time% %username% INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing' >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='!acd_interval_enddate!' where c_key='intervalEnd' and c_joboid='Symposium-Acd!acd_number!-Repost';"

	set repost_script=repost_Avaya_intervals_into_NICE_db_acd.!acd_number!.jmx
	if exist "!repost_script!" (

		echo INFO: Reposting intervals for acd.!acd_number! started.
		echo %date% %time% %username% INFO: Reposting Avaya intervals for acd.!acd_number! into the NICE db. >> "%log_file%"
		/totalview/jdk/bin/java -jar /totalview/inst/tv4/prod/bin/jmxterm-1.0-alpha-4-uber-jb7.jar -i "!repost_script!"

	) else (

		echo ERROR: Repost JMX console script !repost_script! not found.
		echo %date% %time% %username% ERROR: Repost JMX Console script !repost_script! not found. >> "%log_file%"
		exit /b
	)

	echo INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='F', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'
	echo %date% %time% %username% INFO: update [nice_wfm_customer1].dbo.r_features set c_enabled='F', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing' >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "update [nice_wfm_customer1].dbo.r_features set c_enabled='F', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'"

	echo INFO: Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'F' where c_oid= 'Symposium-Acd!acd_number!-Repost'
	echo %date% %time% %username% INFO: Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'F' where c_oid= 'Symposium-Acd!acd_number!-Repost' >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'F' where c_oid= 'Symposium-Acd!acd_number!-Repost'"

	echo INFO: Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'T' where c_oid= 'Symposium-Acd!acd_number!-Repost'
	echo %date% %time% %username% INFO: Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'T' where c_oid= 'Symposium-Acd!acd_number!-Repost' >> "%log_file%"
	sqlcmd -S COCP1MMSQL01WFM -d nice_wfm_system -U SVC_NICE -P "N1CePaSSwOrD2" -Q "Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'T' where c_oid= 'Symposium-Acd!acd_number!-Repost'"
)
@echo on