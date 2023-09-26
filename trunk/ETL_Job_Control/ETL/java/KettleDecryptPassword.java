
/*
================================================================================
 Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
     
   SVN_FILE_URL = $URL$
   SVN_REVISION = $Revision$
   SVN_REVISION_DATE = $Date$
   SVN_REVISION_AUTHOR = $Author$
 ================================================================================
Name: DecryptKettlePassword
Version: 1.0
Author: eb45730
Initial Version Date: 05/28/2020
Purpose: Decrypts a Kettle-encrypted password
Usage: java DecryptKettlePassword "Encrypted-Password" (note: the following must be included in the classpath:
     $MAXDAT_KETTLE_DIR/lib/*:$MAXDAT_KETTLE_DIR/lib;
     $MAXDAT_KETTL_DIR/plugins/pdi_core-plugins/*;
     $MAXDAT_KETTLE_DIR/plugins/ms-access-plugins/*;
     $MAXDAT_KETTLE_DIR/libswt/linux/x86_64/*;)
Input: a Kettle-encrypted password without the prefix "Encrypted " (for example a password encrypted by Encr.sh using -kettle as the first parameter);  
Output: the decrypted password
*/

import org.pentaho.di.core.encryption.*;
import org.pentaho.di.core.KettleEnvironment;

public class KettleDecryptPassword{

public static void main (String args[]){

String decryptedPassword = "";
String encryptedPassword = args[0];

try {
     
     KettleEnvironment.init();
     
     Encr myDecoder = new Encr();
     decryptedPassword = myDecoder.decryptPassword(encryptedPassword);

} catch (Exception e) { 
     System.err.println("An error has occurred attempting to decrypt a kettle password using DecryptKettlePassword "+e.getMessage());
     e.printStackTrace();
}

System.out.print(decryptedPassword);

}

}
