Update nyhx_etl_idr_incidents i
set last_update_by_dt = (select iH.update_ts from INCIDENT_HEADER_stg IH where i.incident_id = ih.incident_header_id)
where  i.incident_id > 26036846;


Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26305924,'Level of APTC/Cost Sharing Reduction');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26317726,'Level of APTC/Cost Sharing Reduction');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26320213,'Level of APTC/Cost Sharing Reduction');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26307000,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26307065,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26317130,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26318056,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26318686,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26318747,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26319204,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26320597,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26320941,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26321628,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26322131,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26316989,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26317726,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26319821,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26325945,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26328730,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26324771,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26327016,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26327945,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26329005,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26329146,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26332108,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26319931,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26323197,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26324762,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26326941,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26328730,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26330865,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26331402,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26332471,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26332962,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26308660,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26310804,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314364,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314710,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26315336,'Eligibility Determination');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26307780,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26308229,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26309648,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26310353,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314126,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314094,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314927,'Other');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26310177,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26311239,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26312415,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26312505,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26314364,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26317868,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26319680,'Denial of Special Enrollment Period (SEP)');
Insert into NYHX_ETL_IDR_INCIDENT_RSN (NEIIR_ID,INCIDENT_ID,INCIDENT_REASON) values (null ,26372831,'Other');


commit;
 

