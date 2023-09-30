***** MODIFICATION HISTORY ****************************************************************************
Instructions to Create the new directory scructure for NYEC
----------------
2013/10/25 Dave Dillon    - Created

******************************************************************************************************

------------------------------
1. Environment SECTION
------------------------------

#== Create the following directory with owner etladmin and permissions to match the existing directories
NOTE: "XXX" is "uat" or "prd" as appropriate

	mkdir /u01/maximus/maxdat-XXX/NY
	chown etladmin.etladmin /u01/maximus/maxdat-XXX/NY
	chmod 770 etladmin.etladmin /u01/maximus/maxdat-XXX/NY
	chmod g+s etladmin.etladmin /u01/maximus/maxdat-XXX/NY


#== Login or SU to user etladmin and run the following command
	cp -R /u01/maximus/maxbi-dev/ETL /u01/maximus/maxdat-dev/NY

	mkdir /u01/maximus/maxdat-dev/NY/config
	cp -R $HOME/.kettle /u01/maximus/maxdat-dev/NY/config


#== Remove the following lines from the file: /home/etladmin/.bash_profile
  export PENTAHO_JAVA_HOME="/u01/app/appadmin/product/java/jdk1.6.0_31"
  PATH="$PATH:/usr/bin"
  export PATH

  ###############################################################################
  # USER SPECIFIC CUSTOMIZATIONS (Try to incorporate into Standard Files)
  ###############################################################################
  #ulimit -n 326994
  export ENV_CODE="dev"
  #export ENV_CODE="uat"
  #export ENV_CODE="prd"
  export MAXDAT_KETTLE_DIR="/u01/app/appadmin/product/pentaho/data-integration"


  #NYEC-2478
  export MAXDAT_ETL_DIR="/u01/maximus/maxbi-$ENV_CODE"
  export KETTLE_NY_HOME="/home/etladmin"

  #MAXDAT-400
  export MAXDAT_ETL_PATH="/u01/maximus/maxdat-$ENV_CODE"
  export KETTLE_IL_HOME="/u01/maximus/maxdat-$ENV_CODE/IL/config"



------------------------------
2. Scripts SECTION
------------------------------
