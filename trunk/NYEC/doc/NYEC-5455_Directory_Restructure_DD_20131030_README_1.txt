***** MODIFICATION HISTORY ****************************************************************************
Instructions to Create the new directory scructure for NYEC
----------------
2013/10/25 Dave Dillon    - Created

******************************************************************************************************

------------------------------
1. Environment SECTION
------------------------------
NOTE: "XXX" is "uat" or "prd" as appropriate
#== Create the following directory with owner etladmin and permissions to match the existing directories

	mkdir /u01/maximus/maxdat-XXX/NY
	chown etladmin.etladmin /u01/maximus/maxdat-XXX/NY
	chmod 770 etladmin.etladmin /u01/maximus/maxdat-XXX/NY
	chmod g+s etladmin.etladmin /u01/maximus/maxdat-XXX/NY


#== Login or SU to user etladmin and run the following command
	cp -R /u01/maximus/maxbi-xxx/ETL /u01/maximus/maxdat-xxx/NY

	mkdir /u01/maximus/maxdat-xxx/NY/config
	cp -R $HOME/.kettle /u01/maximus/maxdat-xxx/NY/config

#== Add a Profile Variable. Edit the .bash_profile for the etladmin user and add the following line
	export NY_SETENV=/u01/maximus/maxdat-xxx/NY/ETL/scripts/.set_env


------------------------------
2. Scripts SECTION
------------------------------
NOTE: "XXX" is "uat" or "prd" as appropriate
#== Copy the following files to /u01/maximus/maxdat-xxx/NY/ETL/scripts:
	svn://rcmxapp1d.maximus.com/maxdat/trunk/NYEC/ETL/scripts/run_bpm.sh
	svn://rcmxapp1d.maximus.com/maxdat/trunk/NYEC/ETL/scripts/run_Nightly_bpm.sh

#== Copy one of the two files to /u01/maximus/maxdat-xxx/NY/ETL/scripts according to environment (UAT=uat, Production=prd):
	svn://rcmxapp1d.maximus.com/maxdat/trunk/NYEC/ETL/scripts/ny_set_env_uat.txt
			-------  OR  ----------
	svn://rcmxapp1d.maximus.com/maxdat/trunk/NYEC/ETL/scripts/ny_set_env_prd.txt

#== Rename file:
NOTE: You may also wish to verify that all system paths are correct.
	FROM: ny_set_env_[uat/prd].txt
	TO:   .set_env

#== Run the followng commands in the /u01/maximus/maxdat-xxx/NY/ETL/scripts directory
	dos2unix -o run_bpm.sh
	dos2unix -o run_Nightly_bpm.sh
	dos2unix -o bpm_reset.sh
	dos2unix -o .set_env

#== Run the following commands in the /u01/maximus/maxdat-xxx/NY/ETL/scripts directory
	chmod +x run_bpm.sh
	chmod +x run_Nightly_bpm.sh
	chmod +x bpm_reset.sh


------------------------------
3. Environment Cleanup SECTION
------------------------------
NOTE: "XXX" is "uat" or "prd" as appropriate

#== After everything has been copied and verified, run the following command
	rm -R /u01/maximus/maxbi-xxx
