-- Process Letters history.

-- Logical table D_PL_LETTER_STATUS_SV.
select DESCRIPTION from EB.ENUM_LM_STATUS
union select null from dual;
