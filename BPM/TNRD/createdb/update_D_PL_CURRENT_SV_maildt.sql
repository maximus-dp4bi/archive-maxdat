alter session set current_schema = MAXDAT;

--UPDATE MAIL DATES FOR DIFFERENCES BETWEEN ATS AND MAXDAT

UPDATE CORP_ETL_PROC_LETTERS pl
SET pl.MAILED_DT =  
(SELECT letter_mailed_date
FROM letters_stg ls
WHERE pl.LETTER_REQUEST_ID = ls.letter_id
AND TRUNC(pl.MAILED_DT) <> TRUNC(ls.letter_mailed_date) 
)

commit;