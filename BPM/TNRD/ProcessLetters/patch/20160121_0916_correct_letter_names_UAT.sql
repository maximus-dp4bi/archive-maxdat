      UPDATE letters_stg
      SET letter_type = 'TN 402 Redetermination Approval for Medicaid'
      WHERE letter_type = 'Redetermination Approval for Medicaid';
      
      UPDATE letters_stg
      SET letter_type = 'TN 401a LTSS Initial Renewal Packet'
      WHERE letter_type = 'LTSS Initial Renewal Packet';
      
      UPDATE letters_stg
      SET letter_type = 'TN 412 Need to Re-apply'
      WHERE letter_type = 'Need to Re-apply';
      
      UPDATE letters_stg
      SET letter_type = 'TN 405 Redetermination Approval for CoverKids'
      WHERE letter_type = 'Redetermination Approval for CoverKids';
      
      UPDATE letters_stg
      SET letter_type = 'TN 411 Termination for Failure to Respond'
      WHERE letter_type = 'Termination for Failure to Respond';
      
      UPDATE letters_stg
      SET letter_type = 'TN 403 Redetermination Approval for MSP only'
      WHERE letter_type = 'Redetermination Approval for MSP only';
      
      UPDATE letters_stg
      SET letter_type = 'TN 401 Initial Renewal Packet (MAGI)'
      WHERE letter_type = 'Initial Renewal Packet (MAGI)';

      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 402 Redetermination Approval for Medicaid'
      WHERE letter_type = 'Redetermination Approval for Medicaid';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 401a LTSS Initial Renewal Packet'
      WHERE letter_type = 'LTSS Initial Renewal Packet';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 412 Need to Re-apply'
      WHERE letter_type = 'Need to Re-apply';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 405 Redetermination Approval for CoverKids'
      WHERE letter_type = 'Redetermination Approval for CoverKids';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 411 Termination for Failure to Respond'
      WHERE letter_type = 'Termination for Failure to Respond';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 403 Redetermination Approval for MSP only'
      WHERE letter_type = 'Redetermination Approval for MSP only';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 401 Initial Renewal Packet (MAGI)'
      WHERE letter_type = 'Initial Renewal Packet (MAGI)';
      
      UPDATE corp_etl_proc_letters
      SET letter_type = 'TN 406a Request for AI - Income'
      WHERE letter_type = 'Request for AI - Income';

UPDATE corp_etl_list_lkup SET value = 'TN 401a LTSS Initial Renewal Packet' WHERE value = 'LTSS Initial Renewal Packet';
UPDATE corp_etl_list_lkup SET value = 'TN 402 Redetermination Approval for Medicaid' WHERE value = 'Redetermination Approval for Medicaid';
UPDATE corp_etl_list_lkup SET value = 'TN 403 Redetermination Approval for MSP only' WHERE value = 'Redetermination Approval for MSP only';
UPDATE corp_etl_list_lkup SET value = 'TN 404 Redetermination Approval for Standard' WHERE value = 'Redetermination Approval for Standard';
UPDATE corp_etl_list_lkup SET value = 'TN 405 Redetermination Approval for CoverKids' WHERE value = 'Redetermination Approval for CoverKids';
UPDATE corp_etl_list_lkup SET value = 'TN 406a Request for AI - Income' WHERE value = 'Request for AI - Income';
UPDATE corp_etl_list_lkup SET value = 'TN 406b Request for AI - Identity and Income' WHERE value = 'Request for AI - Identity and Income';
UPDATE corp_etl_list_lkup SET value = 'TN 406c Request for AI - Citizenship' WHERE value = 'Request for AI - Citizenship';
UPDATE corp_etl_list_lkup SET value = 'TN 406d Request for AI - Residency' WHERE value = 'Request for AI - Residency';
UPDATE corp_etl_list_lkup SET value = 'TN 406e Request for AI - SSN' WHERE value = 'Request for AI - SSN';
UPDATE corp_etl_list_lkup SET value = 'TN 406f Request for AI - Clarification for Transitional/Extended Medicaid' WHERE value = 'Request for AI - Clarification for Transitional/Extended Medicaid';
UPDATE corp_etl_list_lkup SET value = 'TN 406g Request for AI – Access to or Enrolled' WHERE value = 'Request for AI – Access to or Enrolled';
UPDATE corp_etl_list_lkup SET value = 'TN 406h Request for AI - Signature needed' WHERE value = 'Request for AI - Signature needed';
UPDATE corp_etl_list_lkup SET value = 'TN 406i Request for AI – Proof of Medical Eligibility' WHERE value = 'Request for AI – Proof of Medical Eligibility';
UPDATE corp_etl_list_lkup SET value = 'TN 406j Request for AI – Proof No Pregnancy Benefits' WHERE value = 'Request for AI – Proof No Pregnancy Benefits';
UPDATE corp_etl_list_lkup SET value = 'TN 407 Not Subject to Redetermination' WHERE value = 'Not Subject to Redetermination';
UPDATE corp_etl_list_lkup SET value = 'TN 408 Denial/Termination' WHERE value = 'Denial/Termination';
UPDATE corp_etl_list_lkup SET value = 'TN 409 Denial for 90 Day Period' WHERE value = 'Denial for 90 Day Period';
UPDATE corp_etl_list_lkup SET value = 'TN 410 Termination (Non-MAGI)' WHERE value = 'Termination (Non-MAGI)';
UPDATE corp_etl_list_lkup SET value = 'TN 401R Initial Renewal Packet (MAGI) Reprint' WHERE value = 'Initial Renewal Packet (MAGI) Reprint';
UPDATE corp_etl_list_lkup SET value = 'TN 401aR LTSS Initial Renewal Packet Reprint' WHERE value = 'LTSS Initial Renewal Packet Reprint';
UPDATE corp_etl_list_lkup SET value = 'TN 412 Need to Re-apply' WHERE value = 'Need to Re-apply';
UPDATE corp_etl_list_lkup SET value = 'TN 401 Initial Renewal Packet (MAGI)' WHERE value = 'Initial Renewal Packet (MAGI)';
UPDATE corp_etl_list_lkup SET value = 'TN 411 Termination for Failure to Respond' WHERE value = 'Termination for Failure to Respond';
UPDATE corp_etl_list_lkup SET value = 'TN 408ftp Denial/Termination - Failure to Respond' WHERE value = 'Denial/Termination - Failure to Respond';
UPDATE corp_etl_list_lkup SET value = 'TN 409ftp Denial for 90 Day Period - Failure to Respond' WHERE value = 'Denial for 90 Day Period - Failure to Respond';
UPDATE corp_etl_list_lkup SET value = 'TN 405a Approval for CoverKids during 90 day reconsideration' WHERE value = 'Redetermination Approval for CoverKids during 90 day reconsideration';

commit;