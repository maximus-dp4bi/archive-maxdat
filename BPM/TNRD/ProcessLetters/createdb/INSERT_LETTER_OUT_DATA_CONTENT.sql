SELECT 
LETTER_OUT_DATA_ID  
,   LETTER_REQ_ID 
,   JOB_ID 
,   CREATE_TS 
,   UPDATE_TS  
,   UPDATED_BY, 
EXTRACTVALUE(xmltype(original_letter_content), '/letterOut/letterOutHeader/dateOfLetter', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as dateOfLetter,
EXTRACTVALUE(xmltype(original_letter_content), '/letterOut/letterOutHeader/respondByDate', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as respondByDate,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/coverageEndDate', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as coverageEndDateValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/Day20AppealDtBus', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as Day20AppealDtBusValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/Day40AppealDtBus', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as Day40AppealDtBusValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/Day40AppealDtCal', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as Day40AppealDtCalValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/effectiveDate', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as effectiveDatevalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyIncome', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyIncomeValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdCHIP', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyThresholdCHIPvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdMed', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as magiMonthlyThresholdMedValue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdQDWI', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyThresholdQDWIvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdQI1', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyThresholdQI1value,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdQMB', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyThresholdQMBvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/magiMonthlyThresholdSLMB', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as magiMonthlyThresholdSLMBvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/medicaidTermDate', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as medicaidTermDatevalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/origDueDate', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as origDueDatevalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/outcomeReasonCd', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as outcomeReasonCdvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/outcomeReasonCdCHIP', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as outcomeReasonCdCHIPvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/outcomeReasonCdMSP', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as outcomeReasonCdMSPvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/outcomeReasonCdMSPOnly', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as outcomeReasonCdMSPOnlyvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/outcomeReasonCdStd', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput')  as outcomeReasonCdStdvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/programEndMed', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as programEndMedvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/programEndchip', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as programEndchipvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/recipientChoicesInd', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as recipientChoicesIndvalue,
EXTRACTVALUE(xmltype(xd), '/letterOut/letterOutMember/spendDownAmount', 'xmlns=http://data.letters.share.sdc.maximus.com/schema/LetterOutput') as spendDownAmountValue



from 
(
Select 
LETTER_OUT_DATA_ID  
,   LETTER_REQ_ID 
,   JOB_ID 
,   CREATE_TS 
,   UPDATE_TS  
,   UPDATED_BY
,   FILTERED_LETTER_CONTENT xd
,   ORIGINAL_LETTER_CONTENT
FROM LETTER_OUT_DATA_CONTENT

);