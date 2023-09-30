/*
Created on 11/23/2015 by Raj A.
Description:
Created per NYHIX-18563.
*/
UPDATE CC_D_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Training',
       IS_PAID_FLAG = 1
WHERE activity_type_name = 'Voter Reg CBT';
UPDATE CC_D_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Lunch and Break',
       IS_PAID_FLAG = 1
WHERE activity_type_name = 'SP Break';

UPDATE CC_C_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Training',
       IS_PAID_FLAG = 1
  WHERE activity_type_name = 'Voter Reg CBT';
UPDATE CC_C_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Lunch and Break',
       IS_PAID_FLAG = 1
WHERE activity_type_name = 'SP Break';
COMMIT;
