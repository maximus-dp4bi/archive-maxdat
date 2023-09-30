/*
Created on 10-Jun-2014 by Raj A.
These existed in ILEB Process Letters, adding to the NYHIX project too.
*/
create index LETTER_CASE_ID_IDX on LETTERS_STG (LETTER_CASE_ID)
  tablespace MAXDAT_DATA;

create index LETTER_REQ_ON_IDX on LETTERS_STG (LETTER_REQUESTED_ON)
  tablespace MAXDAT_DATA;