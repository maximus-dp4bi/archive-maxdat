/*
Created on 31-Dec-2013 by Raj A.
Process: TXEB Run Initialization
Dropping indexes so we can truncate the Letters_STG table and reload 4.8M letters. After reload, we will recreate the indexes.
*/
drop index LETTERS_ID_STG_IDX;
drop index LETTERS_REQUEST_TYPE_STG_IDX;
drop index LETTERS_SENT_ON_STG_IDX;
drop index LETTERS_STG_IDX;
drop index LETTERS_TYPE_CD_STG_IDX;
drop index LETTER_CASE_ID_IDX;
drop index LETTER_REQ_ON_IDX;