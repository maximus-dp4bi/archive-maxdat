select s.outreach_session_id
       ,s.request_date
       ,s.schedule_date
       ,s.status_cd
       ,s.event_type_cd
       ,so.attendance number_of_attendees       
       ,oo.name location_name
       ,oo.address_line_1
       ,oo.address_line_2
       ,oo.city
       ,oo.state_cd
       ,oo.zipcode
       ,oo.zipcode_four
from eb.outreach_session s, eb.outreach_session_outcome so, eb.outreach_organization oo
where s.outreach_session_id = so.outreach_session_id
and s.organization_id = oo.outreach_organization_id
AND s.request_date >= add_months(trunc(sysdate,'mm'),-2)
