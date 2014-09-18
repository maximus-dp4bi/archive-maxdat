# Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN
#     and used later to identify deployed code.
# $URL$
# $Revision$
# $Date$
# $Author$

MAIL=/usr/mail/${LOGNAME:?}

# Setting Location Vars
MAXDAT_ETL_PATH=/ptxe4t/ETL_Scripts/scripts
MAXDAT_ETL_LOGS=/ptxe4t/ETL_Logs/logs
MAXDAT_KETTLE_DIR=/ptxe4t/3rdparty/app/product/kettle/4.2/data-integration
STCODE=TX

export MAXDAT_ETL_PATH
export MAXDAT_ETL_LOGS
export MAXDAT_KETTLE_DIR
export STCODE

PATH=$MAXDAT_KETTLE_DIR:/usr/bin::/usr/X11/lib:/usr/X11/bin/:/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/dtxe4t/3rdparty:/usr/X/bin
export PATH;
