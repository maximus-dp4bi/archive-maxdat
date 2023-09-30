#!/bin/sh
. /home/appadmin/.bash_profile

# CREATE CONTACT CENTER ETL DIRECTORIES
mkdir $MAXDAT_ETL_PATH/ContactCenter
mkdir $MAXDAT_ETL_LOGS/ContactCenter

# CREATE CONTACT CENTER FILE PROCESSING DIRECTORIES
mkdir $ECHOPASS_PATH
mkdir $ECHOPASS_PATH/Error
mkdir $ECHOPASS_PATH/Error/ACD
mkdir $ECHOPASS_PATH/Error/IVR
mkdir $ECHOPASS_PATH/Error/WFM
mkdir $ECHOPASS_PATH/Inbound
mkdir $ECHOPASS_PATH/Inbound/ACD
mkdir $ECHOPASS_PATH/Inbound/IVR
mkdir $ECHOPASS_PATH/Inbound/WFM
mkdir $ECHOPASS_PATH/Inbound_archive
mkdir $ECHOPASS_PATH/Processing
mkdir $ECHOPASS_PATH/Processing/ACD
mkdir $ECHOPASS_PATH/Processing/IVR
mkdir $ECHOPASS_PATH/Processing/WFM
mkdir $MAXDAT_FORECAST_PATH
mkdir $MAXDAT_FORECAST_PATH/Inbound
mkdir $MAXDAT_FORECAST_PATH/Processing
mkdir $MAXDAT_FORECAST_PATH/Error
mkdir $MAXDAT_FORECAST_PATH/Completed

# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
unzip -o AS_PATCH_CONTACT_CENTER_20131015_Clay_v0.1.3.zip -d $MAXDAT_ETL_PATH/ContactCenter

# MAKE SCRIPTS EXECUTABLE
chmod 755 $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/*.sh

# RUN CONTACT CENTER INITIALIZE JOB
nohup $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/run_initialize_contact_center.sh &