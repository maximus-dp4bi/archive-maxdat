CREATE TABLE hco_s_bad_address_stg
(DimBadAddressId NUMBER(10)
 ,DimBeneficiaryId NUMBER(10)
 ,FileName VARCHAR2(50)
 ,DeIdentificationCIN VARCHAR2(9)
 ,MailType VARCHAR2(2)
 ,MailDate DATE
 ,TransactionType VARCHAR2(10)
 ,CountyCode VARCHAR2(2)
 ,SuccessFlag VARCHAR2(1)
 ,ErrorMessage VARCHAR2(200)
 ,RecordCreateDate DATE
 ,RecordLoadDate DATE) TABLESPACE MAXDAT_DATA;
 
 CREATE INDEX IDX01_HCOSBADADDR_ADDRID ON hco_s_bad_address_stg(DimBadAddressId) TABLESPACE MAXDAT_INDX;
 CREATE INDEX IDX02_HCOSBADADDR_DCIN ON hco_s_bad_address_stg(DeIdentificationCIN) TABLESPACE MAXDAT_INDX;
 
 GRANT SELECT on HCO_S_BAD_ADDRESS_STG to MAXDAT_READ_ONLY;
