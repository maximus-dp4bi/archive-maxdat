#!/bin/sh

# set local variables for use below
set MAXDAT_ETL_PATH="/u01/maximus/maxdat-int/HCCHIX/ETL/scripts"
set MAXDAT_ETL_LOGS="/u01/maximus/maxdat-int/HCCHIX/ETL/logs" 
set ECHOPASS_PATH="/u01/maximus/maxdat-int/HCCHIX/Echopass"
set MAXDAT_FORECAST_PATH="/u01/maximus/maxdat-int/HCCHIX/forecasts"

# CREATE CONTACT CENTER ETL DIRECTORIES
mkdir /u01/maximus/maxdat-int/HCCHIX/ETL/scripts/ContactCenter
mkdir /u01/maximus/maxdat-int/HCCHIX/ETL/logs/ContactCenter

# CREATE CONTACT CENTER FILE PROCESSING DIRECTORIES
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Error
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Error/ACD
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Error/IVR
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Error/WFM
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Inbound
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Inbound/ACD
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Inbound/IVR
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Inbound/WFM
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Inbound_archive
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Processing
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Processing/ACD
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Processing/IVR
mkdir /u01/maximus/maxdat-int/HCCHIX/Echopass/Processing/WFM
mkdir /u01/maximus/maxdat-int/HCCHIX/forecasts
mkdir /u01/maximus/maxdat-int/HCCHIX/forecasts/Inbound
mkdir /u01/maximus/maxdat-int/HCCHIX/forecasts/Processing
mkdir /u01/maximus/maxdat-int/HCCHIX/forecasts/Error
mkdir /u01/maximus/maxdat-int/HCCHIX/forecasts/Completed

# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
unzip AS_INITIAL_LOAD_CONTACT_CENTER_20130912_Clay_v0.1.zip -d /u01/maximus/maxdat-int/HCCHIX/ETL/scripts/ContactCenter

# MAKE SCRIPTS EXECUTABLE
chmod 755 /u01/maximus/maxdat-int/HCCHIX/ETL/scripts/ContactCenter/implementation/HIHIX/bin/*.sh

# RUN CONTACT CENTER INITIALIZE JOB
nohup /u01/maximus/maxdat-int/HCCHIX/ETL/scripts/ContactCenter/implementation/HIHIX/bin/run_initialize_contact_center.sh &