REM  tx_run_cc.bat
REM  This program will run the Kettle job necessary to initialize the Contact Center data mart

set PROGNAME=%~nx0
echo "Start of program:  %PROGNAME%"

REM Date/Time formatting
call yesterday.bat 
set DATETIME=%Today%_%time:~0,2%%time:~3,2%%time:~6,2%
REM Remove any spaces in DATETIME
set DATETIME=%DATETIME: =% 
echo %DATETIME%

set JOBS_DIR=%MAXDAT_ETL_PATH%/ContactCenter/main/jobs
set INIT_JOB=load_Contact_Center
set PARAMS=%MAXDAT_ETL_PATH%/ContactCenter/main/conf/config.properties

set LOG_DIR=%MAXDAT_ETL_LOG%/CONTACT_CENTER/LOG
set ERR_DIR=%MAXDAT_ETL_LOG%/CONTACT_CENTER/ERROR

set BASIC_LOG_LEVEL="Basic"
set DETAIL_LOG_LEVEL="Detailed"

REM  email-related variables
REM set EMAIL="CecilBeeland@maximus.com"
REM set EMAIL_MESSAGE="%ERR_DIR%/%INIT_JOB%_ERROR_LOG.log"
REM set EMAIL_SUBJECT="Errors with %INIT_JOB%"

REM  detect if a log file already exists for this run, then run the job
 IF NOT EXIST %LOG_DIR%\%INIT_JOB%%DATETIME%.log (
     echo "No log file found.  Creating log file and running job(s)..."
    REM  ensure the directory structure matches and the desired kjb/ktr files are specified
     %KITCHEN_HOME%\kitchen.bat /file=%JOBS_DIR%\%INIT_JOB%.kjb > %LOG_DIR%\%INIT_JOB%%DATETIME%.log 
	 )
   else (
     echo "Log file found.  Appending to log file and running job(s)..."
    REM  ensure the directory structure matches and the desired kjb/ktr files are specified
    %KITCHEN_HOME%\kitchen.bat /file=%JOBS_DIR%\%INIT_JOB%.kjb >> %LOG_DIR%\%INIT_JOB%%DATETIME%.log 
	)

REM  email completion status of job(s)
REM wait
REM 	if [ $rc==0 ]
REM 	  then
		 	REM  sucess
REM 			echo "%DATETIME%:  Child processes completed successfully." >> %EMAIL_MESSAGE%
REM 			mail -s "%EMAIL_SUBJECT%" "%EMAIL%" < %EMAIL_MESSAGE%

REM 		else
			REM  failure
REM 		 	echo "%DATETIME%:  TX - Update of the Contact Center data mart failed.  Check error logs for more details." >> %EMAIL_MESSAGE%
REM 	  	mail -s "%EMAIL_SUBJECT%" "%EMAIL%" < %EMAIL_MESSAGE%
REM 		 	cat %EMAIL_MESSAGE%
REM 	fi

REM  end
echo "End of program:  %PROGNAME%"

REM  -----KITCHEN STATUS CODES--------
REM  0 	The job ran without a problem.
REM  1 	Errors occurred during processing
REM  2 	An unexpected error occurred during loading or running of the job
REM  7 	The job couldn't be loaded from XML or the Repository
REM  8 	Error loading steps or plugins (error in loading one of the plugins mostly)
REM  9 	Command line usage printing

REM ----------------------------------------------------------------------------------------------------------------------------------------------------
REM -- Function section starts below here
REM ----------------------------------------------------------------------------------------------------------------------------------------------------

REM	----------------------------------------------------------------
REM	Function for exit due to fatal program error
REM		Accepts 1 argument:
REM			string containing descriptive error message
REM	----------------------------------------------------------------
REM :error_exit
REM 	echo %PROGNAME%: ${1:-"Unknown Error"} 1>&2
REM 	exit 1
REM goto:eof