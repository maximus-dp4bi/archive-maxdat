--- change to convert back to numbers in dev and UAT.
--- view does calculations better to do cast to number in ETL

ALTER TABLE LETTER_OUT_DATA_CONTENT_STG
ADD (temp_monthlyincome          number
     ,temp_monthlythresholdchip  number
     ,temp_monthlythresholdmed   number
     ,temp_monthlythresholdqdwi  number
     ,temp_monthlythresholddq1   number
     ,temp_monthlythresholdqmb   number
     ,temp_monthlythresholdlmb   number
     ,temp_spenddown             number
     ,temp_jobid                 number
);



UPDATE /*+ Enable_Parallel_Dml Parallel */ letter_out_data_content_stg
SET 		      temp_monthlyincome	    =	MAGIMONTHLYINCOMEVALUE
                ,temp_monthlythresholdchip	=	MAGIMONTHLYTHRESHOLDCHIPVALUE
                ,temp_monthlythresholdmed	=	MAGIMONTHLYTHRESHOLDMEDVALUE
                ,temp_monthlythresholdqdwi	=	MAGIMONTHLYTHRESHOLDQDWIVALUE
                ,temp_monthlythresholddq1	=	MAGIMONTHLYTHRESHOLDQI1VALUE
                ,temp_monthlythresholdqmb	=	MAGIMONTHLYTHRESHOLDQMBVALUE
                ,temp_monthlythresholdlmb	=	MAGIMONTHLYTHRESHOLDSLMBVALUE
                ,temp_spenddown	=	SPENDDOWNAMOUNTVALUE
                ,temp_jobid  = JOB_ID
                ;

commit;

ALTER TABLE LETTER_OUT_DATA_CONTENT_STG
DROP(MAGIMONTHLYINCOMEVALUE,MAGIMONTHLYTHRESHOLDCHIPVALUE,
      MAGIMONTHLYTHRESHOLDMEDVALUE,MAGIMONTHLYTHRESHOLDQDWIVALUE,
      MAGIMONTHLYTHRESHOLDQI1VALUE,MAGIMONTHLYTHRESHOLDQMBVALUE,
      MAGIMONTHLYTHRESHOLDSLMBVALUE,SPENDDOWNAMOUNTVALUE,JOB_ID
      );

ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlyincome        TO MAGIMONTHLYINCOMEVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholdchip TO MAGIMONTHLYTHRESHOLDCHIPVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholdmed  TO MAGIMONTHLYTHRESHOLDMEDVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholdqdwi TO MAGIMONTHLYTHRESHOLDQDWIVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholddq1  TO MAGIMONTHLYTHRESHOLDQI1VALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholdqmb  TO MAGIMONTHLYTHRESHOLDQMBVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_monthlythresholdlmb  TO MAGIMONTHLYTHRESHOLDSLMBVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_spenddown            TO SPENDDOWNAMOUNTVALUE;
ALTER TABLE LETTER_OUT_DATA_CONTENT_STG RENAME COLUMN temp_jobid                TO JOB_ID;

create index IDX02_LETTER_OUT_DATA_CONTENT_STG ON letter_out_data_content_stg (letter_out_data_id) tablespace maxdat_indx;