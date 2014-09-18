Local Avaya Setup

Create a stub database for development purposes

Download Intersystems Cache database software

http://www.intersystems.com/library/software-downloads/
Select Free Cache' Evaluation download
Register
Select Product:  Cache' 2013.1.3
Select Platform:  Micrososft Windows ... x86-64
Install type:  .exe
Download Cache'


Create CCMS_STAT Namespace
Go to Management Portal
 - Select Windows -> All Programs -> Cache' -> TRYCACHE -> Management Portal
From Menu, select "Configure Namespaces"
Select "Create New Namespace"
 - Name of the namespace:  "CCMS_STAT"
 - The default database for this namespace is a "Local Database"
 - Select "Create New Database"
  - Enter the name of your database:  "CCMS_STAT"
  - Database directory:  "C:\InterSystems\TryCache\mgr\CCMS_STAT"
  - Select Next
  - Initial Size (MB): "1"
  - Journal Globals:  "Yes"
  - I want to Use the default resource, "%DB_%DEFAULT"
  - Select "Finish"
 - Select "Package Mappings"
  - Select "New Package Mapping"
  - Package database location:  "CCMS_STAT"
  - Package name:  Select "New Package"
   - New Package name:  "dbo"
   - Select "Ok"
  - Select "Save Changes"
  
  
Install SQuirreL SQL Client

http://squirrel-sql.sourceforge.net/#installation

Copy Cache' driver into SQuirreL lib folder, e.g.

C:\InterSystems\TryCache\lib\cachejdbc.jar
C:\Software\squirrel-sql-3.5.0\lib

