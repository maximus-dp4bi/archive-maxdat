/*
Created on 26-Feb-2014 by Raj A.
Decsription:
D_PL_CURRENT has incorrect letter_type column size. Changing from 64 bytes to 100 to match the BPM ETL stage table.
*/

ALTER TABLE D_PL_CURRENT MODIFY LETTER_TYPE VARCHAR2(100);