kettle.properties should be copied into your home directory, e.g.
	~/.kettle/kettle.properties

shared.xml should be copied into your home directory, e.g.
	~/.kettle/shared.xml





The contents of the jdbc.properties file located in this directory should be merged 
with the jdbc.properties located in your PDI/Kettle installation directory under /simple-jndi, e.g.

	${PENTAHO_HOME}/simple-jndi/jdbc.properties
	
In order to have the jobs run using Kitchen, edit the Kitchen.bat file to include 
the KETTLE_JNDI_ROOT environment variable with a value of the directory to the 
jdbc.properties file you want to use, e.g.

	set OPT="%PENTAHO_DI_JAVA_OPTIONS%" ... "-DKETTLE_LOG_SIZE_LIMIT=%KETTLE_LOG_SIZE_LIMIT%"
	
	becomes
	
	set OPT="%PENTAHO_DI_JAVA_OPTIONS%" ... "-DKETTLE_LOG_SIZE_LIMIT=%KETTLE_LOG_SIZE_LIMIT%" "-DKETTLE_JNDI_ROOT=%KETTLE_DIR%\simple-jndi"