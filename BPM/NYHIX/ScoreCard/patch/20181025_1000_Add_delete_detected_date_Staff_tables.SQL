ALTER TABLE maxdat.PP_WFM_staff
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_task_category
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_staff_group
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_event_type
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_supervisor
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_staff_group_to_staff
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_event_type_group
  ADD DELETE_DETECTED_DATE DATE;

ALTER TABLE maxdat.PP_WFM_supervisor_to_staff
  ADD DELETE_DETECTED_DATE DATE;

commit;

/