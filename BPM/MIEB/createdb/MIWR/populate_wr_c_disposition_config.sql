
INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('NOANS','Ring no answer','N',sysdate,sysdate,user,user);

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('ANSMACH','Answering machine or voicemail answered','Y',sysdate,sysdate,user,user);

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('INVLDNUM','Invalid phone number','N',sysdate,sysdate,user,user);

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('BUSY','Busy signal','N',sysdate,sysdate,user,user);          	

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('FAX','Fax or modem line was encountered','N',sysdate,sysdate,user,user);           	
             	
INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('ERROR NO XFER NUM','No transfer number was found','N',sysdate,sysdate,user,user);           	

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('LIVE','Live caller was reached','Y',sysdate,sysdate,user,user);           	
                   	
INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('HANGUP','Caller hung up','N',sysdate,sysdate,user,user);           		

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('TRANSFER','Caller was transferred','Y',sysdate,sysdate,user,user);           		             	

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('ERROR','Unknown error encountered calling phone number','N',sysdate,sysdate,user,user);           		             	           	
         	
INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('NOTCALLED','Call was not placed due to lack of data in the dial file or an invalid phone number.','N',sysdate,sysdate,user,user);           		             	           	

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('IVR','Caller was transferred to IVR','Y',sysdate,sysdate,user,user);           		             	           	

INSERT INTO wr_c_disposition_config(disposition_code,disposition_description,success_disposition_indicator,create_date,update_date,created_by,updated_by)
VALUES('UNDEFINED','Undefined Disposition','N',sysdate,sysdate,user,user);           		             	           	               	
        	
COMMIT;	