
UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EngLanguage'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'HILanguage'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'IVR' 
WHERE UNIT_OF_WORK_NAME = 'IVR'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'Individual'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'OtherLanguage'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'SHOP'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'Unknown' 
WHERE UNIT_OF_WORK_NAME = 'Unknown'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'WEBCHAT' 
WHERE UNIT_OF_WORK_NAME = 'WebChat'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='HI HIX');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CES English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CES Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'General English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'General Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'Health Connect English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'Health Connect Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ICP English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ICP Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'MMAI English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'MMAI Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'VMC English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'VMC Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EB');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EEV English'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EEV');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EEV Spanish'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='IL EEV');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES EN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES SEU  EN and ES SLAQ EN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES SEU  SP and ES SLAQ SP'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES SEU EN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES SEU SP'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'ES SP'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Eligibility Support');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP ENG VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP FREW ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP FREW SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP PROVIDER'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP SEU ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP SEU SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP SPN VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'CHIP SUPERVISOR'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB FREW ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'EB FREW ENG VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB FREW SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'EB FREW SPN VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB MBIC ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB MBIC SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB NONFREW ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB NONFREW SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB PROVIDER'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EB SUPERVISOR'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'OUTBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'EBS_OUTBOUND'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'N/A' 
WHERE UNIT_OF_WORK_NAME = 'N/A'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'STAR Plus NonFrew EN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'STAR Plus NonFrew SP'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'THS ENG VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'THS FREW ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'THS FREW SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'VOICEMAIL' 
WHERE UNIT_OF_WORK_NAME = 'THS SPN VM'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'THS SSU ENG'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

UPDATE CC_D_UNIT_OF_WORK 
SET UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL' 
WHERE UNIT_OF_WORK_NAME = 'THS SSU SPN'
AND D_PROJECT_ID = (SELECT D_PROJECT_ID FROM D_PROJECT WHERE PROJECT_NAME='TX Enrollment Broker');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.10','003','003_UPDATE_CC_D_UNIT_OF_WORK');

COMMIT;