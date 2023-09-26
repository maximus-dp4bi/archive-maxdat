---- NYHIX-38326 
UPDATE Maxdat.corp_etl_proc_letters
SEt status= 'Voided'
where letter_request_id = 10218352;

COMMIT;