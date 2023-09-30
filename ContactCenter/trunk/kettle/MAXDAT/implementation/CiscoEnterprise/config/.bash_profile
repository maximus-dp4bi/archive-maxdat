###############################################################################
# .bash_profile
# Updated 10/18/2006 by Steve Falconer
#
# Wrapper for /home/maxutil/env/shared_bash_profile
#
# Located in user's $HOME directory
#
###############################################################################
# DO NOT EDIT THIS SECTION!
# 
# # User specific customizations are highly discouraged, but can be made in the 
# customizations section below
###############################################################################

# If /home/maxutil/env/shared_bash_profile exists, source it
if [ -f /home/maxutil/env/shared_bash_profile ]
then
. /home/maxutil/env/shared_bash_profile
fi

###############################################################################
# USER SPECIFIC CUSTOMIZATIONS (Try to incorporate into Standard Files)
###############################################################################

export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_45"
export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho/data-integration"
export ENV_CODE="prd"

#COEESMAP-2039

export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE"
export KETTLE_CO_HOME="/u01/maximus/maxdat-$ENV_CODE/CO/config"

#MAXDAT-2127
#MDHIX
export KETTLE_MDHIX_HOME="/u01/maximus/maxdat-$ENV_CODE/MDHIX/config"  

#MAXDAT-2949
#CiscoEnterprise
export KETTLE_CiscoEnterprise_HOME="/u01/maximus/maxdat-$ENV_CODE/CiscoEnterprise/config"  