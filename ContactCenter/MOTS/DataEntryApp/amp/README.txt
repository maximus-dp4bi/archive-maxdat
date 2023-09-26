AMP Webapp 

--------------------------------------------------------------------------------


To get started, please complete the following steps:


1. Install Java JDK 1.7.0_67+ (Do not use Java 8)

2. Install Maven 3.2.3+

3. Set MAVEN_OPTS environment 
MAVEN_OPTS=-Xms512m -Xmx1024m -XX:PermSize=256M -XX:MaxPermSize=512M -Xdebug -agentlib:jdwp=transport=dt_socket,address=4000,server=y,suspend=n

3. Set up local instance of Oracle and create amp user by running db-scripts/CREATE_USER_amp.sql.

4. Install Oracle ojdbc6.jar into .m2 repository by running lib/mvn-install.bat

5. Enable remote debugging in Eclipse 
Append the following to MAVEN_OPTS, -Xdebug -agentlib:jdwp=transport=dt_socket,address=4000,server=y,suspend=n
Add debug configuration in Eclipse per http://www.eclipse.org/jetty/documentation/9.1.1.v20140108/debugging-with-eclipse.html using port 4000 

6. Add local ldap.properties file to C:\\Software\\amp\\conf\\ldap.properties
This may require setup of local LDAP server (OpenLDAP) or refactor local profile to use embedded Spring LDAP server in order to dev/unit test LDAP.
Otherwise, providing the following properties will allow the application to run but not authenticate against LDAP.

ldap.server.url=ldap://dummy:389
ldap.manager.dn=cn=dummy
ldap.manager.password=password
ldap.user.search.baseurl=
ldap.user.search.filter=(sAMAccountName={0})

7. Add local jdbc.properties file to C:\\Software\\amp\\conf\\jdbc.properties
This may require setup of local LDAP server (OpenLDAP) or refactor local profile to use embedded Spring LDAP server in order to dev/unit test LDAP.
Otherwise, providing the following properties will allow the application to run but not authenticate against LDAP.

jdbc.driverClassName=oracle.jdbc.OracleDriver
jdbc.url=jdbc:oracle:thin:@127.0.0.1:1521:XE <----  update the url to match your local db config
jdbc.username=amp
jdbc.password=max1mu$
jdbc.validationQuery=SELECT 1 + 1 from DUAL

hibernate.dialect=org.hibernate.dialect.Oracle10gDialect

# Needed by Hibernate3 Maven Plugin defined in pom.xml
hibernate.connection.username=amp
hibernate.connection.password=max1mu$
hibernate.connection.url=jdbc:oracle:thin:@127.0.0.1:1521:XE <----  update the url to match your local db config
hibernate.connection.driver_class=oracle.jdbc.OracleDriver

8. Run "mvn clean install -Dskip.ddl=false -Dskip.dbunit=false" from project root directory

9. Run "mvn jetty:run" from project root directory and view the application at http://localhost:8008

10. Commonly used maven commands

	Run local instance of jetty for debugging
		mvn clean jetty:run
	
	Refresh local database with test data
		mvn clean test-compile -Dskip.dbunit=false
	
	Build .war file for deployment to MAP DEV
		mvn clean package -Pmaxdatdev,!local
		
	Build .war file for deployment to AMP UAT
		mvn clean package -Puat,!local
		
	Build .war file for deployment to AMP PROD
		mvn clean package -Pprd,!local



***************    SERVER DETAILS   ******************


UAT Server URLs
maxamp-uat.maxcorp.maximus:443 (load balancer/VIP) 
caru1oowe01mx.maximus.com:8000 (Apache web server 1) 
caru1oowe02mx.maximus.com:8000 (Apache web server 2) 
rcsvap01.maximus.com:12000 (Tomcat application server 1) 
rcsvap02:12000 (Tomcat application server 2) 

UAT ISG Health Check page URLs
http://rcsvap01.maximus.com:12000/isgappadmin/hc.jsp
http://rcsvap02.maximus.com:12000/isgappadmin/hc.jsp
http://caru1oowe01mx.maximus.com:8000/isgappadmin/hc.jsp
http://caru1oowe02mx.maximus.com:8000/isgappadmin/hc.jsp
https://maxamp-uat.maxcorp.maximus/isgappadmin/hc.jsp

UAT AMP Data Capture URL
https://maxamp-uat.maxcorp.maximus


UAT Database TNS
MOTSMXDU =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = rcmxdb07.maximus.com)(PORT = 1564))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = motsmxdu.maximus.com)
    )
  )

UAT Application Server Directories
/u01/maximus/maxdatuat-amp/conf (configuration files)
/u01/maximus/maxdatuat-amp/webapps (war files)
/u01/maximus/maxdatuat-amp/logs (log files)


PROD Server URLs
maxamp.maximus.com:443 (load balancer/VIP) 
rsmxap31.maximus.com:12000 (Apache web server 1) 
rsmxap32.maximus.com:12000 (Apache web server 2) 
varp1oowb01mx.maximus.com:8000 (Tomcat application server 1) 
varp1oowb02mx.maximus.com:8000 (Tomcat application server 2)  

PROD ISG Health Check page URLs
http://rsmxap31.maximus.com:12000/isgappadmin/hc.jsp
http://rsmxap32.maximus.com:12000/isgappadmin/hc.jsp
http://varp1oowb01mx.maximus.com:8000/isgappadmin/hc.jsp
http://varp1oowb02mx.maximus.com:8000/isgappadmin/hc.jsp
https://maxamp.maximus.com/isgappadmin/hc.jsp

PROD AMP Data Capture URL
https://maxamp.maximus.com


PROD Database TNS
motsmxdp =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = rsotdb01.maximus.com)(PORT = 1564))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = motsmxdp.maximus.com)
    )
)

PROD Application Server Directories
/u01/maximus/maxdatprd-amp/conf (configuration files)
/u01/maximus/maxdatprd-amp/webapps (war files)
/u01/maximus/maxdatprd-amp/logs (log files)



Log Files:
YYYY-MM (Amp Data Capture application log archives)
amp.log (Amp Data Capture application log)
localhost.YYYY-MM-DD.log (Tomcat application server log)
catalina.YYYY-MM-DD.log (Tomcat application server log)
jvm.stdout.YYYY-MM-DD-HH-MM (JVM log)


***************    Unix Account Details  *************

In order to review application server files, directories and log files, each
developer should request accounts on the UAT and PROD Tomcat application servers.
In UAT the accounts should be added to the "maxampuat" group and in PROD, the accounts
should be added to the "maxampprd" group.

