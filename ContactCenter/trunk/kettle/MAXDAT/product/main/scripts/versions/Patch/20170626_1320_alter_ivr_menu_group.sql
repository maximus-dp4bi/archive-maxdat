  CREATE OR REPLACE FORCE VIEW CC_F_IVR_MENU_DATE_SV (F_IVR_MENU_GROUP_ID, D_DATE_ID, IVR_MENU_NAME, IVR_SUB_MENU_NAME, D_PROJECT_ID, D_PROGRAM_ID,
  IVR_CALL_COUNT, CREATE_DATE, LAST_UPDATE_DATE, LAST_UPDATE_BY)
  AS 
  SELECT CC_F_IVR_MENU_GROUP_DATE.F_IVR_MENU_GROUP_ID, CC_F_IVR_MENU_GROUP_DATE.D_DATE_ID, 
  CC_F_IVR_MENU_GROUP_DATE.IVR_MENU_NAME, CC_F_IVR_MENU_GROUP_DATE.IVR_SUB_MENU_NAME, CC_D_PROJECT.PROJECT_ID, CC_D_PROGRAM.PROGRAM_ID,
  CC_F_IVR_MENU_GROUP_DATE.IVR_CALL_COUNT, CC_F_IVR_MENU_GROUP_DATE.CREATE_DATE, CC_F_IVR_MENU_GROUP_DATE.LAST_UPDATE_DATE, CC_F_IVR_MENU_GROUP_DATE.LAST_UPDATE_BY
  FROM
  CC_F_IVR_MENU_GROUP_DATE
  INNER JOIN CC_C_IVR_MENU_GROUP ON CC_F_IVR_MENU_GROUP_DATE.IVR_SUB_MENU_NAME = CC_C_IVR_MENU_GROUP.IVR_SUB_MENU_NAME 
  INNER JOIN CC_D_PROJECT ON CC_C_IVR_MENU_GROUP.PROJECT_NAME = CC_D_PROJECT.PROJECT_NAME
  INNER JOIN CC_D_PROGRAM ON CC_C_IVR_MENU_GROUP.PROGRAM_NAME = CC_D_PROGRAM.PROGRAM_NAME
  WHERE CC_F_IVR_MENU_GROUP_DATE.IVR_MENU_NAME = CC_C_IVR_MENU_GROUP.IVR_MENU_NAME;
  
CREATE OR REPLACE FORCE VIEW CC_F_IVR_MENU_GROUP_DATE_SV (D_DATE_ID, D_PROJECT_ID, D_PROGRAM_ID, IVR_MENU_GROUP_NAME, IVR_CALL_COUNT) AS 
  SELECT CC_F_IVR_MENU_GROUP_DATE.D_DATE_ID, CC_D_PROJECT.PROJECT_ID, CC_D_PROGRAM.PROGRAM_ID, CC_C_IVR_MENU_GROUP.IVR_MENU_GROUP_NAME, SUM(IVR_CALL_COUNT)
    FROM
    CC_F_IVR_MENU_GROUP_DATE
    INNER JOIN CC_C_IVR_MENU_GROUP ON CC_F_IVR_MENU_GROUP_DATE.IVR_SUB_MENU_NAME = CC_C_IVR_MENU_GROUP.IVR_SUB_MENU_NAME 
    INNER JOIN CC_D_PROJECT ON CC_C_IVR_MENU_GROUP.PROJECT_NAME = CC_D_PROJECT.PROJECT_NAME
    INNER JOIN CC_D_PROGRAM ON CC_C_IVR_MENU_GROUP.PROGRAM_NAME = CC_D_PROGRAM.PROGRAM_NAME
    WHERE CC_F_IVR_MENU_GROUP_DATE.IVR_MENU_NAME = CC_C_IVR_MENU_GROUP.IVR_MENU_NAME
  GROUP BY CC_F_IVR_MENU_GROUP_DATE.D_DATE_ID, CC_D_PROJECT.PROJECT_ID, CC_D_PROGRAM.PROGRAM_ID, CC_C_IVR_MENU_GROUP.IVR_MENU_GROUP_NAME;
 
 
  GRANT SELECT ON CC_F_IVR_MENU_DATE_SV TO MAXDAT_READ_ONLY;
  GRANT SELECT ON CC_F_IVR_MENU_GROUP_DATE_SV TO MAXDAT_READ_ONLY;
  
alter table cc_f_ivr_menu_group_date
drop column ivr_menu_group_name;