-- Update Document_Type in D_PL_LETTER_SUBTYPE 

Update D_PL_LETTER_SUBTYPE
set Document_Type = 'Income - 3 Month Retro'
where Document_type = 'Income'
;

Update D_PL_LETTER_SUBTYPE
set Document_Type = 'Proof of TPHI'
where Document_Type = 'Third Party Health Insurance'
;

Commit;
