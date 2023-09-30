#FLHK Cisco
FLEBHDS/type=javax.sql.DataSource
FLEBHDS/driver=net.sourceforge.jtds.jdbc.Driver
FLEBHDS/url=jdbc:jtds:sqlserver://10.2.70.50/pcce_hds
FLEBHDS/user=MaxDat
FLEBHDS/password=M@xD@t2014$
#FLHK MAXDAT QA
MAXDATQA/type=javax.sql.DataSource
MAXDATQA/driver=oracle.jdbc.driver.OracleDriver
MAXDATQA/url=jdbc:oracle:thin:@10.3.160.240:1521:DVORASM3
MAXDATQA/user=FLCDV0_MAXDAT
MAXDATQA/password=FLCDV0_MAXDAT
#FLHK MAXDAT Production
FLMAXDAT/type=javax.sql.DataSource
FLMAXDAT/driver=oracle.jdbc.driver.OracleDriver
FLMAXDAT/url=jdbc:oracle:thin:@10.2.130.212:1522:PRDORA04
FLMAXDAT/user=FLCPD0_MAXDAT
FLMAXDAT/password=r3p0rting
#FLHK KOFAX Central
FLKOFAX/type=javax.sql.DataSource
FLKOFAX/driver=net.sourceforge.jtds.jdbc.Driver
FLKOFAX/url=jdbc:jtds:sqlserver://10.2.130.106/FLCCOFAXPRD
FLKOFAX/user=etladmin
FLKOFAX/password=$3TL4DmIN@!
# FLHK NICEWFM
FLCNICEWFM/type=javax.sql.DataSource
FLCNICEWFM/driver=org.postgresql.Driver
FLCNICEWFM/url=jdbc:postgresql://10.2.70.232:5432/customer1
FLCNICEWFM/user=71980
FLCNICEWFM/password=Password71980

