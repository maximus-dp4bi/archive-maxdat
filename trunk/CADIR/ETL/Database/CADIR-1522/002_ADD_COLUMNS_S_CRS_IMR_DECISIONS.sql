alter table S_CRS_IMR_DECISIONS 
  ADD (M_DWC_SENT VARCHAR2(1) DEFAULT 'N'
       ,M_DWC_SENT_DATE DATE);
       