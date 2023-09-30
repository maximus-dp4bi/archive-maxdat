  
ALTER TABLE emrs_s_client_stg
MODIFY(client_number NUMBER(38,0)
       ,st VARCHAR2(30)
       ,last_name VARCHAR2(40)
       ,sex VARCHAR2(32)
       ,social_security_number VARCHAR2(30)
       ,race VARCHAR2(32)
       ,phone VARCHAR2(32)
       ,zip VARCHAR2(32));
       
ALTER TABLE emrs_d_client
MODIFY(client_number NUMBER(38,0)
       ,st VARCHAR2(30)
       ,last_name VARCHAR2(40)
       ,sex VARCHAR2(32)
       ,social_security_number VARCHAR2(30)
       ,race VARCHAR2(32)
       ,phone VARCHAR2(32)
       ,zip VARCHAR2(32));   