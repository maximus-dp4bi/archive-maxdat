# .set_env 
#
# =======================================================================
# Do not edit these four SVN_* variable values.  They are populated when 
#    you commit code to SVN and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$
# =======================================================================
#
# Set all of the exported environment variables in this file
# All environment specific variables should be included in this file
# Proper use of this file will allow the current scripts directory or the shell scripts to be copied from one environment, dev, uat or prd, to another without
# any modifications. The only file requiring modifications should be this one.
#
# The values for many of the variables are set to the default values currently in use. 
# Verify all default values to ensure they are correct
#
# Now a couple of file editing notes and tips
# 1. Simple string (text) variables that do not contain characters that the bash shell will interpret as special characters like '\' do not require quotes
#    But, if in doubt use single quotes they explicitly say 'this is a simple text string, don't interpret anything inside the single quotes'
# 2. Use single quotes to ensure strings with special characters are treated as simple strings
# 3. Use double quotes for variables that contain embedded variables, example MAXDAT_ETL_PATH="/u01/maximus/maxdat/$STCODE/scripts"
#    For multiple variables, or anytime for clarity, put {} around the embedded variables to ensure the shell identifies them correctly, 
#    example "/u01/maximus/maxdat/$STCODE/scripts" can also be written as
#    "/u01/maximus/maxdat/${STCODE}/scripts" 
#    also for something like this "/u01/maximus/maxdat/${STCODE}somethingelse/datafiles/" using {} ensures the shell interpreter gets it right
#    and sees a variable called $STCODE and not one called $STCODEsomethingelse
#
# All lines marked with a "#->" need to be set for the local server (and the "#->" removed)
#
# -----  MAXDAT VARIABLES  ----
# export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.6.0_45/'  
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.8.0_192/'  

# Set the ENV_CODE to the correct environment, dev, uat or prd
export ENV_CODE=dev

# Set the STCODE to the name of the project such as CAHCO, product (for product development), MI (Michigan), etc. This must match the value of the directory
export STCODE=LAEB 

# Variables for each MODULE in use: MW, ProductionPlanning, MailFaxDoc, MailFaxBatch, etc.
# The variable value must match the logs and scripts directories for the module
# MODULE_INIT holds the ETL for run_initialization which loads lookup/stg table data for multiple modules
# Uncomment (remove the '#') for modules in use and add module variables as necessary for new modules
export MODULE_MW=MW
export MODULE_MFB=MailFaxBatch
export MODULE_MFD=MailFaxDoc
export MODULE_PP=ProductionPlanning
export MODULE_CC=ContactCenter
export MODULE_IDR=IDR
export MODULE_APL=Appeals
export MODULE_PL=ProcessLetters
export MODULE_PC=ProcessComplaints
export MODULE_INIT=Initialization
export MODULE_EMRS=EMRS
export MODULE_LTR=Letters
export MODULE_CRI=CallsIncidents

# Path to the current kettle install
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/pentaho_8.3/data-integration'

export MAXDAT_ETL_PATH="/u01/maximus/maxdat/${STCODE}/scripts"
export MAXDAT_ETL_LOGS="/u01/maximus/maxdat/${STCODE}/logs"


# The datafiles directory is only used by modules that submit data in file format, csv, xlsx, text, etc
# The files will be placed in the <MODULE>/processing directory either by a Move-It job or manually
# The files will be moved from the <MODULE>/processing directory to the <MODULE>/completed directory by ETL or shell script
# Add the subdirectories in the datafiles directory for the module providing the data files
# Directories required are <MODULE>, <MODULE>/processing and <MODULE>/completed
# Replace <MODULE> with the variable name associated with the module 
# Uncomment (remove the '#') for modules in use and add module lines as necessary for new modules
# export MAXDAT_ETL_<MODULE>_PROCESSING="/u01/maximus/maxdat/$STCODE/datafiles/<MODULE>/processing"
# export MAXDAT_ETL_<MODULE>_COMPLETED="/u01/maximus/maxdat/$STCODE/datafiles/<MODULE>/completed"

export KETTLE_HOME="/u01/maximus/maxdat/${STCODE}/config"

export KTR_LOG_LEVEL='Basic'
export KJB_LOG_LEVEL='Detailed'
export INIT_OK="${MAXDAT_ETL_PATH}/${STCODE}_run_check.txt"
export CHILD_FAIL="/tmp/${STCODE}_child_task_fail.txt"
#
PATH="${KETTLE_HOME}/.kettle/kettle.properties:.:${MAXDAT_KETTLE_DIR}:/usr/bin:${PATH}"
export PATH
#
# ----  EMRS VARIABLES  -----
export EINIT_OK="${MAXDAT_ETL_PATH}/${STCODE}_emrs_init_check.txt"
export EMRS_DATA_DIR=${MAXDAT_ETL_PATH}/${MODULE_EMRS}/EnrollmentDataEMRS
#
# ----  MAIL VARIABLES  -----
#mail related variables
export EMAIL='MAXDatSystem@maximus.com'
export EMAIL_MESSAGE="/tmp/${STCODE}_run_bpm-ERROR-LOG.txt"
export EMAIL_SUBJECT="Errors With ${STCODE}_run_bpm.sh in $ENV_CODE"
#
# ----  P-PLANNING VARIABLES  ----
export PLANNING_OK="${MAXDAT_ETL_PATH}/${STCODE}_run_planning_check.txt"
export PLANNING_FAIL="${MAXDAT_ETL_PATH}/${STCODE}_child_planning_fail.txt"
#
# ----  OTHER VARIABLES  ----
export LOG_LIFE_DAYS=90 # Number of days to keep log files in the log directory before deleteing

