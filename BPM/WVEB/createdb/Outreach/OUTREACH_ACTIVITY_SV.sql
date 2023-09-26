CREATE OR REPLACE VIEW OUTREACH_ACTIVITY_SV
AS
  SELECT s.outreach_session_id ,
    s.request_date ,
    s.schedule_date ,
    TRUNC(h.create_ts) AS complete_date ,
    s.status_cd ,
    s.event_type_cd ,
    so.attendance number_of_attendees ,
    oo.name location_name ,
    oo.address_line_1 ,
    oo.address_line_2 ,
    oo.city ,
    oo.state_cd ,
    oo.zipcode ,
    oo.zipcode_four ,
    ec.report_label county ,
    st.first_name||' '||st.last_name created_by_name
  FROM eb.outreach_session s
  JOIN eb.outreach_session_outcome so ON s.outreach_session_id = so.outreach_session_id
  JOIN eb.outreach_organization oo    ON s.organization_id = oo.outreach_organization_id
  JOIN enum_county ec                 ON oo.county_cd = ec.value
  LEFT JOIN staff st                  ON (TO_CHAR(st.staff_id) = s.created_by)
  LEFT JOIN eb.outreach_session_status_hist h ON (h.status_cd = 'COMPLETED' AND s.outreach_session_id = h.outreach_session_id)
  WHERE s.schedule_date >= add_months(TRUNC(sysdate,'mm'),-2) ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.OUTREACH_ACTIVITY_SV TO EB_MAXDAT_REPORTS;