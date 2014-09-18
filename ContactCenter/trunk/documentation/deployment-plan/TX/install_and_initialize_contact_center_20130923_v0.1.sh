#!/bin/sh
. ~/.profile

# CREATE CONTACT CENTER ETL DIRECTORIES
mkdir $MAXDAT_ETL_PATH/scripts/ContactCenter
mkdir $MAXDAT_ETL_PATH/logs/ContactCenter

# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
unzip AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip $MAXDAT_ETL_PATH/ContactCenter

# MAKE SCRIPTS EXECUTABLE
chmod 755 $MAXDAT_ETL_PATH/ContactCenter/main/bin/*.sh

# RUN CONTACT CENTER INITIALIZE JOB
nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/run_initialize_contact_center.sh &